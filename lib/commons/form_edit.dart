import 'package:flutter/material.dart';
import 'package:pos_flutter/config/style/style.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';

class FormEdit extends StatefulWidget {
  const FormEdit(
      {super.key,
      this.value = '',
      this.onPressed,
      this.title = ' ',
      this.textError,
      this.textHint});
  final String value;
  final String? textHint;
  final String title;
  final String? textError;
  final VoidCallback? onPressed;

  @override
  State<FormEdit> createState() => _FormEditState();
}

class _FormEditState extends State<FormEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.check),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(
                height: verticalPadding / 2,
              ),
              TextFormField(
                style: textTheme().bodyMedium,
                initialValue: widget.value,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 0),
                    label: Text(widget.title),
                    labelStyle: textTheme()
                        .bodySmall
                        ?.copyWith(color: Colors.grey.shade600),
                    border: UnderlineInputBorder(),
                    focusedBorder: UnderlineInputBorder()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
