import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/config/secure_storage/secure_storage.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pos_flutter/features/profile/presentation/bloc/user_bloc.dart';
import 'package:pos_flutter/features/profile/presentation/bloc/user_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? token = '';
  String? role_name = '';

  late UserBloc _userBloc;

  Future<void> getToken() async {
    final getToken = await SecureStorage().getToken();
    setState(() {
      print(getToken);
      token = getToken;
    });
  }

  Future<void> getRole() async {
    final getRole = await SecureStorage().getRole();
    setState(() {
      role_name = getRole;
    });
  }

  @override
  void initState() {
    getToken();
    _userBloc = context.read<UserBloc>();
    _userBloc.getCurrentUser();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getRole();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PopokCare"),
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.notifications))
        ],
      ),
      body: FutureBuilder(
          future: SecureStorage().getRole(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: verticalPadding,
                    ),
                    BlocConsumer<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is SuccessGetUser) {
                            return Padding(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Selamat Datang"),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Text(
                                      "${state.user.name}",
                                      style: textTheme().titleLarge,
                                    )
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: horizontalPadding / 2));
                          }

                          return Container();
                        },
                        listener: (context, state) {}),
                    SizedBox(
                      height: verticalPadding / 2,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding / 2),
                      child: ClipRRect(
                        child: Image.asset(
                          'assets/images/header_dashboard.jpg',
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(
                    //       horizontal: horizontalPadding / 2),
                    //   height: Image.asset('asset/images/'),
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: Colors.grey),
                    // ),
                    SizedBox(
                      height: verticalPadding / 2,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding / 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              navigatorKey.currentState?.pushNamed('/donasi');
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
                                  Text(
                                      "${snapshot.data == 'user' ? 'Donasi Popok' : 'Kelola Donasi'}"),
                                  SizedBox(
                                    height: verticalPadding / 2,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                          LineariconsFree.chevron_right_circle),
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
                            onTap: () {
                              navigatorKey.currentState?.pushNamed('/product');
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
                                  Text(
                                      "${snapshot.data == 'user' ? 'Produk' : 'Kelola Produk'}"),
                                  SizedBox(
                                    height: verticalPadding / 2,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(
                                          LineariconsFree.chevron_right_circle),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding / 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          snapshot.data != 'kurir'
                              ? Expanded(
                                  child: GestureDetector(
                                  onTap: () {
                                    navigatorKey.currentState
                                        ?.pushNamed('/pelatihan');
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${snapshot.data == 'user' ? 'Pelatihan' : 'Kelola Pelatihan'}"),
                                        SizedBox(
                                          height: verticalPadding / 2,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(LineariconsFree
                                                .chevron_right_circle),
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
                                ))
                              : Container(),
                          SizedBox(
                            width: horizontalPadding,
                          ),
                          snapshot.data != 'kurir'
                              ? Expanded(
                                  child: GestureDetector(
                                  onTap: () {
                                    navigatorKey.currentState
                                        ?.pushNamed('/article');
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${snapshot.data == 'user' ? 'Artikel' : 'Kelola Artikel'}"),
                                        SizedBox(
                                          height: verticalPadding / 2,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Icon(LineariconsFree
                                                .chevron_right_circle),
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
                              : Container()
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
