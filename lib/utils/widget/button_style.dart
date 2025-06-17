import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonStyles {
  static Widget ButtonIcon({
    required Color backGroundColor,
    required Color foreGroundColor,
    required Icon icon,
    required String label,
    required Function() onTap,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: backGroundColor,
        foregroundColor: foreGroundColor,
        fixedSize: Size(353.w, 67.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(19.r),
        ),
      ),
      onPressed: onTap,
      icon: icon,
      label: Text(
        label,
        textAlign: TextAlign.center,
        style: GoogleFonts.quicksand(
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }

  static Widget ButtonNotIcon({
    required Color backGroundColor,
    required Color foreGroundColor,
    required String label,
    Color? colorText,
    required Function() onTap,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backGroundColor,
        foregroundColor: foreGroundColor,
        fixedSize: Size(353.w, 67.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(19.r),
        ),
      ),
      onPressed: onTap,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: GoogleFonts.quicksand(
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: colorText ?? Colors.white,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}