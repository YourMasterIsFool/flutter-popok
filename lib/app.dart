import 'package:flutter/material.dart';
import 'package:pos_flutter/config/route/custom_router.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: myTheme(),
      onGenerateRoute: CustomRouter.onGenerateRoute,

      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
