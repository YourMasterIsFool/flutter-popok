import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/CustomSnackbar.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/auth/model/signup_model.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_state.dart';
import 'package:pos_flutter/features/auth/presentation/screen/list_hint_question.dart';
import 'package:pos_flutter/features/lupa_password/model/hint_question_model.dart';
import 'package:pos_flutter/features/lupa_password/presentation/bloc/lupa_password_bloc.dart';
import 'package:pos_flutter/features/lupa_password/presentation/bloc/lupa_password_state.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late AuthBloc _authBloc;
  late final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final namaController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final alamatController = TextEditingController();
  final hintController = TextEditingController();

  HintQuestionModel? question;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _authBloc = context.read<AuthBloc>();

    super.initState();
  }

  List<Map<String, dynamic>> listGender = [
    {'value': 'Laki Laki', 'icon': 'assets/svgs/man-svgrepo-com.svg'},
    {'value': 'Perempuan', 'icon': 'assets/svgs/woman-svgrepo-com.svg'},
  ];

  String jenkel = 'Laki Laki';

  void registerHandler() async {
    SignupModel schema = SignupModel(
        email: emailController.text,
        alamat: alamatController.text,
        question_answer: hintController.text,
        question_id: question?.code ?? 1,
        jenis_kelamin: jenkel,
        phone_number: phoneNumberController.text,
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

          ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
              .SuccessSnackbar(message: "Berhasil membuat akun"));
          Navigator.pop(context);
        }

        if (state is ErrorRegister) {
          LoadingOverflay.of(context).close();

          ScaffoldMessenger.of(context).showSnackBar(
              CustomSnackbar().ErorrSnackbar(message: state.errorMessage));
        }

        print(state);
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Buat Akun Baru"),
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
                    "Buat akun ke \nPopokCare",
                    style: textTheme().titleLarge?.copyWith(fontSize: 32.0),
                  ),
                  SizedBox(
                    height: verticalPadding / 3,
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
                                return "email tidak boleh kosong";
                              }
                            },
                            decoration: InputDecoration(label: Text("Email")),
                          ),
                          SizedBox(
                            height: verticalPadding / 2,
                          ),
                          TextFormField(
                            controller: namaController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "nama tidak boleh kosong";
                              }
                            },
                            decoration: InputDecoration(label: Text("Nama")),
                          ),
                          SizedBox(
                            height: verticalPadding / 2,
                          ),
                          TextFormField(
                            controller: phoneNumberController,
                            // obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Nomor Handphon tidak boleh kosong";
                              }
                            },
                            decoration:
                                InputDecoration(label: Text("No Handphone")),
                          ),
                          SizedBox(
                            height: verticalPadding / 2,
                          ),
                          TextFormField(
                            controller: alamatController,
                            // obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "alamat tidak boleh kosong";
                              }
                            },
                            decoration: InputDecoration(label: Text("Alamat")),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text("Pilih jenis kelamin"),
                          SizedBox(
                            height: 4.h,
                          ),
                          Container(
                            height: 50,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(right: 8.w),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        jenkel = listGender[index]['value'];
                                      });
                                    },
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            child: Center(
                                              child: SvgPicture.asset(
                                                listGender[index]['icon'],
                                                width: 20,
                                                height: 20,
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: jenkel ==
                                                            listGender[index]
                                                                ['value']
                                                        ? Colors.grey.shade500
                                                        : Colors.transparent),
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              shrinkWrap: true,
                              primary: false,
                              scrollDirection: Axis.horizontal,
                              itemCount: listGender.length,
                            ),
                          ),
                          SizedBox(
                            height: verticalPadding / 2,
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          Text("Pilih Pertanyaan"),
                          SizedBox(
                            height: 6.h,
                          ),
                          Container(
                            width: double.infinity,
                            child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.grey.shade300),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ListHintQuestion(
                                                question: question,
                                              ))).then((value) {
                                    setState(() {
                                      question = value;
                                    });
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Text(
                                            "${question == null ? 'Pilih Pertanyaan' : question?.question}")),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Icon(Icons.chevron_right)
                                  ],
                                )),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          TextFormField(
                            controller: hintController,
                            // obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "hint harus ada";
                              }
                            },
                            decoration: InputDecoration(label: Text("Jawaban")),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password tidak boleh kosong";
                              }
                            },
                            decoration:
                                InputDecoration(label: Text("Password")),
                          ),
                          SizedBox(
                            height: 12.h,
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
                                child: Text("Daftar Akun")),
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
