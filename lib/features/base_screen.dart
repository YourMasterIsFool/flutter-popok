import 'package:flutter/material.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/config/route/custom_router.dart';
import 'package:pos_flutter/features/dashboard/presentation/widget/dashboard_screen.dart';
import 'package:pos_flutter/features/profile/presentation/screen/profile_screen.dart';
// import 'package:pos_flutter/features/dashboard/presentation/widget/dashboard_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  GlobalKey<NavigatorState> baseScreenNavigator = GlobalKey<NavigatorState>();
  @override
  List<Map<String, dynamic>> screens = [
    {
      'name': '/',
    },
    {'name': '/menu'},
    {'name': '/donasi'},
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    DashboardScreen(),
    Text(
      'Index 1: Business',
      //  style: optionStyle,
    ),
    Text(
      'Index 2: School',
      //  style: optionStyle,
    ),
  ];

  int selectedIndex = 0;

  void _onTap(index) {
    setState(() {
      selectedIndex = index;
    });
    baseScreenNavigator.currentState
        ?.pushReplacementNamed(screens[index]['name'] as String);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: baseScreenNavigator,
        initialRoute: '/',
        onGenerateRoute: CustomRouter.baseScreenGenerateRoute,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: _onTap,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.propane_rounded), label: "Products"),
          BottomNavigationBarItem(
              icon: Icon(Icons.propane_rounded), label: "Donasi"),
        ],
      ),
    );
  }
}
