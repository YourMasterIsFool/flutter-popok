import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_flutter/app.dart';
import 'package:pos_flutter/config/style/style.dart';

class LoadingOverflay {
  BuildContext context;

  LoadingOverflay({required this.context});

  void open() {
    print('open');
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.2),
        context: context,
        builder: (context) => Dialog(
              backgroundColor: Colors.black.withOpacity(0.2),
              child: Center(
                  child: CircularProgressIndicator(
                color: primaryColor,
              )),
            ));
  }

  void close() {
    Navigator.of(context).pop();
  }

  factory LoadingOverflay.of(BuildContext context) {
    return LoadingOverflay(context: context);
  }
}
