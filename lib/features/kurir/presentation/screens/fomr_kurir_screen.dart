import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/CustomSnackbar.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/profile/domain/model/user_model.dart';
import 'package:pos_flutter/features/profile/presentation/bloc/user_bloc.dart';
import 'package:pos_flutter/features/profile/presentation/bloc/user_state.dart';

class FormKurirScreen extends StatefulWidget {
  const FormKurirScreen({super.key});

  @override
  State<FormKurirScreen> createState() => _FormKurirScreenState();
}

class _FormKurirScreenState extends State<FormKurirScreen> {
  final emailController = TextEditingController();
  final namaController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final passwordController = TextEditingController();

  late UserBloc _userBloc;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _userBloc = context.read<UserBloc>();
    super.initState();
  }

  void createNewUser() async {
    UserModel schema = UserModel(
      email: emailController.text,
      name: namaController.text,
      role_id: 2,
      phone_number: phoneNumberController.text,
      password: passwordController.text,
    );

    await _userBloc.registerNewUser(schema);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Kurir"),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        bloc: _userBloc,
        listener: (context, state) {
          // TODO: implement listener
          if (state is LoadingCreateUser) {
            LoadingOverflay.of(context).open();
          }

          if (state is SuccessCreateUser) {
            LoadingOverflay.of(context).close();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("${state.success}")));
            navigatorKey.currentState?.pop();
          }
          if (state is ErrorCreateUser) {
            LoadingOverflay.of(context).close();
            ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackbar().ErorrSnackbar(message: state.error));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    "Tambah Kurir \nBaru",
                    style: textTheme().titleLarge,
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration:
                                InputDecoration(label: Text("Email Kurir")),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          TextFormField(
                            controller: namaController,
                            decoration:
                                InputDecoration(label: Text("Nama Kurir")),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          TextFormField(
                            controller: phoneNumberController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration:
                                InputDecoration(label: Text("No handphone")),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration:
                                InputDecoration(label: Text("Password kurir")),
                          ),
                          SizedBox(
                            height: verticalPadding,
                          ),
                          TextButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  createNewUser();
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text("Tambah Kurir")],
                              ))
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
