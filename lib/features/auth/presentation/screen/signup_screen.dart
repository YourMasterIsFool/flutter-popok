import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/auth/model/signup_model.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late AuthBloc _authBloc;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final namaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();

    super.initState();
  }

  void registerHandler() async {
    SignupModel schema = SignupModel(
        email: emailController.text,
        name: namaController.text,
        password: passwordController.text);

    await _authBloc.registerHandler(schema);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        // TODO: implement listener
        if (state is LoadingRegsterState) {
          LoadingOverflay.of(context).open();
        } else if (state is SuccessRegisterState) {
          LoadingOverflay.of(context).close();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
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
                    "Buat akun ke popoku",
                    style: textTheme().titleLarge?.copyWith(fontSize: 32.0),
                  ),
                  SizedBox(
                    height: verticalPadding / 3,
                  ),
                  Text(
                    "Hello user",
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
                            decoration: InputDecoration(label: Text("Email")),
                          ),
                          SizedBox(
                            height: verticalPadding / 2,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration:
                                InputDecoration(label: Text("Password")),
                          ),
                          SizedBox(
                            height: verticalPadding / 2,
                          ),
                          TextFormField(
                            controller: namaController,
                            decoration: InputDecoration(label: Text("Nama")),
                          ),
                          SizedBox(
                            height: verticalPadding / 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  navigatorKey.currentState?.pop();
                                },
                                child: Text(
                                  "Udah punya account?",
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
                                    registerHandler();
                                  }
                                },
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.symmetric(
                                            horizontal: horizontalPadding / 2,
                                            vertical: verticalPadding / 2))),
                                child: Text("Sign up")),
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
