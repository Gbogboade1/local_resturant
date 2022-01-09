import 'package:flutter/material.dart';
import 'package:local_resturant/functions/show_snack.dart';
import 'package:local_resturant/providers/favorite_provider.dart';
import 'package:local_resturant/values/color.dart';
import 'package:local_resturant/screens/food_details.dart';
import 'package:provider/provider.dart';

import '../models/food.dart';

class FoodItem extends StatelessWidget {
  Food food;

  FoodItem(this.food);
  BuildContext context;

  @override
  Widget build(BuildContext c) {
    context = c;
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        showSnack(context, FoodDetails(food));
      },
      child: Container(
        margin: EdgeInsets.only(right: 20),
        height: 200,
        width: size.width / 2,
        child: Stack(
          children: <Widget>[
            buildCard(),
            buildImage(),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return Hero(
      tag: UniqueKey(),
      child: Image.asset(
        food.image,
        width: 110,
        height: 110,
      ),
    );
  }

  Widget buildCard() {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 20),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            buildIcon(),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                'NGN ${food.price}',
                maxLines: 1,
                style: TextStyle(color: mainBlue, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                food.name,
                maxLines: 1,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                food.description,
                maxLines: 2,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildIcon() {
    return Row(
      children: <Widget>[
        Spacer(),
        InkWell(
          onTap: () {
            var isFav = context.read<FavoriteProvider>();
            isFav.toggleFav(food);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 9, vertical: 6),
            decoration: BoxDecoration(
                color: mainColorDark,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Consumer<FavoriteProvider>(
              builder: (context, model, child) => Image.asset(
                'images/Heart.png',
                width: 25,
                color: model.isFavorite(food) > -1 ? mainBlue : Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        )
      ],
    );
  }
}
