import 'package:flutter/material.dart';
import 'package:takwira/view/widgets/button/dropDownButton/DropDownButton.dart';
import 'package:takwira/view/widgets/cards/rechercheEquipeCard.dart';
import 'package:takwira/view/widgets/cards/vosEquipeCards.dart';
import 'package:takwira/view/widgets/forms/InputFild/search.dart';

class RechercheEquipe extends StatefulWidget {
  const RechercheEquipe({Key? key}) : super(key: key);

  @override
  State<RechercheEquipe> createState() => _RechercheEquipeState();
}

class _RechercheEquipeState extends State<RechercheEquipe> {
  final TextEditingController searchController = TextEditingController();
  static const int itemCount = 10;
  List<String> postion = ['Gardien', 'Défenseur', 'Milieu', 'Attaquant'];
  List<String> ville = ["Monastir"];


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAnimatedSearchBar(),
        SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             DropDuwnButton(list: postion,),
        DropDuwnButton(list: ville,),
        ],),
     
        Expanded(
          child: _buildAnimatedListView(),
        )
      ],
    );
  }

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

  Widget _buildAnimatedListView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return _buildSlideFromBottomCard(index);
      },
    );
  }

  Widget _buildSlideFromBottomCard(int index) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 400 + index * 200),
      curve: Curves.easeOut,
      tween: Tween<double>(begin: 1, end: 0),
      builder: (context, double value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * value),
          child: Opacity(
            opacity: 1 - value,
            child: child,
          ),
        );
      },
      child: RechrcheEquipe(send: true,)
      //  const VosEquipeCard(
      //   name: 'WaaBroo',
      //   photo: 'https://assets-fr.imgfoot.com/media/cache/642x382/osasuna-madridliga2324.jpg',
      //   place: 'Monastir',
      //    captine: true, postion: 'Milieu',
      // ),
    );
  }
}
