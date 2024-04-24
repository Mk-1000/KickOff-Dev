import 'package:flutter/material.dart';

class CounterInput extends StatefulWidget {
  final double width ;
 final double height ;
 final double iconSize  ; 
  const CounterInput({super.key, required this.width, required this.height, required this.iconSize});
  @override
  _CounterInputState createState() => _CounterInputState();
}

class _CounterInputState extends State<CounterInput> {
  int _currentValue = 0;

  void _increment() {
    setState(() {
      _currentValue++;
    });
  }

  void _decrement() {
    setState(() {
      if (_currentValue > 0) _currentValue--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Row(
         mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(Icons.remove,size: widget.iconSize,),
            onPressed: _decrement,
          ),
          Container(
            // padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '$_currentValue',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add,size: widget.iconSize,),
            onPressed: _increment,
          ),
        ],
      ),
    );
  }
}
