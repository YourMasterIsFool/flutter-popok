import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/CustomSnackbar.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/config/secure_storage/secure_storage.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_state.dart';

class ChangeNewPassword extends StatefulWidget {
  const ChangeNewPassword({super.key});

  @override
  State<ChangeNewPassword> createState() => _ChangeNewPasswordState();
}

class _ChangeNewPasswordState extends State<ChangeNewPassword>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late AuthBloc _authBloc;

  final passwordCotroller = TextEditingController();
  final validasiPasswordController = TextEditingController();

  bool hidePassword = true;
  bool hidePasswordValidation = true;

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
    passwordCotroller.dispose();
    super.dispose();
  }

  void checkEmailHandler() async {
    await _authBloc.changePasswordBlock(validasiPasswordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        // TODO: implement listener
        if (state is LoadingChageNewPassword) {
          LoadingOverflay.of(context).open();
        }

        if (state is SuccessChangeNewPassword) {
          LoadingOverflay.of(context).close();
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
              .SuccessSnackbar(message: "${state.successMessage}"));

          navigatorKey.currentState
              ?.pushNamedAndRemoveUntil('/login', (route) => false);
        }
        if (state is ErorrChangeNewPassword) {
          LoadingOverflay.of(context).close();

          ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
              .ErorrSnackbar(
                  message: state.error.response!.data['message'].toString()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Ubah Password"),
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
                    "Password baru",
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
                          Text("Masukkan password baru"),
                          SizedBox(
                            height: 6.h,
                          ),
                          TextFormField(
                            obscureText: hidePassword,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password tidak boleh kosong";
                              }
                            },
                            decoration: InputDecoration(
                                label: Text("Password baru"),
                                suffix: GestureDetector(
                                  child: Icon(hidePassword == false
                                      ? FontAwesome.eye
                                      : FontAwesome.eye_off),
                                  onTap: () {
                                    setState(() {
                                      hidePassword = !hidePassword;
                                    });
                                  },
                                )),
                            controller: passwordCotroller,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          TextFormField(
                            obscureText: hidePasswordValidation,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Validasi Password tidak boleh kosong";
                              }

                              if (value != passwordCotroller.text) {
                                return "Password tidak sama";
                              }
                            },
                            decoration: InputDecoration(
                                label: Text("Validasi Password"),
                                suffix: GestureDetector(
                                  child: Icon(hidePasswordValidation == false
                                      ? FontAwesome.eye
                                      : FontAwesome.eye_off),
                                  onTap: () {
                                    setState(() {
                                      hidePasswordValidation =
                                          !hidePasswordValidation;
                                    });
                                  },
                                )),
                            controller: validasiPasswordController,
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
                                child: Text("Lanjut")),
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
