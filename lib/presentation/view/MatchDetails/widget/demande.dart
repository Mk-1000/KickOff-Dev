import 'package:flutter/material.dart';
import 'package:takwira/presentation/view/widgets/cards/demandeCard.dart';

class Demande extends StatefulWidget {
  const Demande({super.key});

  @override
  State<Demande> createState() => _DemandeState();
}

class _DemandeState extends State<Demande> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 6,
            itemBuilder: (context, index) {
              return DemandeCard(
                  name: "WaBBro2",
                  photo:
                      "https://media.ouest-france.fr/v1/pictures/bd2dbb25e2f238f85c2ffddf143b9919-14991327.jpg?width=1260&client_id=eds&sign=3e3713a8b509e8dc3140c74b0a5d183947d7a67c000fc700844a9e765fa66d07",
                  postion: "Attaquant",
                  place: "Gardien",
                  id: index);
            },
          ))
        ],
      ),
    );
  }
}
