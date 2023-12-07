import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/CustomSnackbar.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_state.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late AuthBloc _authBloc;

  final emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _authBloc = context.read<AuthBloc>();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    emailController.dispose();
    super.dispose();
  }

  void checkEmailHandler() async {
    await _authBloc.checkEmailIsExist(emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        // TODO: implement listener
        if (state is LoadingForgotEmailState) {
          LoadingOverflay.of(context).open();
        }

        if (state is SuccesssForgotEmailState) {
          LoadingOverflay.of(context).close();
          // ScaffoldMessenger.of(context)
          //     .showSnackBar(CustomSnackbar().SuccessSnackbar(message: "check"));
          navigatorKey.currentState?.pushNamed('/forgot-password-hint');
        }
        if (state is ErrorForgotEmailState) {
          LoadingOverflay.of(context).close();

          ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
              .ErorrSnackbar(
                  message: state.error.response!.data['message'].toString()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Cari Akun"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: verticalPadding,
                  ),
                  Text(
                    "Cari Akunmu",
                    style: textTheme().titleLarge,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Masukkan email kamu:"),
                          SizedBox(
                            height: 6.h,
                          ),
                          TextFormField(
                            decoration: InputDecoration(label: Text("Email")),
                            controller: emailController,
                          ),
                          SizedBox(
                            height: verticalPadding,
                          ),
                          Container(
                            width: double.infinity,
                            child: TextButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    checkEmailHandler();
                                  }
                                },
                                child: Text("Cari Akun")),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
