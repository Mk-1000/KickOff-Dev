import 'package:flutter/material.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/view/widgets/StadeWidget/Stade.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class Info extends StatefulWidget {
  final Team team; 
  const Info({super.key, required this.team});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Stade(defender: widget.team.maxDefenders, mid:  widget.team.maxMidfielders, attack:  widget.team.maxForwards,),

          Expanded(
              child: Container(
            width: double.infinity,
            // decoration: BoxDecoration(
            //     border: Border.all(color: Theme.of(context).primaryColor),
            //     borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 80,
                        child: AllText.Autotext(
                            text: "Joueur",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                      Container(
                        width: 80,
                        child: AllText.Autotext(
                            text: "Position",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                      Container(
                        width: 80,
                        child: AllText.Autotext(
                            text: "Numéro",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                      Container(
                        width: 80,
                        child: AllText.Autotext(
                            text: "Action",
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                  padding: EdgeInsets.only(top: 8),
                  itemCount: widget.team.slots!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFE6F3FF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                            width: 80,
                            height: 32,
                            child: Row(children: [
                              Icon(Icons.add),
                              AllText.Autotext(
                                  text: "Ajouter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context).shadowColor)
                            ]),
                          ),
                          Container(
                            width: 80,
                            child: AllText.Autotext(
                                text: widget.team.slots![index].position.name,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          Container(
                            width: 80,
                            child: AllText.Autotext(
                                text: widget.team.slots![index].number.toString(),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                          Container(
                              width: 80, child: Icon(Icons.more_vert_rounded))
                        ],
                      ),
                    );
                  },
                ))
              ],
            ),
          )),
        ],
      ),
    );
  }
}
