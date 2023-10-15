import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/profile/presentation/bloc/user_bloc.dart';
import 'package:pos_flutter/features/profile/presentation/bloc/user_state.dart';

class MenuScren extends StatefulWidget {
  const MenuScren({super.key});

  @override
  State<MenuScren> createState() => _MenuScrenState();
}

class _MenuScrenState extends State<MenuScren> {
  late UserBloc userBloc;

  @override
  void initState() {
    userBloc = context.read<UserBloc>();
    userBloc.getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      bloc: userBloc,
      buildWhen: (prev, next) {
        return (next is SuccessGetUser || next is LoadingUserState);
      },
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is LoadingUserState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is SuccessGetUser) {
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
                            "${state.user.name}",
                            style: textTheme().titleLarge,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: verticalPadding,
                  ),
                  _itemMenu(
                    menuName: "Profile",
                    icon: Icons.person,
                    navigationRoute: '/profile',
                  ),
                  _itemMenu(
                    menuName: "Products",
                    icon: Icons.dashboard,
                    navigationRoute: '/products',
                  ),
                  _itemMenu(
                    menuName: "Donation",
                    icon: Icons.wallet,
                    navigationRoute: '/donations',
                  ),
                  _itemMenu(
                    menuName: "Managemen Kurir",
                    icon: Icons.wallet,
                    navigationRoute: '/list-kurir',
                  ),
                  _itemMenu(
                    menuName: "Logout",
                    icon: Icons.wallet,
                    navigationRoute: '/logout',
                  ),
                ],
              ),
            ),
          );
        }

        return Container(
          child: Text("$state"),
        );
      },
    );
  }
}

class _itemMenu extends StatelessWidget {
  const _itemMenu({
    super.key,
    required this.icon,
    required this.menuName,
    required this.navigationRoute,
  });
  final String menuName;

  final IconData icon;
  final String navigationRoute;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(primaryColor),
                  backgroundColor: MaterialStateProperty.resolveWith((states) =>
                      states.contains(MaterialState.pressed)
                          ? Colors.grey.shade300
                          : Colors.transparent),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0))),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                      vertical: verticalPadding / 2,
                      horizontal: horizontalPadding / 2))),
              onPressed: () {
                navigatorKey.currentState?.pushNamed(navigationRoute);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(icon),
                      SizedBox(
                        width: horizontalPadding / 2,
                      ),
                      Text(
                        menuName,
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
    );
  }
}
