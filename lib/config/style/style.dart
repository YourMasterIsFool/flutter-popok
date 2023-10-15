import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

double fontSmall = 12.sp;
double fontNormal = 14.sp;
double fontLarge = 18.sp;

double horizontalPadding = 24.w;
double verticalPadding = 24.h;

Color primaryColor = Color(Colors.black.value);
Color errorColor = Colors.red.shade400;

TextStyle textSmallThin =
    GoogleFonts.inter(fontSize: fontSmall, fontWeight: FontWeight.w400);
TextStyle textSmall =
    GoogleFonts.inter(fontSize: fontSmall, fontWeight: FontWeight.normal);
TextStyle textSmallTitle =
    GoogleFonts.inter(fontSize: fontSmall, fontWeight: FontWeight.w600);

TextStyle textNormalThin =
    GoogleFonts.inter(fontSize: fontNormal, fontWeight: FontWeight.w400);
TextStyle textNormal =
    GoogleFonts.inter(fontSize: fontNormal, fontWeight: FontWeight.normal);
TextStyle textNormalTitle =
    GoogleFonts.inter(fontSize: fontNormal, fontWeight: FontWeight.bold);

TextStyle textLargeThin =
    GoogleFonts.inter(fontSize: fontLarge, fontWeight: FontWeight.w400);
TextStyle textLarge =
    GoogleFonts.inter(fontSize: fontLarge, fontWeight: FontWeight.normal);
TextStyle textLargeTitle =
    GoogleFonts.inter(fontSize: fontLarge, fontWeight: FontWeight.bold);

OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.red.shade400));

OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.grey.shade800));
