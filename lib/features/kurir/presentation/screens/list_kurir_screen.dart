import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/profile/presentation/bloc/user_bloc.dart';
import 'package:pos_flutter/features/profile/presentation/bloc/user_state.dart';

class ListKurirScreen extends StatefulWidget {
  const ListKurirScreen({super.key});

  @override
  State<ListKurirScreen> createState() => _ListKurirScreenState();
}

class _ListKurirScreenState extends State<ListKurirScreen> {
  late UserBloc _userBloc;

  @override
  void initState() {
    _userBloc = context.read<UserBloc>();

    _userBloc.getListKurir();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      bloc: _userBloc,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is LoadingGetListUser) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is SuccessGetListUser) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Manajemen kurir "),
              actions: [
                IconButton(
                    onPressed: () {
                      navigatorKey.currentState?.pushNamed('/form-kurir');
                    },
                    icon: Icon(Icons.add))
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: verticalPadding / 2,
                  ),
                  ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                            bottom: 12.h, left: 12.w, right: 12.w),
                        decoration: BoxDecoration(
                            boxShadow: [
                              // BoxShadow(
                              //     offset: Offset(0, 1),
                              //     spreadRadius: 20,
                              //     blurRadius: 10,
                              //     color: Colors.grey.withOpacity(0.2))
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Stack(children: [
                          GestureDetector(
                            child: Container(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 75,
                                    height: 75,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 4.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${state.listUser[index].name}",
                                          style: textTheme().bodyLarge,
                                        ),
                                        SizedBox(
                                          height: 2.h,
                                        ),
                                        Text(
                                          "${state.listUser[index].email}",
                                          style: textTheme().titleMedium,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ]),
                      );
                    },
                    itemCount: state.listUser.length,
                  )
                ],
              ),
            ),
          );
        }
        return Scaffold();
      },
    );
  }
}
