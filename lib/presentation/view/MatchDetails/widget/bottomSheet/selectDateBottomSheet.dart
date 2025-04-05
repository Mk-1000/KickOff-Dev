import 'package:flutter/material.dart';
import 'package:takwira/presentation/view/widgets/button/dropDownButton/DropDownButton.dart';
import 'package:takwira/presentation/view/widgets/button/dropDownButton/DropDownTeam.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class selectDateBottomSheet extends StatefulWidget {
  const selectDateBottomSheet({super.key});

  @override
  State<selectDateBottomSheet> createState() => _selectDateBottomSheetState();
}

class _selectDateBottomSheetState extends State<selectDateBottomSheet> {
  List<String> postion = ['Gardien', 'Défenseur', 'Milieu', 'Attaquant'];
  List<String> ville = ["Monastir"];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24, left: 24, right: 24),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              alignment: Alignment.center,
              child: AllText.Autotext(
                  text: "Annoncer votre équipe",
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).shadowColor)),
          const SizedBox(
            height: 32,
          ),
          AllText.Autotext(
              text: "Select Your Team",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).shadowColor),
          const SizedBox(
            height: 12,
          ),
          const DropDownTeam(
            list: ["hi", "heyy"],
          ),
          const SizedBox(
            height: 24,
          ),
          AllText.Autotext(
              text: "Select Your stade",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).shadowColor),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropDuwnButton(
                list: postion,
              ),
              DropDuwnButton(
                list: ville,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          DropDuwnButton(
            list: ville,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
