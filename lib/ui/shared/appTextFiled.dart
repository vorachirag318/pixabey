import 'package:flutter/material.dart';
import 'package:pixabay/core/constant/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final String? initialValue;
  final String? Function(String?)? validate;
  final Function(String)? onChange;
  final bool obsecureText;
  final TextInputType keyboardType;
  final int maxLines;
  final TextEditingController? controller;
  final AutovalidateMode? autoValidateMode;
  final int? maxLength;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  void Function(String)? onFieldSubmitted;
  TextCapitalization textCapitalization;

  AppTextField(
      {Key? key,
      this.suffixIcon,
      this.hintText,
      this.readOnly = false,
      this.initialValue,
      this.validate,
      this.onChange,
      this.obsecureText = false,
      this.keyboardType = TextInputType.text,
      this.maxLines = 1,
      this.controller,
      this.autoValidateMode,
      this.maxLength,
      this.textCapitalization = TextCapitalization.none,
      this.prefixIcon,
      this.onFieldSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      maxLength: maxLength,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: onFieldSubmitted,
      autovalidateMode: autoValidateMode,
      controller: controller,
      cursorColor: AppColor.kScaffoldColor,
      style: const TextStyle(
        fontSize: 16,
        color: AppColor.kScaffoldColor,
      ),
      initialValue: initialValue,
      textCapitalization: textCapitalization,
      decoration: InputDecoration(
        counterText: "",
        prefixIcon: prefixIcon,
        counterStyle: const TextStyle(color: Colors.white),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 16,
          color: AppColor.kPrimaryText,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(width: 0.5, color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(width: 0.5, color: Colors.transparent),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(width: 0.5, color: Colors.transparent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(width: 0.5, color: Colors.transparent),
        ),
      ),
      onChanged: onChange,
      validator: validate,
      obscureText: obsecureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
    );
  }
}
