import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/config/secure_storage/secure_storage.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? token = '';

  Future<void> getToken() async {
    setState(() async {
      final getToken = await SecureStorage().getToken();
      print(getToken);
      token = getToken;
    });
  }

  @override
  void initState() {
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("POPOKKU ${token}"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: verticalPadding * 2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding / 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      navigatorKey.currentState?.pushNamed('/form-donate');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 6),
                                color: Colors.grey.shade300,
                                blurRadius: 20.0,
                                spreadRadius: 1)
                          ]),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Donasi Popok"),
                          SizedBox(
                            height: verticalPadding / 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(LineariconsFree.chevron_right_circle),
                              SvgPicture.asset(
                                'assets/svgs/diaper-svgrepo-com.svg',
                                width: 40,
                                height: 40,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
                  SizedBox(
                    width: horizontalPadding,
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 6),
                                color: Colors.grey.shade300,
                                blurRadius: 20.0,
                                spreadRadius: 1)
                          ]),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Cari Product"),
                          SizedBox(
                            height: verticalPadding / 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(LineariconsFree.chevron_right_circle),
                              SvgPicture.asset(
                                'assets/svgs/play-ball-ball-svgrepo-com.svg',
                                width: 40,
                                height: 40,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
            SizedBox(
              height: verticalPadding,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding / 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 6),
                                color: Colors.grey.shade300,
                                blurRadius: 20.0,
                                spreadRadius: 1)
                          ]),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Pelatihan"),
                          SizedBox(
                            height: verticalPadding / 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(LineariconsFree.chevron_right_circle),
                              SvgPicture.asset(
                                'assets/svgs/rattle-svgrepo-com.svg',
                                width: 40,
                                height: 40,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
                  SizedBox(
                    width: horizontalPadding,
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      navigatorKey.currentState?.pushNamed('/article');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 6),
                                color: Colors.grey.shade300,
                                blurRadius: 20.0,
                                spreadRadius: 1)
                          ]),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Artikel"),
                          SizedBox(
                            height: verticalPadding / 2,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(LineariconsFree.chevron_right_circle),
                              SvgPicture.asset(
                                'assets/svgs/baby-svgrepo-com.svg',
                                width: 40,
                                height: 40,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
