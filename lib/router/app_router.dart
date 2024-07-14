import 'package:flutter/material.dart';

// Screens
import 'package:jantari/screens/main.dart';
import 'package:jantari/screens/products.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/':
      //   return MaterialPageRoute(builder: (_) => const Login());
      case '/':
        return MaterialPageRoute(builder: (_) => const Main());
      case '/products':
        return MaterialPageRoute(builder: (_) => const Products());
      default:
        return null;
    }
  }
}
