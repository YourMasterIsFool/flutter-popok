import 'package:flutter/material.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/commons/form_edit.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

void openEditFormHandler({
  String value = '',
  String name = '',
  String title = '',
  required BuildContext context,
}) {
  navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (context) => FormEdit(
            onPressed: () {},
            textError: '',
            title: title,
            textHint: '',
            value: value,
          )));
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.check))],
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
                    value: 'Verrandy Bagus',
                    title: "Edit Name",
                    name: "Verrandy Bagus",
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
                        "Name",
                        style: textTheme()
                            .bodySmall
                            ?.copyWith(color: Colors.grey.shade600),
                      ),
                      SizedBox(
                        height: verticalPadding / 4,
                      ),
                      Text(
                        "Verrandy bagus",
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
                    value: 'verrandyb@gmail.com',
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
                        "verrandyb@gmail.com",
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
}
