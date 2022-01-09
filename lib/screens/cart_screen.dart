import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:local_resturant/functions/pay.dart';
import 'package:local_resturant/functions/show_snack.dart';
import 'package:local_resturant/models/food.dart';
import 'package:local_resturant/providers/cart_provider.dart';
import 'package:local_resturant/providers/display_provider.dart';
import 'package:local_resturant/screens/food_details.dart';
import 'package:local_resturant/screens/home.dart';
import 'package:local_resturant/values/color.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Order',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Consumer<CartProvider>(
              builder: (context, model, child) {
                List<Food> foodList = model.items;
                return foodList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_bag,
                              size: 78,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Your Cart is Empty",
                              style: TextStyle(fontSize: 24),
                            ),
                            SizedBox(height: 16),
                            RaisedButton(
                              color: mainBlue,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text("See Available Foods/Snacks"),
                              onPressed: () {
                                var display =
                                    context.read<AppDisplayProvider>();
                                display.changeTo(HomePage());
                              },
                            )
                          ],
                        ),
                      )
                    : Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 100.0),
                            child: ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(height: 12),
                              itemCount: foodList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var item = foodList[index];
                                return InkWell(
                                  onTap: () {
                                    showSnack(context, FoodDetails(item));
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 64,
                                        height: 64,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          color: mainColor,
                                          image: DecorationImage(
                                            image: ExactAssetImage(
                                              // 'images/cart.png',
                                              "${item.image}",
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 8.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "${item.name}",
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black87,
                                                            fontSize: 15.0,
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          var addRemove =
                                                              context.read<
                                                                  CartProvider>();
                                                          addRemove
                                                              .addRemoveFood(
                                                                  item);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Icon(Icons
                                                              .remove_circle_outline),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Quantity: ${item.quantity}",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black87,
                                                                fontSize: 14.5,
                                                              ),
                                                            ),
                                                            Text(
                                                              "NGN ${item.price}",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black54,
                                                                fontSize: 13.5,
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Divider()
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: Consumer<CartProvider>(
                              builder: (c, model, w) => InkWell(
                                onTap: () => payForProduct(
                                  context: context,
                                  price: (model.totalPrice * 100).floor(),
                                  customerEmail: "ayo@gmail.com",
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: mainBlue,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Total: NGN ${model.totalPrice}",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Tap to Pay",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
