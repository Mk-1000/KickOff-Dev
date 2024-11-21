import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/PositionSlot.dart';
import 'package:takwira/presentation/managers/TeamManager.dart';
import 'package:takwira/presentation/view/widgets/button/dropDownButton/DropDownButton.dart';
import 'package:takwira/presentation/view/widgets/cards/invitCard.dart';
import 'package:takwira/presentation/view/widgets/forms/InputFild/search.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class addPlayerBottomSheet extends StatefulWidget {
    final String teamID ; 
   final String slotID ; 
    bool publique ; 
   addPlayerBottomSheet({super.key, required this.teamID, required this.slotID, required this.publique});

  @override
  State<addPlayerBottomSheet> createState() => _addPlayerBottomSheetState();
}

class _addPlayerBottomSheetState extends State<addPlayerBottomSheet> {
  bool gratuit = false ; 
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
     Widget _buildAnimatedSearchBar() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, -50 * (1 - value)),
            child: child,
          ),
        );
      },
      
      child: Search(controller: searchController, hint: 'Recherche'),
    );
  }
      List<String> postion = ['Gardien', 'Défenseur', 'Milieu', 'Attaquant'];
  List<String> ville = ["Monastir"];
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 24  ,left: 24 , right: 24),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Icon(Icons.arrow_back_ios_new_rounded),
              Container(
        margin: EdgeInsets.only(left: 8, right: 29),
        alignment: Alignment.center,
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: AllText.Autotext(
            text: "1",
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
                   
                      Container(
            alignment: Alignment.center,
            child: AllText.Autotext(text: "Gardien", fontSize: 18, fontWeight: FontWeight.w700, color: Theme.of(context).shadowColor)), 
             Icon(Icons.arrow_forward_ios_rounded),
            ],),
            SizedBox(height: 24,),
        
      
      
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              AllText.Autotext(
            text: "publique",
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.black),
            Switch(
              value: widget.publique, 
              onChanged: (value) {
                if(value) {
                  TeamManager().updateSlotStatusToPublic(widget.teamID , widget.slotID);
                }else{
 TeamManager().updateSlotStatusToPrivate(widget.teamID , widget.slotID) ; 
                }
                setState(() {
                  widget.publique = ! widget.publique; 
                });
              }),
      
                 AllText.Autotext(
            text: "Gratuitement",
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.black),
            Switch(
              value: gratuit, 
              onChanged: (value) {
                setState(() {
                  gratuit = !gratuit; 
                });
              })
            ],),
            _buildAnimatedSearchBar(), 
            SizedBox(height: 12,),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               DropDuwnButton(list: postion,),
          DropDuwnButton(list: ville, ),
          ],),
          Expanded(
            child:ListView.builder(
        padding: const EdgeInsets.only(top: 8, bottom: 16),
        itemCount: 10,
        itemBuilder: (context, index) {
         //TeamManager().updateSlotStatusToPublic(teams[index].teamId,teams[index].slots[2].slotId);
          return InvitCard(player: Player(email: "", nickname: "yass", birthdate: DateTime.now(), preferredPosition: Position.Defender, phoneNumber: "", jerseySize: ""),);
        },
      )
           ,)
        ],),
      ),
    );
  }
}