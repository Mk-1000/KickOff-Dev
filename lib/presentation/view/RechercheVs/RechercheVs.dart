import 'package:flutter/material.dart';
import 'package:takwira/presentation/view/widgets/button/dropDownButton/DropDownButton.dart';
import 'package:takwira/presentation/view/widgets/cards/rechercheEquipeCard.dart';
import 'package:takwira/presentation/view/widgets/forms/InputFild/search.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';


class RechercheVs extends StatefulWidget {
  const RechercheVs({super.key});

  @override
  State<RechercheVs> createState() => _RechercheVsState();
}

class _RechercheVsState extends State<RechercheVs> {
    final TextEditingController searchController = TextEditingController();
  static const int itemCount = 10;
  List<String> postion = ['Gardien', 'Défenseur', 'Milieu', 'Attaquant'];
  List<String> ville = ["Monastir"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new,
              color: Theme.of(context).shadowColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: AllText.Autotext(
            text: "Recherche d'adversaires",
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).shadowColor),
      ),
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
        return RechrcheEquipe(send: true, Index: index, vs: true,);
      },
    );
  }
}