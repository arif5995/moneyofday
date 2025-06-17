import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormFieldCustom {
  static Widget NormalInput({
    required String label,
    required String hint,
    required TextInputType textInputType,
    required String? Function(String?) validation,
  }) {
    return TextFormField(
        keyboardType: textInputType,
        style: GoogleFonts.quicksand(
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: 19.sp,),
        ),
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
        ),
        validator: validation
    );
  }

  static Widget PasswordInput({
    required String label,
    required String hint,
    required bool obscure,
    required TextInputType textInputType,
    required Function() validation,
  }) {
    return  TextFormField(
      obscureText: obscure,
      keyboardType: textInputType,
      style: GoogleFonts.quicksand(
        textStyle: TextStyle(
          color: Colors.black,
          fontSize: 19.sp,),
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffixIcon: IconButton(
          icon: Icon(
            obscure
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: Colors.grey,
            size: 19.sp,
          ),
          onPressed: validation,
        ),
      ),
    );
  }
}