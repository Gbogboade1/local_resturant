import 'package:flutter/material.dart';
import 'package:local_resturant/values/color.dart';
import 'package:local_resturant/models/food.dart';
import 'package:local_resturant/widget/foodItem.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  int currentTabIndex = 0;
  bool showAll = false;

  List<String> tabTitleList = [
    'Hamburger',
    '  Pizza  ',
    'Shawarma ',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text(
          'Available \nFood & Snacks',
          style: TextStyle(fontSize: 30),
        ),
        SizedBox(
          height: 20,
        ),
        buildTabBar(),
        SizedBox(
          height: 20,
        ),
        Text(
          'Near You',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 200,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: getNearYouList().map((e) => FoodItem(e)).toList()),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Popular',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 200,
          child: ListView(
              scrollDirection: Axis.horizontal,
              children: getPopular().map((e) => FoodItem(e)).toList()),
        ),
        SizedBox(
          height: 20,
        ),
        buildViewAllText(),
      ],
    );
  }

  Widget buildTabBar() {
    return Container(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
            tabTitleList.length,
            (index) => InkWell(
              onTap: () {
                setState(() {
                  currentTabIndex = index;
                });
              },
              child: index == currentTabIndex
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          )),
                      child: Center(
                        child: Text(
                          '${tabTitleList[index]}',
                          maxLines: 1,
                        ),
                      ),
                    )
                  : Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      child: Center(
                        child: Text(
                          '${tabTitleList[index]}',
                          maxLines: 1,
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  List<Food> getNearYouList() {
    List<Food> list = List.generate(
        7,
        (index) => Food(
            id: "n$index",
            image: 'images/Chicken_Hamburger.png',
            name: 'Chicken Hamburger $index',
            description: 'Fresh hamburger with \nchicken, salad, tomatoes.',
            isFave: true,
            price: 30.00));

    // list.add(Food('images/Chicken_Hamburger.png', 'Chicken Hamburger',
    //     'Fresh hamburger with \nchicken, salad, tomatoes.', true, 30.00));
    // list.add(Food('images/Dragon_Fruits_Salad.png', 'Dragon Fruits Salad',
    //     'A bit of avocado salad \nand some spinach stalks.', true, 18.00));

    // list.add(Food('images/Chicken_Hamburger.png', 'Chicken Hamburger',
    //     'Fresh hamburger with \nchicken, salad, tomatoes.', true, 30.00));
    // list.add(Food('images/Dragon_Fruits_Salad.png', 'Dragon Fruits Salad',
    //     'A bit of avocado salad \nand some spinach stalks.', true, 18.00));

    // list.add(Food('images/Chicken_Hamburger.png', 'Chicken Hamburger',
    //     'Fresh hamburger with \nchicken, salad, tomatoes.', true, 30.00));
    // list.add(Food('images/Dragon_Fruits_Salad.png', 'Dragon Fruits Salad',
    //     'A bit of avocado salad \nand some spinach stalks.', true, 18.00));

    return list;
  }

  List<Food> getPopular() {
    List<Food> list = List.generate(
        7,
        (index) => Food(
            id: "p$index",
            image: 'images/Chicken_Hamburger.png',
            name: 'Chicken Hamburger $index',
            description: 'Fresh hamburger with \nchicken, salad, tomatoes.',
            isFave: true,
            price: 30.00));

    // list.add(Food('images/Salmon_Sushi.png', 'Salmon Sushi',
    //     'Salmon, carrot rolls, \nspinach and some sauce.', false, 28.00));
    // list.add(Food('images/Avocado_Salad.png', 'Avocado Salad',
    //     'Fresh hamburger with \nchicken, salad, tomatoes.', true, 11.00));

    // list.add(Food('images/Salmon_Sushi.png', 'Salmon Sushi',
    //     'Salmon, carrot rolls, \nspinach and some sauce.', false, 28.00));
    // list.add(Food('images/Avocado_Salad.png', 'Avocado Salad',
    //     'Fresh hamburger with \nchicken, salad, tomatoes.', true, 11.00));

    return list;
  }

  Widget buildViewAllText() {
    return Row(
      children: <Widget>[
        Spacer(),
        InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(
              color: mainBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Text(
              'View All',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
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
}
