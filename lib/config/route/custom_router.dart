import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_flutter/features/article/presentation/screens/article_detail_screen.dart';
import 'package:pos_flutter/features/article/presentation/screens/article_form_screen.dart';
import 'package:pos_flutter/features/article/presentation/screens/article_screen.dart';
import 'package:pos_flutter/features/auth/presentation/screen/change_pasword.dart';
import 'package:pos_flutter/features/auth/presentation/screen/forgot_password_email.dart';
import 'package:pos_flutter/features/auth/presentation/screen/hint_password.dart';
import 'package:pos_flutter/features/auth/presentation/screen/login_screen.dart';
import 'package:pos_flutter/features/auth/presentation/screen/logout_screen.dart';
import 'package:pos_flutter/features/auth/presentation/screen/signup_screen.dart';
import 'package:pos_flutter/features/base_screen.dart';
import 'package:pos_flutter/features/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:pos_flutter/features/donation/presentation/screen/donation_form_screen.dart';
import 'package:pos_flutter/features/donation/presentation/screen/list_donasi.dart';
import 'package:pos_flutter/features/kegiatan/presentation/screens/kegiatan_screen.dart';
import 'package:pos_flutter/features/kurir/presentation/screens/fomr_kurir_screen.dart';
import 'package:pos_flutter/features/kurir/presentation/screens/list_kurir_screen.dart';
import 'package:pos_flutter/features/menu/presentation/screen/menu_screen.dart';
import 'package:pos_flutter/features/order/presentation/screens/order_detail_screen.dart';
import 'package:pos_flutter/features/order/presentation/screens/order_list_screen.dart';
import 'package:pos_flutter/features/pelatihan/presentation/screens/pelatihan_detail_screen.dart';
import 'package:pos_flutter/features/pelatihan/presentation/screens/pelatihan_form_screen.dart';
import 'package:pos_flutter/features/pelatihan/presentation/screens/pelatihan_screen.dart';
import 'package:pos_flutter/features/product/presentation/screen/product_detail.dart';
import 'package:pos_flutter/features/product/presentation/screen/product_form.dart';
import 'package:pos_flutter/features/product/presentation/screen/product_list.dart';
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
      case '/order-list':
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                OrderListScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero);

      default:
        return MaterialPageRoute(builder: (context) => Scaffold());
    }
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/donasi':
        return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ListDonasiScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero);
      case '/login':
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (context) => SignupScreen());
      case '/profile':
        return MaterialPageRoute(builder: (context) => ProfileScreen());
      case '/form-donate':
        var map = {};
        if (settings.arguments != null) {
          map = settings.arguments as Map<String, dynamic>;
        }

        return MaterialPageRoute(
            builder: (context) => DonationFormScreen(
                  id: map['id'],
                ));

      case '/pelatihan':
        return MaterialPageRoute(builder: (context) => PelatihanScreen());
      case '/forgot-password-email':
        return MaterialPageRoute(
            builder: (context) => ForgotPasswordEmailScreen());
      case '/forgot-password-hint':
        return MaterialPageRoute(builder: (context) => HintPasswordScreen());
      case '/forgot-password-new-password':
        return MaterialPageRoute(builder: (context) => ChangeNewPassword());
      case '/form-kurir':
        return MaterialPageRoute(builder: (context) => FormKurirScreen());
      case '/list-kurir':
        return MaterialPageRoute(builder: (context) => ListKurirScreen());
      case '/pelatihan-form':
        return MaterialPageRoute(builder: (context) => PelatihanFormScreen());
      case '/pelatihan-detail':
        var map = {};
        if (settings.arguments != null) {
          map = settings.arguments as Map<String, dynamic>;
        }
        return MaterialPageRoute(
            builder: (context) => PelatihanDetailScreen(
                  id: map['id'],
                ));
      case '/order':
        return MaterialPageRoute(builder: (context) => OrderListScreen());
      case '/article':
        return MaterialPageRoute(builder: (context) => ArticleScreen());

      case '/article-detail':
        var map = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
            builder: (context) => ArticleDetailScreen(
                  id: map['id'] ?? 0,
                ));
      case '/article-form':
        var map = {};
        if (settings.arguments != null) {
          map = settings.arguments as Map<String, dynamic>;
        }
        return MaterialPageRoute(
            builder: (context) => ArticleFormScreen(
                  id: map['id'] ?? 0,
                ));
      case '/':
        return MaterialPageRoute(builder: (context) => BaseScreen());
      case '/product-detail':
        var map = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
                  id: map['id'],
                ));
      case '/logout':
        return MaterialPageRoute(builder: (context) => LogoutScreen());
      case '/product-form':
        var map = {};
        if (settings.arguments != null) {
          map = settings.arguments as Map<String, dynamic>;
        }
        return MaterialPageRoute(
            builder: (context) => ProductFormScreen(
                  id: map['id'],
                ));
      case '/product':
        return MaterialPageRoute(builder: (context) => ProductListScreen());

      case '/order-detail':
        var map = {};
        if (settings.arguments != null) {
          map = settings.arguments as Map<String, dynamic>;
        }
        return MaterialPageRoute(
            builder: (context) => OrderDetailScreen(
                  id: map['id'],
                ));
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
