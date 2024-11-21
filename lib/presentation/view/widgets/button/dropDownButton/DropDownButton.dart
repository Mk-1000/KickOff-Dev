import 'package:flutter/material.dart';

class DropDuwnButton extends StatefulWidget {
  final List<String> list ; 
  final double width ; 
  const DropDuwnButton({super.key, required this.list, this.width = 155});
  @override
  State<DropDuwnButton> createState() => _DropDuwnButtonState();
}

class _DropDuwnButtonState extends State<DropDuwnButton> {
  String? dropdownValue ;
  @override
  void initState() {
    // TODO: implement initState
     dropdownValue = widget.list.first;
    super.initState();
  }
  bool isFocused = false;


  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {
          isFocused = hasFocus;
        });
      },
      child: Container(
        height: 48,
        width: widget.width,
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: isFocused ? Theme.of(context).primaryColor : Theme.of(context).bottomAppBarColor, width: 1),
          color: Colors.white,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_drop_down, color:isFocused ? Theme.of(context).primaryColor : Theme.of(context).shadowColor,),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black, fontSize: 16),
            onChanged: (String? newValue) {
              setState(() {
                if (newValue != null) {
                  dropdownValue = newValue;
                }
              });
            },
            items: widget.list
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}