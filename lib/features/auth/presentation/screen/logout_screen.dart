import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_bloc.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  late AuthBloc _authBloc;
  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();
    Future.delayed(Duration(seconds: 2)).then((value) {
      _authBloc.logoutHandler();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Row(
          children: [
            Text(
              "Logout",
              style: textTheme().titleLarge,
            ),
            SizedBox(
              width: horizontalPadding / 2,
            ),
            CircularProgressIndicator()
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    ));
  }
}
