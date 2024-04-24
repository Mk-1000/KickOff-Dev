 import 'package:flutter/material.dart';
import 'package:takwira/view/Home/widget/HomeAppBar.dart';
import 'package:takwira/view/widgets/button/dropDownButton/DropDownButton.dart';
import 'package:takwira/view/widgets/cards/rechercheEquipeCard.dart';
import 'package:takwira/view/widgets/cards/stadeCard.dart';
import 'package:takwira/view/widgets/cards/vosEquipeCards.dart';
import 'package:takwira/view/widgets/forms/InputFild/search.dart';

class Stades extends StatefulWidget {
  const Stades({Key? key}) : super(key: key);

  @override
  State<Stades> createState() => _StadesState();
}

class _StadesState extends State<Stades> {
  final TextEditingController searchController = TextEditingController();
  static const int itemCount = 10;
  List<String> postion = ['Gardien', 'Défenseur', 'Milieu', 'Attaquant'];
  List<String> ville = ["Monastir"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: HomeAppBar(),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Search(controller: searchController, hint: 'Recherche'),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropDuwnButton(list: postion),
                  DropDuwnButton(list: ville),
                ],
              ),
              Expanded(
                child: _buildListView(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return StadeCard(index: index,);
      },
    );
  }
}
