import 'package:flutter/material.dart';

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
    required this.outlindedbutton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the style for the button based on whether it's outlined or not.
    final ButtonStyle flatStyle = outlindedbutton
        ? OutlinedButton.styleFrom(
            primary: const Color(0xFF3053EC),
            side: const BorderSide(color: Color(0xFF3053EC)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
            backgroundColor: Colors.white,
          )
        : ElevatedButton.styleFrom(
            primary: const Color(0xFF3053EC),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
          );

    // Use a Button widget depending on whether it's outlined or not.
    return Container(
      margin: const EdgeInsets.only(top: 24),
      width: width,
      height: 48,
      child: outlindedbutton
          ? OutlinedButton(
              onPressed: onTap,
              style: flatStyle,
              child: Text(
                text,
                style: TextStyle(
                  color: const Color(0xFF3053EC),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onTap,
              style: flatStyle,
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
    );
  }
}
