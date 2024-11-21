import 'package:flutter/material.dart';
import 'package:takwira/presentation/view/CreateTeam/CreateTeamMain.dart';
import 'package:takwira/presentation/view/CreateTeam/bloc/bloc/create_team_bloc.dart';

class CounterInput extends StatefulWidget {
  final double width ;
 final double height ;
 final double iconSize  ; 
 final String titre  ; 
    int?  counter ; 
   CounterInput({super.key, required this.width, required this.height, required this.iconSize,this.counter, required this.titre });
  @override
  _CounterInputState createState() => _CounterInputState();
}

class _CounterInputState extends State<CounterInput> {
  

  void _increment() {
    CreateTeam.CreateTeamController.add(Incrment(titre: widget.titre));

  }

  void _decrement() {
        CreateTeam.CreateTeamController.add(Decrement(titre: widget.titre));

    // setState(() {
    //   if (widget.counter! > 0 && )  widget.counter = widget.counter!+1;
    // });
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
              widget.counter.toString(),
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
