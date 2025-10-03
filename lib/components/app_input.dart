import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_trip_start/constants.dart';

class AppInput extends StatelessWidget {
  const AppInput(
      {super.key,
      required this.hintText,
      this.icon,
      this.textInputType,
      this.suffixicon,
      this.color,
      this.borderRaidus,
      this.textColor,
      this.controller,
      this.obscureText,
      this.validator,
      this.readOnly,
      this.onPress,
      this.onChanged,
      this.textAlign});
  final String hintText;
  final Widget? icon;
  final Widget? suffixicon;
  final TextInputType? textInputType;
  final Color? color;
  final Color? textColor;
  final double? borderRaidus;
  final TextEditingController? controller;
  final bool? obscureText;
  final bool? readOnly;
  final VoidCallback? onPress;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType ?? TextInputType.text,
      style: TextStyle(color: textColor ?? kBlackColor),
      obscureText: obscureText ?? false,
      validator: validator,
      onTap: onPress,
      onChanged: onChanged,

      readOnly: readOnly ?? false,
      cursorColor: kPrimaryColor,
      textAlign: textAlign ?? TextAlign.start,
      // textAlign: TextAlignVertical.center,
      decoration: InputDecoration(
        fillColor: color ?? kPrimaryColor.withValues(alpha: 0.1),
        filled: true,
        focusColor: color ?? kPrimaryColor.withValues(alpha: 0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRaidus ?? 20),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        prefixIcon: icon,
        prefixIconConstraints:
            const BoxConstraints(maxHeight: 20, maxWidth: 50),
        suffixIcon: suffixicon,
        hintStyle: GoogleFonts.poppins(
            textStyle: const TextStyle(
          fontSize: 12,
        )),
        hintText: hintText,
      ),
    );
  }
}
