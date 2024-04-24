import 'package:flutter/material.dart';
import 'package:takwira/view/Home/widget/HomeAppBar.dart';
import 'package:takwira/view/Home/widget/SuggestionEquipe.dart';
import 'package:takwira/view/Home/widget/SuggestionStade.dart';
import 'package:takwira/view/Home/widget/nextMatch.dart';
import 'package:takwira/view/widgets/cards/stadeCard.dart';
import 'package:takwira/view/widgets/text/text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 12),
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(children: [
          NextMatch(),
          SizedBox(
            height: 12,
          ),
          Container(
              alignment: Alignment.bottomLeft,
              child: AllText.Autotext(
                  color: Theme.of(context).shadowColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  text: "Suggestions d'équipe")),
          Container(
              margin: EdgeInsets.only(top: 8),
              height: 124,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 23,
                  itemBuilder: (context, index) {
                    return SuggestionEquipe();
                  })),
          SizedBox(
            height: 12,
          ),
          Container(
              alignment: Alignment.bottomLeft,
              child: AllText.Autotext(
                  color: Theme.of(context).shadowColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  text: "Suggestions de terrain")),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 23,
                itemBuilder: (context, index) {
                  return StadeCard(index: index,borderBlue: false,) ;
                }),
          )
        ]),
      ),
    );
  }
}
