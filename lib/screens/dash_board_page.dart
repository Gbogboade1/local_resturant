import 'package:flutter/material.dart';
import 'package:local_resturant/providers/cart_provider.dart';
import 'package:local_resturant/screens/cart_screen.dart';
import 'package:provider/provider.dart';
import 'package:local_resturant/models/item_model.dart';
import 'package:local_resturant/providers/display_provider.dart';
import 'package:local_resturant/values/color.dart';
import 'package:local_resturant/functions/show_snack.dart';
import 'package:local_resturant/widget/clippers/menuClip.dart';
import 'package:local_resturant/screens/home.dart';
import 'package:local_resturant/screens/invoice.dart';
import 'package:local_resturant/screens/messages.dart';
import 'package:local_resturant/screens/profile.dart';
import 'package:local_resturant/screens/search.dart';

class DashBoardPage extends StatelessWidget {
  List<Item> appBarItem = [
    Item(
      title: 'My Profile',
      body: ProfileScreen(),
    ),
    Item(
      title: 'Messages  ',
      body: MessagesScreen(),
    ),
    Item(
      title: 'Invoice   ',
      body: InvoiceScreen(),
    ),
    Item(
      title: 'Home      ',
      body: HomePage(),
    ),
  ];
  BuildContext context;
  @override
  Widget build(BuildContext c) {
    context = c;
    Size size = MediaQuery.of(context).size;
    print("r...");
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 40),
        width: size.width,
        child: Stack(
          children: <Widget>[
            buildMenuBar(size),
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                left: 68,
                right: 16,
                bottom: 16,
              ),
              child: Consumer<AppDisplayProvider>(
                builder: (context, model, child) {
                  return model.body;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuBar(Size size) {
    return ClipPath(
      clipper: MenuClip(),
      child: Container(
        height: size.height,
        width: 55,
        color: mainColor,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 72,
            ),
            Image.asset(
              'images/menu.png',
              width: 50,
              height: 50,
            ),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                showSnack(context, SafeArea(child: Searchscreen()));
              },
              child: Image.asset(
                'images/Search.png',
                width: 50,
                height: 50,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Expanded(
              child: Consumer<AppDisplayProvider>(
                builder: (context, model, child) => Column(
                  children: List.generate(
                    appBarItem.length,
                    (index) {
                      Item item = appBarItem[index];
                      return Expanded(
                        child: buildRotatedBox(
                          '${item.title}',
                          isSelected: model.body == item.body,
                          onPressed: () {
                            var display = context.read<AppDisplayProvider>();
                            display.changeTo(item.body);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                var display = context.read<AppDisplayProvider>();
                display.changeTo(CartScreen());
              },
              child: Consumer<CartProvider>(
                builder: (context, model, child) {
                  var itemLength = model.getCartItemLenght();
                  return Container(
                    child: Stack(
                      children: [
                        Image.asset(
                          'images/cart.png',
                          width: 50,
                          height: 50,
                        ),
                        Positioned(
                          right: 0,
                          child: Visibility(
                            visible: itemLength > 0,
                            child: Container(
                              width: 24,
                              height: 24,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.red[900],
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Center(
                                child: Text(
                                  "$itemLength",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 58,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRotatedBox(
    String text, {
    bool isSelected: false,
    onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: RotatedBox(
        quarterTurns: -1,
        child: Container(
          // width: 120,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: isSelected ? mainBlue : Colors.transparent,
              ),
              child: Text(
                text,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
