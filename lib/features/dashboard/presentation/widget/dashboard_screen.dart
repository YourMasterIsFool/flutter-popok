import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popoku"),
        actions: [
          IconButton(
              color: Colors.black,
              onPressed: () {},
              icon: Icon(Icons.person_rounded))
        ],
      ),
    );
  }
}