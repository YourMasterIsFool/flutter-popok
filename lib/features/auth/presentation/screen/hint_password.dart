import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/CustomSnackbar.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/config/secure_storage/secure_storage.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_state.dart';

class HintPasswordScreen extends StatefulWidget {
  const HintPasswordScreen({super.key});

  @override
  State<HintPasswordScreen> createState() => _HintPasswordScreenState();
}

class _HintPasswordScreenState extends State<HintPasswordScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late AuthBloc _authBloc;

  final hintPasswordController = TextEditingController();

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
    hintPasswordController.dispose();
    super.dispose();
  }

  void checkEmailHandler() async {
    await _authBloc.checkPasswordHintIsCorrect(hintPasswordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        // TODO: implement listener
        if (state is LoadingHintPassword) {
          LoadingOverflay.of(context).open();
        }

        if (state is SuccessHintPassword) {
          LoadingOverflay.of(context).close();
          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackbar().SuccessSnackbar(message: "check"));
          navigatorKey?.currentState
              ?.pushNamed('/forgot-password-new-password');
        }
        if (state is ErorrHintPassword) {
          LoadingOverflay.of(context).close();

          ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
              .ErorrSnackbar(
                  message: state.error.response!.data['message'].toString()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Jawaban Pertanyaan"),
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
                    "Jawaban pertanyaaan untuk reset passwrod",
                    style: textTheme().titleLarge,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  FutureBuilder(
                      future: SecureStorage().getQuestionForgotPassword(),
                      builder: (context, snapshot) {
                        return Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${snapshot.data}"),
                                SizedBox(
                                  height: 6.h,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Hint password tidak boleh kosong";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      label: Text("Masukkan hint")),
                                  controller: hintPasswordController,
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
                            ));
                      })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
