import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextStyles {
  static Widget header1({required String text, FontWeight? fontWeight, Color? color}) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: fontWeight ?? FontWeight.bold,
          color: color ?? Colors.black,
          fontSize: 35.sp,
      ),
    );
  }

  static Widget header2({required String text, Color? color}) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22.sp,
          color: color ?? Colors.white),
    );
  }

  static Widget header3({required String text, Color? color, FontWeight? fontWeight}) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: fontWeight ?? FontWeight.w100,
          fontSize: 18.sp,
          color: color ?? Colors.white),
    );
  }

  static Widget nominal1({required String text, Color? color}) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 64.sp,
          color: color ?? Colors.white),
    );
  }

  static Widget body2(
      {required String text, Color? color, FontWeight? fontWeight, TextAlign? textAlign}) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.center,
      style: TextStyle(
          fontWeight: fontWeight ?? FontWeight.normal,
          fontSize: 16.sp,
          color: color ?? Colors.black,
          overflow: TextOverflow.ellipsis
      ),
    );
  }

  static Widget body3({required String text, Color? color}) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14.sp,
          color: color ?? Colors.black,
      ),
    );
  }

  static Widget body4({required String text, Color? color}) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 13.sp,
          color: color ?? Colors.black,),
    );
  }
}
