import 'package:flutter/material.dart';
import 'package:takwira/view/widgets/cashedImage/cashedImage.dart';
import 'package:takwira/view/widgets/text/text.dart';

class SuggestionStade extends StatelessWidget {
  const SuggestionStade({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // color: Colors.amber,
          margin: EdgeInsets.only(right: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: CahedImage(
                      img:
                          "https://media.istockphoto.com/id/1502846052/fr/photo/terrain-textur%C3%A9-de-jeu-de-football-avec-le-brouillard-de-n%C3%A9on-centre-milieu-de-terrain.jpg?s=1024x1024&w=is&k=20&c=BRsvbxYMbiJrYSVxlwYnWVeiHqiRN5FpQTRkJdHt4Oc=",
                      box: BoxFit.cover,
                      height: 220,
                      width: 180,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      // padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      height: 30,
                      width: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(20)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.star, color: Colors.amber),
                          SizedBox(width: 4),
                          Text(
                            '4.8',
                            style: TextStyle(
                              color: Theme.of(context).shadowColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              AllText.Autotext(
                  text: "May foot land",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).shadowColor),
              AllText.Autotext(
                  text: "Monastir",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }
}
