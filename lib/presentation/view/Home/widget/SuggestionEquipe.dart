import 'package:flutter/material.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';


class SuggestionEquipe extends StatefulWidget {
  const SuggestionEquipe({super.key});

  @override
  State<SuggestionEquipe> createState() => _SuggestionEquipeState();
}

class _SuggestionEquipeState extends State<SuggestionEquipe> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      height: 124,
      width: 136,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              // Replace with your network image or local asset
              backgroundImage: AssetImage('path/to/your/local/image.png'),
              backgroundColor: Colors.blue,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AllText.Autotext(
                    text: "test1",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).shadowColor),
                AllText.Autotext(
                    text: "04/05/24",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).shadowColor),
              ],
            )
          ],
        ),
        Column(
          children: [
            AllText.Autotext(
                text: "Poste : Gardien",
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).shadowColor),
            Container(
              height: 18,
              width: 43,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(4))),
              child: AllText.Autotext(
                  text: "Gratuite",
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            )
          ],
        )
      ]),
    );
  }
}
