import 'package:flutter/material.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
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
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(label: Text("Email")),
                  ),
                  SizedBox(
                    height: verticalPadding / 2,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(label: Text("Password")),
                  ),
                  SizedBox(
                    height: verticalPadding / 2,
                  ),
                  TextFormField(
                    decoration: InputDecoration(label: Text("Nama")),
                  ),
                  SizedBox(
                    height: verticalPadding / 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: Text(
                          "Doesn't have account?",
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
                        onPressed: () {},
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
  }
}
