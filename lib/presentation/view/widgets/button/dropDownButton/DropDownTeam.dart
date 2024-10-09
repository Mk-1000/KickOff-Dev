import 'package:flutter/material.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class DropDownTeam extends StatefulWidget {
    final List<String> list ; 
  const DropDownTeam({super.key, required this.list});

  @override
  State<DropDownTeam> createState() => _DropDownTeamState();
}

class _DropDownTeamState extends State<DropDownTeam> {

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
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: isFocused ? Theme.of(context).primaryColor : Theme.of(context).bottomAppBarTheme.color!, width: 1),
          color: Colors.white,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            selectedItemBuilder: (BuildContext context) {
                return widget.list.map<Widget>((String item) {
                  return Row(
                    children: [
                     ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      child: Image.network(
                        "https://assets-fr.imgfoot.com/media/cache/642x382/osasuna-madridliga2324.jpg",
                        height: 35,
                        width:35,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 8,),
                    AllText.Autotext(text: item.toString(), fontSize: 16, fontWeight: FontWeight.w400, color: Theme.of(context).shadowColor)
                  ],);
                }).toList();
              },
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
                child:Row(
                    children: [
                     ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      child: Image.network(
                        "https://assets-fr.imgfoot.com/media/cache/642x382/osasuna-madridliga2324.jpg",
                        height: 35,
                        width:35,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 8,),
                    AllText.Autotext(text: value.toString(), fontSize: 16, fontWeight: FontWeight.w400, color: Theme.of(context).shadowColor)
                  ],),
                
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}