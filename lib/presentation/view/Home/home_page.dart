import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/presentation/view/Home/widget/HomeAppBar.dart';
import 'package:takwira/presentation/view/Home/widget/SuggestionEquipe.dart';
import 'package:takwira/presentation/view/Home/widget/SuggestionStade.dart';
import 'package:takwira/presentation/view/Home/widget/nextMatch.dart';
import 'package:takwira/presentation/view/widgets/cards/stadCardVertical.dart';
import 'package:takwira/presentation/view/widgets/cards/stadeCard.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Container(
        padding: EdgeInsets.only(top: 12.h),
        margin: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(children: [
          NextMatch(),
          SizedBox(
            height: 12.h,
          ),
          Container(
              alignment: Alignment.bottomLeft,
              child: AllText.Autotext(
                  color: Theme.of(context).shadowColor,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  text: "Suggestions d'équipe")),
          Container(
              margin: EdgeInsets.only(top: 8),
              height: 124,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 23,
                  itemBuilder: (context, index) {
                    return SuggestionEquipe();
                  })),
          SizedBox(
            height: 12,
          ),
          Container(
              alignment: Alignment.bottomLeft,
              child: AllText.Autotext(
                  color: Theme.of(context).shadowColor,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  text: "Suggestions de terrain")),
          SizedBox(
            height: 8.h,
          ),
          /*           Expanded(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 23,
                itemBuilder: (context, index) {
                  return StadeCard(
                    index: index,
                    borderBlue: false,
                  );
                }),
          ) */
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 23,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return StadeCardVertical(
                    index: index,
                    borderBlue: false,
                  );
                }),
          )
        ]),
      ),
    );
  }
}
