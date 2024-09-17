import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/domain/entities/Player.dart';
import 'package:takwira/domain/entities/Team.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class SuggestionEquipe extends StatefulWidget {
  Team? team;
  Player? player;

  SuggestionEquipe({super.key, this.player, this.team});

  @override
  State<SuggestionEquipe> createState() => _SuggestionEquipeState();
}

class _SuggestionEquipeState extends State<SuggestionEquipe> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            width: 140.w,
            height: 120.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(color: Theme.of(context).primaryColor, width: 6),
            ),
            child: CircleAvatar(
              radius: 90.r,
              backgroundImage: NetworkImage(
                  scale: 5,
                  'https://upload.wikimedia.org/wikipedia/en/thumb/4/47/FC_Barcelona_%28crest%29.svg/800px-FC_Barcelona_%28crest%29.svg.png'),
              backgroundColor: Colors.transparent,
            ),
          ),
          Positioned(
            bottom: 10.h,
            left: 42.w,
            child: Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                child: AllText.Autotext(
                    text: "Gratuite",
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
