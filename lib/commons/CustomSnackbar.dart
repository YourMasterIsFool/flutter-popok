import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:pos_flutter/config/theme/myTheme.dart';

class CustomSnackbar {
  SnackBar SuccessSnackbar({required String message}) {
    return SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.w,
          ),
          Expanded(
              child: Text(
            "${message}",
            style: textTheme().bodyMedium?.copyWith(color: Colors.white),
          ))
        ],
      ),
      backgroundColor: Colors.green.shade600,
    );
  }

  SnackBar ErorrSnackbar({required String message}) {
    return SnackBar(
      content: Row(
        children: [
          Icon(
            FontAwesome.cancel_circled,
            color: Colors.white,
          ),
          SizedBox(
            width: 12.w,
          ),
          Expanded(
              child: Text(
            "${message}",
            style: textTheme().bodyMedium?.copyWith(color: Colors.white),
          ))
        ],
      ),
      backgroundColor: Colors.red.shade600,
    );
  }
}
