import 'package:flutter/material.dart';
import 'package:pos_flutter/features/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:pos_flutter/features/menu/presentation/screen/menu_screen.dart';
import 'package:pos_flutter/features/product/presentation/screen/product_detail.dart';

class CustomRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/menu':
        return MaterialPageRoute(builder: (context) => MenuScren());
      case '/':
        return MaterialPageRoute(builder: (context) => DashboardScreen());
      case '/product-detail':
        return MaterialPageRoute(builder: (context) => ProductDetail());
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    title: Text("Not Found"),
                  ),
                  body: Center(
                    child: Text("404 Not Found"),
                  ),
                ));
    }
  }
}
