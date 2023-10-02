import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_flutter/features/article/presentation/screens/article_screen.dart';
import 'package:pos_flutter/features/auth/presentation/screen/login_screen.dart';
import 'package:pos_flutter/features/auth/presentation/screen/signup_screen.dart';
import 'package:pos_flutter/features/base_screen.dart';
import 'package:pos_flutter/features/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:pos_flutter/features/donation/presentation/screen/donation_form_screen.dart';
import 'package:pos_flutter/features/donation/presentation/screen/list_donasi.dart';
import 'package:pos_flutter/features/menu/presentation/screen/menu_screen.dart';
import 'package:pos_flutter/features/product/presentation/screen/product_detail.dart';
import 'package:pos_flutter/features/profile/presentation/screen/profile_screen.dart';

class CustomRouter {
  static Route<dynamic> baseScreenGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DashboardScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero);
      case '/menu':
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                MenuScren(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero);

      case '/donasi':
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ListDonasiScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero);

      default:
        return MaterialPageRoute(builder: (context) => Scaffold());
    }
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (context) => SignupScreen());
      case '/profile':
        return MaterialPageRoute(builder: (context) => ProfileScreen());
      case '/form-donate':
        return MaterialPageRoute(builder: (context) => DonationFormScreen());
      case '/article':
        return MaterialPageRoute(builder: (context) => ArticleScreen());
      case '/':
        return MaterialPageRoute(builder: (context) => BaseScreen());
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
