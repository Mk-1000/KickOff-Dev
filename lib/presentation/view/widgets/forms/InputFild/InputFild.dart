import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class inputFild extends StatelessWidget {
  final Size size;
  final TextEditingController controller;
  final String hint;
  final bool obscureText;

  const inputFild({
    Key? key,
    required this.size,
    required this.controller,
    required this.hint,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      cursorColor: Colors.black,
      controller: controller,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.03.w),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
          borderSide: BorderSide(color: Color(0xFF948B8B)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0.r)),
          borderSide: BorderSide(color: Color(0xFF948B8B)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0.w,
          ),
        ),
      ),
    );
  }
}
