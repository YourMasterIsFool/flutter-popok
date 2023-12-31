import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/CustomSnackbar.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/auth/model/login_model.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late AuthBloc authBloc;
  final _formKey = GlobalKey<FormState>();

  bool obsecureText = true;

  @override
  void initState() {
    authBloc = context.read<AuthBloc>();
    super.initState();
  }

  Future<void> loginHandler() async {
    LoginModel _schema = new LoginModel(
        email: emailController.text, password: passwordController.text);

    await authBloc.loginBloc(_schema);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
          print('state' + state.toString());

          if (state is LoadingLoginState) {
            LoadingOverflay.of(context).open();
          }
          if (state is ErrorLoginState) {
            LoadingOverflay.of(context).close();
            ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
                .ErorrSnackbar(message: state.error.response.toString()));
          }
          if (state is SuccessLoginState) {
            LoadingOverflay.of(context).close();
            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackbar().SuccessSnackbar(message: "Success Login"));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: horizontalPadding / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: verticalPadding * 2,
                    ),
                    Text(
                      "Masuk Ke PopokCare",
                      style: textTheme().titleLarge?.copyWith(fontSize: 32.0),
                    ),
                    SizedBox(
                      height: verticalPadding / 3,
                    ),
                    Text(
                      "",
                      style: textTheme().titleMedium,
                    ),
                    (state is ErrorLoginState)
                        ? Container(
                            decoration: BoxDecoration(
                                color: errorColor,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Text(
                                  state.error.response?.data['message'],
                                  style: textTheme()
                                      .bodySmall
                                      ?.copyWith(color: Colors.white),
                                )
                              ],
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: verticalPadding,
                    ),
                    Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Email tidak boleh kosong";
                                }
                              },
                              decoration: InputDecoration(
                                  label: Text("Email"),
                                  suffixIcon: Icon(Icons.email)),
                            ),
                            SizedBox(
                              height: verticalPadding / 2,
                            ),
                            TextFormField(
                              controller: passwordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Password tidak boleh kosong";
                                }
                              },
                              obscureText: obsecureText,
                              decoration: InputDecoration(
                                  label: Text("Password"),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        obsecureText = !obsecureText;
                                      });
                                    },
                                    child: obsecureText
                                        ? Icon(CupertinoIcons.eye)
                                        : Icon(Icons.disabled_visible),
                                  )),
                            ),
                            SizedBox(
                              height: verticalPadding / 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    navigatorKey.currentState
                                        ?.pushNamed('/forgot-password-email');
                                  },
                                  child: Text(
                                    "Lupa Password?",
                                    style: textTheme().bodySmall,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      Navigator.pushNamed(context, '/signup'),
                                  child: Text(
                                    "Belum punya akun?",
                                    style: textTheme()
                                        .bodySmall
                                        ?.copyWith(color: Colors.grey.shade600),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: verticalPadding * 2,
                            ),
                            Container(
                              width: double.infinity,
                              child: TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      loginHandler();
                                    }
                                  },
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.symmetric(
                                              horizontal: horizontalPadding / 2,
                                              vertical: verticalPadding / 2))),
                                  child: Text("Masuk")),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
