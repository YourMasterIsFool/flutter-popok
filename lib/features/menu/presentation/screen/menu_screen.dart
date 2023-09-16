import 'package:flutter/material.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';

class MenuScren extends StatefulWidget {
  const MenuScren({super.key});

  @override
  State<MenuScren> createState() => _MenuScrenState();
}

class _MenuScrenState extends State<MenuScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    SizedBox(
                      height: verticalPadding / 3,
                    ),
                    Text(
                      "Verrandy bagus",
                      style: textTheme().titleLarge,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: verticalPadding,
            ),
            Container(
              child: Column(
                children: [
                  TextButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll(primaryColor),
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => states.contains(MaterialState.pressed)
                                  ? Colors.grey.shade300
                                  : Colors.transparent),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0))),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  vertical: verticalPadding / 2,
                                  horizontal: horizontalPadding / 2))),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.person_3_outlined),
                              SizedBox(
                                width: horizontalPadding / 2,
                              ),
                              Text(
                                "Profile",
                                style: textTheme().titleMedium,
                              )
                            ],
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 26,
                          )
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
