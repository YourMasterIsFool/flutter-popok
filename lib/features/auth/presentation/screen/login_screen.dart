import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    (state is ErrorLoginState)
                        ? Text("${state.error.toString()}")
                        : Container(),
                    SizedBox(
                      height: verticalPadding * 2,
                    ),
                    Text(
                      "Login Ke Popoku",
                      style: textTheme().titleLarge?.copyWith(fontSize: 32.0),
                    ),
                    SizedBox(
                      height: verticalPadding / 3,
                    ),
                    Text(
                      "",
                      style: textTheme().titleMedium,
                    ),
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
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
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
                                  child: Text("Sign in")),
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
