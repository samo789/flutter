import 'package:flutter/material.dart';
import 'colors.dart';

class AppTextField extends StatelessWidget {
final String hintText;
final String? errorText;
final Widget? prefixIcon;
final Widget? suffixIcon;
final TextEditingController controller;
final String? Function(String?)? validator;
final bool obscureText;
final TextInputType? keyboardType;

const AppTextField({
super.key,
required this.hintText,
this.prefixIcon,
this.suffixIcon,
required this.controller,
this.errorText,
this.validator,
this.obscureText = false,
this.keyboardType,
});

@override
Widget build(BuildContext context) {
return TextFormField(
controller: controller,
validator: validator,
obscureText: obscureText,
keyboardType: keyboardType,
style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
decoration: InputDecoration(
hintText: hintText,
hintStyle: const TextStyle(color: Color(0xffB0B0B0), fontSize: 12), 
prefixIcon: prefixIcon,
suffixIcon: suffixIcon,
errorText: errorText,
errorStyle: const TextStyle(color: AppColors.errorRed, fontSize: 11),


contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
filled: true,
fillColor: Colors.white, 


border: OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(color: Color(0xffB0B0B0), width: 0.5),
),
enabledBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(color: Color(0xffB0B0B0), width: 0.5),
),
focusedBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(color: AppColors.primaryColor, width: 0.5),
),
errorBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(color: AppColors.errorRed, width: 0.5),
),
focusedErrorBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(12),
  borderSide: const BorderSide(color: AppColors.errorRed, width: 0.5),
),

),
);

}
}