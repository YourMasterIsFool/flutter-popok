import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

double fontSmall = 12.sp;
double fontNormal = 16.sp;
double fontLarge = 20.sp;

double horizontalPadding = 24.w;
double verticalPadding = 24.h;

Color primaryColor = Color(Colors.black.value);

TextStyle textSmallThin =
    GoogleFonts.lato(fontSize: fontSmall, fontWeight: FontWeight.w400);
TextStyle textSmall =
    GoogleFonts.lato(fontSize: fontSmall, fontWeight: FontWeight.normal);
TextStyle textSmallTitle =
    GoogleFonts.lato(fontSize: fontSmall, fontWeight: FontWeight.w600);

TextStyle textNormalThin =
    GoogleFonts.lato(fontSize: fontNormal, fontWeight: FontWeight.w400);
TextStyle textNormal =
    GoogleFonts.lato(fontSize: fontNormal, fontWeight: FontWeight.normal);
TextStyle textNormalTitle =
    GoogleFonts.lato(fontSize: fontNormal, fontWeight: FontWeight.bold);

TextStyle textLargeThin =
    GoogleFonts.lato(fontSize: fontLarge, fontWeight: FontWeight.w400);
TextStyle textLarge =
    GoogleFonts.lato(fontSize: fontLarge, fontWeight: FontWeight.normal);
TextStyle textLargeTitle =
    GoogleFonts.lato(fontSize: fontLarge, fontWeight: FontWeight.bold);

OutlineInputBorder errorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.red.shade400));

OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.grey.shade800));
