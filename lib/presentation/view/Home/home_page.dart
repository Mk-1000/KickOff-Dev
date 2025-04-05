import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/presentation/view/Home/widget/HomeAppBar.dart';
import 'package:takwira/presentation/view/Home/widget/SuggestionEquipe.dart';
import 'package:takwira/presentation/view/Home/widget/nextMatch.dart';
import 'package:takwira/presentation/view/widgets/cards/stadCardVertical.dart';
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
      appBar: const HomeAppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 12.h),
          margin: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const NextMatch(),
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
                SizedBox(height: 8.h),
                SizedBox(
                    height: 135.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 23,
                        itemBuilder: (context, index) {
                          return SuggestionEquipe();
                        })),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                    alignment: Alignment.bottomLeft,
                    child: AllText.Autotext(
                        color: Theme.of(context).shadowColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w600,
                        text: "Suggestions de terrain")),
                SizedBox(height: 8.h),
                SizedBox(
                  height: 250.h,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 23,
                      itemBuilder: (context, index) {
                        return StadeCardVertical(
                          index: index,
                          borderBlue: false,
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
