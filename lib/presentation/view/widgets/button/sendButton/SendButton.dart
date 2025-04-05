import 'package:flutter/material.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class SendButton extends StatefulWidget {

  final bool invit ; 
  const SendButton({super.key, required this.invit});

  @override
  State<SendButton> createState() => _SendButtonState();
}

class _SendButtonState extends State<SendButton> {
  
  late bool send ; 
  @override
  void initState() {
    send = widget.invit ; 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
                  onTap: () {
                      setState(() =>send = !send);
                  },
                  child: AnimatedContainer(
                     duration: const Duration(milliseconds: 300),
                    alignment: Alignment.center,
                    height: 30,
                    width: 108,
                    decoration: BoxDecoration(
                      color: send ?Colors.transparent : Colors.white,
                      border: Border.all(color:send ? Colors.white:Colors.transparent),
                      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: AllText.Autotext(
                        text:  send ? "Annuler": "Envoyer",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: send  ? Colors.white: Theme.of(context).primaryColor),
                  ),
                );
  }
}