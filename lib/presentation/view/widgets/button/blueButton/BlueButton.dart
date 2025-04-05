import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BlueButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double width;
  final bool outlindedbutton;

  const BlueButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.width,
    required this.outlindedbutton, // Changed variable name for consistency
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the style for the button based on whether it's outlined or not.
    final ButtonStyle flatStyle = outlindedbutton
        ? OutlinedButton.styleFrom(
            side: const BorderSide(
                color: Color(0xFF3053EC)), // Blue border for outlined button
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(48.r)),
            backgroundColor:
                Colors.white, // White background for outlined button
          )
        : ElevatedButton.styleFrom(
            backgroundColor:
                const Color(0xFF3053EC), // Blue background for elevated button
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
          );

    // Use a Button widget depending on whether it's outlined or not.
    return Container(
      margin: EdgeInsets.only(top: 24.h),
      width: width.w,
      height: 48.h,
      child: outlindedbutton
          ? OutlinedButton(
              onPressed: onTap,
              style: flatStyle,
              child: Text(
                text,
                style: TextStyle(
                  color:
                      const Color(0xFF3053EC), // Blue text color for outlined button
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onTap,
              style: flatStyle,
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white, // White text color for elevated button
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
    );
  }
}
