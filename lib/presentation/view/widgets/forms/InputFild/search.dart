import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData iconData;

  const Search({
    super.key,
    required this.controller,
    required this.hint,
    this.iconData = Icons.search, // Default icon is search
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );

    final inputDecoration = InputDecoration(
      contentPadding: const EdgeInsets.only(left: 18, right: 18, top: 10),
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Theme.of(context).bottomAppBarTheme.color!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Theme.of(context).bottomAppBarTheme.color!),
      ),
      prefixIcon: Icon(iconData),
      focusColor: Colors.black,
    );

    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: TextFormField(
        cursorColor: Theme.of(context).primaryColor,
        controller: controller,
        style: textStyle,
        decoration: inputDecoration,
      ),
    );
  }
}
