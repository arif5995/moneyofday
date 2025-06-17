import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:monday/utils/gen/colors.gen.dart';

class TextFieldCustom {
  static Widget textFieldNormal(
      {required TextEditingController controller,
      required String hint,
      Key? key,
      String? label,
      Function(String)? onChanged,
      Function()? onTap,
      FocusNode? focusNode,
      List<TextInputFormatter>? inputFormatters,
      String? Function(String?)? validator}) {
    return TextFormField(
      key: key,
      controller: controller,
      style: TextStyle(fontSize: 14.sp),
      validator: validator,
      onChanged: onChanged,
      focusNode: focusNode,
      onTap: onTap,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        // Set border for enabled state (default)
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: ColorName.textGrey),
          borderRadius: BorderRadius.circular(15),
        ),
        // Set border for focused state
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: ColorName.textGrey),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
