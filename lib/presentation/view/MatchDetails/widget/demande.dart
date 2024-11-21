import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/view/MatchDetails/widget/blocDemande/bloc/bloc_demande_bloc.dart';
import 'package:takwira/presentation/view/widgets/cards/demandeCard.dart';

class Demande extends StatefulWidget {
  final Team team ;
  static BlocDemandeBloc demande = BlocDemandeBloc();
  const Demande({super.key, required this.team});

  @override
  State<Demande> createState() => _DemandeState();
}

class _DemandeState extends State<Demande> {
    @override
  void initState() {
    //TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_)  {
     Demande.demande.add(loadData(team:widget.team ));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
    BlocBuilder<BlocDemandeBloc, BlocDemandeState>(
            bloc:   Demande.demande,
            builder: (context, state) {
              if (state is BlocDemandeInitial) {
                return Container();
              } else if (state is dataLoaded) {
                return Container(
      // margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: state.invitation.length,
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

              return Container();
            });
    
  }
}
