import 'package:flutter/material.dart';
import 'package:pos_flutter/config/route/custom_router.dart';
import 'package:pos_flutter/config/secure_storage/secure_storage.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  App({super.key});

  String? token = '';

  void getToken() async {
    // await SecureStorage().removeAllSecureStorage();
    token = await SecureStorage().getToken();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo ',
      navigatorKey: navigatorKey,
      theme: myTheme(),
      initialRoute: '/login',
      onGenerateRoute: CustomRouter.onGenerateRoute,

      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
