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
        barrierColor: Colors.black.withOpacity(0.6),
        context: context,
        builder: (context) => Dialog(
              backgroundColor: Colors.transparent,

              // backgroundColor: Colors.black.withOpacity(0.6),
              child: Center(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                height: 75,
                width: 75,
                child: Center(
                  child: Container(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  ),
                ),
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
