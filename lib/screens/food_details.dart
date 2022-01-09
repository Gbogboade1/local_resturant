import 'package:flutter/material.dart';
import 'package:local_resturant/providers/cart_provider.dart';
import 'package:local_resturant/providers/display_provider.dart';
import 'package:local_resturant/providers/favorite_provider.dart';
import 'package:local_resturant/screens/cart_screen.dart';
import 'package:local_resturant/values/color.dart';
import 'package:local_resturant/models/food.dart';
import 'package:local_resturant/widget/quantity_button.dart';
import 'package:provider/provider.dart';

class FoodDetails extends StatelessWidget {
  Food food;

  FoodDetails(this.food);
  BuildContext context;

  @override
  Widget build(BuildContext c) {
    context = c;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(.94),
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: <Widget>[
              buildAddtoCart(size),
              buildQty(size),
              buildBodyTop(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBodyTop(Size size) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: size.width,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(10),
        )),
        margin: EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    color: mainBlue),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            buildFaveIcon(),
            Center(
              child: Hero(
                tag: UniqueKey(),
                child: Image.asset(
                  food.image,
                  width: 250,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, top: 30),
              child: Text(
                '\$ ${food.price}',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 25, color: mainBlue),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, top: 10),
              child: Text(
                food.name,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, top: 10),
              child: Text(
                food.description,
                style: TextStyle(fontSize: 20, color: Colors.black54),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }

  Widget buildFaveIcon() {
    return Row(
      children: <Widget>[
        Spacer(),
        InkWell(
          onTap: () {
            var isFav = context.read<FavoriteProvider>();
            isFav.toggleFav(food);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            decoration: BoxDecoration(
                color: mainColorDark,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Consumer<FavoriteProvider>(
              builder: (context, model, child) => Image.asset(
                'images/Heart.png',
                color: model.isFavorite(food) > -1 ? mainBlue : Colors.white,
                width: 18,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 20,
        )
      ],
    );
  }

  Widget buildQty(Size size) {
    return Positioned(
      top: 500,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(10),
          ),
          color: mainColor,
        ),
        height: 150,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Consumer<CartProvider>(
            builder: (context, model, child) {
              var quantity = model.getFoodQuantity(food);
              return Visibility(
                visible: quantity > -1,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Quantity',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    AnimatedOpacity(
                      opacity: quantity > 1 ? 1 : .3,
                      duration: Duration(seconds: 2),
                      child: quantityButton(
                        icon: Icons.remove,
                        onPressed: quantity > 1
                            ? () {
                                var addRemove = context.read<CartProvider>();
                                addRemove.incDecFoodQuantity(food,
                                    isIncrease: false);
                              }
                            : null,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "$quantity",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    AnimatedOpacity(
                      opacity: quantity < 10 ? 1 : .3,
                      duration: Duration(seconds: 2),
                      child: quantityButton(
                        icon: Icons.add,
                        onPressed: quantity >= 10
                            ? null
                            : () {
                                var addRemove = context.read<CartProvider>();
                                addRemove.incDecFoodQuantity(food,
                                    isIncrease: true);
                              },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildAddtoCart(Size size) {
    return Positioned(
      top: 590,
      child: Consumer<CartProvider>(
        builder: (context, model, child) {
          var hasFood = model.cartHasFood(food) > -1;

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
                // bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(10),
              ),
              color: mainColorDark,
            ),
            width: size.width,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    var addRemove = context.read<CartProvider>();
                    addRemove.addRemoveFood(food);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: hasFood ? Colors.red[600] : mainBlue,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            hasFood ? "Remove from cart" : 'Add to cart',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border:
                                    Border.all(color: Colors.blueGrey[700])),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Close",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            var display = context.read<AppDisplayProvider>();
                            display.changeTo(CartScreen());
                          },
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: mainBlue,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Place Order",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
              ],
            ),
          );
        },
      ),
    );
  }
}
