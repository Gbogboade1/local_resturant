import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:local_resturant/providers/cart_provider.dart';
import 'package:local_resturant/providers/display_provider.dart';
import 'package:local_resturant/providers/favorite_provider.dart';
import 'package:local_resturant/screens/dash_board_page.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ListenableProvider(create: (context) => AppDisplayProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var publicKey = 'pk_test_f992d2a95e3dcdb09eccbd14dcbe123acb7854fb';
  //TODO("ENTER PUBLIC KEY for Paystack")
  @override
  void initState() {
    super.initState();
    PaystackPlugin.initialize(publicKey: publicKey);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Local Resturant',
      debugShowCheckedModeBanner: false,
      home: DashBoardPage(),
    );
  }
}
