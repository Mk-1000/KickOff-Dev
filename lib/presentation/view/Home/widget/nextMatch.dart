import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/presentation/view/widgets/cards/nextMatchCard.dart';
import 'package:takwira/presentation/view/widgets/cashedImage/cashedImage.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class NextMatch extends StatefulWidget {
  const NextMatch({super.key});

  @override
  State<NextMatch> createState() => _NextMatchState();
}

class _NextMatchState extends State<NextMatch> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AllText.Autotext(
            color: Theme.of(context).shadowColor,
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            text: 'Prochain match'),
        NextMatchCard(
          awayImage:
              'https://upload.wikimedia.org/wikipedia/en/thumb/4/47/FC_Barcelona_%28crest%29.svg/800px-FC_Barcelona_%28crest%29.svg.png',
          nameAway: 'Test1',
          homeImage:
              'https://upload.wikimedia.org/wikipedia/en/thumb/4/47/FC_Barcelona_%28crest%29.svg/800px-FC_Barcelona_%28crest%29.svg.png',
          nameHome: 'test2',
          time: '14/01/23 - 00:30 AM',
          stade: 'MAY Foot Land',
        ),
      ],
    );
  }
}
