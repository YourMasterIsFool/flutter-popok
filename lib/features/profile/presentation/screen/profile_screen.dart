import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/form_edit.dart';
import 'package:pos_flutter/commons/loading_overflay.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pos_flutter/features/auth/presentation/bloc/auth_state.dart';
import 'package:pos_flutter/features/profile/presentation/bloc/user_bloc.dart';
import 'package:pos_flutter/features/profile/presentation/bloc/user_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserBloc userBloc;
  late TextEditingController nameController;
  late TextEditingController emailController;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();

  LoadingOverflay? loadingOverflay;

  void openEditFormHandler({
    String value = '',
    String name = '',
    String title = '',
    required TextEditingController controller,
    required VoidCallback updateData,
    required BuildContext context,
  }) {
    navigatorKey.currentState?.push(MaterialPageRoute(
        builder: (context) => FormEdit(
              // controller: controller,
              onChanged: (value) {
                setState(() {
                  controller.text = value;
                });
              },
              onPressed: updateData,
              textError: '',
              title: title,
              textHint: '',
              value: value,
            )));
  }

  @override
  void initState() {
    userBloc = context.read<UserBloc>();
    userBloc.getCurrentUser();
    nameController = TextEditingController();
    emailController = TextEditingController();
    loadingOverflay = LoadingOverflay.of(context);

    print('test ' + userBloc.state.userModel.toString());
    emailController.text = userBloc.state.userModel?.email ?? '';
    nameController.text = userBloc.state.userModel?.name ?? '';
    phoneController.text = userBloc.state.userModel?.phone_number ?? '';
    alamatController.text = userBloc.state.userModel?.alamat ?? '';

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      bloc: userBloc,
      buildWhen: (prev, next) {
        return (next is LoadingUserState || next is SuccessGetUser);
      },
      listener: (context, state) {
        // TODO: implement listener

        if (state is SuccessUpdateUser) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Successfully update user")));
          navigatorKey.currentState?.pop();
          LoadingOverflay.of(context).close();
        }

        if (state is LoadingUpdateUser) {
          LoadingOverflay.of(context).open();
        }

        // if (state is SuccessGetUser) {
        //   LoadingOverflay.of(context).close();
        // }
      },
      builder: (context, state) {
        if (state is LoadingUserState) {
          return Scaffold(
            body: Center(
              child: Container(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (state is SuccessGetUser) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Profil"),
              // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.check))],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.network(
                              'https://w7.pngwing.com/pngs/223/244/png-transparent-computer-icons-avatar-user-profile-avatar-heroes-rectangle-black.png',
                              width: 100,
                              height: 100,
                            ),
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () => openEditFormHandler(
                          controller: nameController,
                          updateData: () async {
                            // loadingOverflay?.open();
                            await userBloc
                                .updateName(nameController.text)
                                .then((value) {
                              // loadingOverflay?.close();
                            });
                          },
                          value: '${state.user.name}',
                          title: "Sunting Nama",
                          // name: "${state.user.name}",
                          context: context),
                      child: Container(
                        margin: EdgeInsets.only(bottom: verticalPadding / 2),
                        width: double.infinity,
                        padding: EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nama",
                              style: textTheme()
                                  .bodySmall
                                  ?.copyWith(color: Colors.grey.shade600),
                            ),
                            SizedBox(
                              height: verticalPadding / 4,
                            ),
                            Text(
                              "${state.user.name}",
                              // style: textTheme()
                              //     .bodyMedium
                              //     ?.copyWith(decoration: TextDecoration.underline),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => openEditFormHandler(
                          updateData: () async {
                            // loadingOverflay?.open();
                            await userBloc
                                .updateEmail(emailController.text)
                                .then((value) {
                              // loadingOverflay?.close();
                            });
                          },
                          controller: emailController,
                          value: '${state.user.email}',
                          title: "Email",
                          name: "Email",
                          context: context),
                      child: Container(
                        margin: EdgeInsets.only(bottom: verticalPadding / 2),
                        width: double.infinity,
                        padding: EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: textTheme()
                                  .bodySmall
                                  ?.copyWith(color: Colors.grey.shade600),
                            ),
                            SizedBox(
                              height: verticalPadding / 4,
                            ),
                            Text(
                              "${state.user.email}",
                              // style: textTheme()
                              //     .bodyMedium
                              //     ?.copyWith(decoration: TextDecoration.underline),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => openEditFormHandler(
                          updateData: () async {
                            // loadingOverflay?.open();
                            await userBloc.updateUserBio(schema: {
                              "phone_number": phoneController.text
                            }).then((value) {
                              // loadingOverflay?.close();
                            });
                          },
                          controller: phoneController,
                          value: '${state.user.phone_number}',
                          title: "Nomor Telephon",
                          name: "Nomor Telephone",
                          context: context),
                      child: Container(
                        margin: EdgeInsets.only(bottom: verticalPadding / 2),
                        width: double.infinity,
                        padding: EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nomor Handphone",
                              style: textTheme()
                                  .bodySmall
                                  ?.copyWith(color: Colors.grey.shade600),
                            ),
                            SizedBox(
                              height: verticalPadding / 4,
                            ),
                            Text(
                              "${state.user.phone_number ?? ''}",
                              // style: textTheme()
                              //     .bodyMedium
                              //     ?.copyWith(decoration: TextDecoration.underline),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => openEditFormHandler(
                          updateData: () async {
                            // loadingOverflay?.open();
                            await userBloc.updateUserBio(schema: {
                              "alamat": alamatController.text
                            }).then((value) {
                              // loadingOverflay?.close();
                            });
                          },
                          controller: alamatController,
                          value: '${state.user.alamat ?? ""}',
                          title: "Alamat",
                          name: "Alamat",
                          context: context),
                      child: Container(
                        margin: EdgeInsets.only(bottom: verticalPadding / 2),
                        width: double.infinity,
                        padding: EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(width: 1))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Alamat",
                              style: textTheme()
                                  .bodySmall
                                  ?.copyWith(color: Colors.grey.shade600),
                            ),
                            SizedBox(
                              height: verticalPadding / 4,
                            ),
                            Text(
                              "${state.user.alamat ?? ''}",
                              // style: textTheme()
                              //     .bodyMedium
                              //     ?.copyWith(decoration: TextDecoration.underline),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
