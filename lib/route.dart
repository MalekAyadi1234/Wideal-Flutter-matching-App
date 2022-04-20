import 'package:flutter/material.dart';
import 'package:wideal/screens/collection_page.dart';
import 'package:wideal/screens/detail_page.dart';
import 'package:wideal/screens/homepage.dart';
import 'package:wideal/screens/start_page.dart';
import 'package:wideal/ui/login/createaccount.dart';
import 'package:wideal/ui/login/forgot.dart';
import 'package:wideal/ui/login/login.dart';
import 'package:wideal/ui/main/Delivery/delivery.dart';
import 'package:wideal/ui/main/categoryDetails.dart';
import 'package:wideal/ui/main/mainscreen.dart';
import 'package:wideal/ui/main/productsDetails/dishesDetails.dart';
import 'package:wideal/ui/main/restaurantDetails.dart';

class AppFoodRoute {
  Map<String, StatefulWidget> routes = {
    "/login": LoginScreen(),
    "/forgot": ForgotScreen(),
    "/createaccount": CreateAccountScreen(),
    "/main": MainScreen(),
    "/dishesdetails": DishesDetailsScreen(),
    "/restaurantdetails": RestaurantDetailsScreen(),
    "/categorydetails": CategoryDetailsScreen(),
    // "/basket" : BasketScreen(),
    "/delivery": DeliveryScreen(),
    "/detailPage": DetailPage(),
    "/collection": CollectionPage(),
    "/home": HomePage(),
    "/start": StartPage(),
  };

  //MainScreen mainScreen;
  List<StatefulWidget> _stack = [];

  int _seconds = 0;

  disposeLast() {
    if (_stack.isNotEmpty) _stack.removeLast();
    _printStack();
  }

  setDuration(int seconds) {
    _seconds = seconds;
  }

  push(BuildContext _context, String name) {
    var _screen = routes[name];
    // if (name == "/main")
    //   mainScreen = _screen;
    _stack.add(_screen!);
    _printStack();
    Navigator.push(
      _context,
      PageRouteBuilder(
        transitionDuration: Duration(seconds: _seconds),
        pageBuilder: (_, __, ___) => _screen,
      ),
    );
    _seconds = 0;
  }

  pushToStart(BuildContext _context, String name) {
    var _screen = routes[name];
    // if (name == "/main")
    //   mainScreen = _screen;
    _stack.clear();
    _stack.add(_screen!);
    _printStack();
    Navigator.pushAndRemoveUntil(
        _context,
        PageRouteBuilder(
          transitionDuration: Duration(seconds: _seconds),
          pageBuilder: (_, __, ___) => _screen,
        ),
        (route) => false);
    _seconds = 0;
  }

  _printStack() {
    var str = "Screens Stack: ";
    for (var item in _stack) str = "$str -> $item";
    print(str);
  }

  pop(BuildContext context) {
    Navigator.pop(context);
  }

  popToMain(BuildContext context) {
    var _lenght = _stack.length;
    for (int i = 0; i < _lenght - 1; i++) {
      if (Navigator.canPop(context)) pop(context);
    }
  }
}
