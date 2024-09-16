import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/presentation/view/widgets/cashedImage/cashedImage.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class StadeDetails extends StatelessWidget {
  const StadeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: "stade0",
            child: Container(
              height: 265.h,
              child: CahedImage(
                  img:
                      'https://images.midilibre.fr/api/v1/images/view/633da2e473564570454b7579/large-fit/image.jpg?v=1',
                  box: BoxFit.cover),
            ),
          ),
          Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 30.h),
                  padding: EdgeInsets.symmetric(horizontal: 18.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        height: 26.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.star, color: Colors.amber),
                            SizedBox(width: 2),
                            Text(
                              '4.8',
                              style: TextStyle(
                                color: Theme.of(context).shadowColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
              SizedBox(height: 130.h),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AllText.Autotext(
                              text: "May foot land",
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF000B3A)),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.place_outlined,
                                  size: 18.sp,
                                  color: Theme.of(context).primaryColor),
                              AllText.Autotext(
                                  text:
                                      "Route de lapin skanes, Monastir, Tunisia ",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xFF9698A9)),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AllText.Autotext(
                              text: "About",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF000B3A)),
                          SizedBox(height: 8),
                          AllText.Autotext(
                              text:
                                  "Berada di jalur jalan provinsi yang menghubungkan Denpasar.",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF9698A9),
                              textalgin: TextAlign.left),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AllText.Autotext(
                              text: "Photos",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF000B3A)),
                          SizedBox(height: 8),
                          Container(
                            height: 80.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 23,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 80.w,
                                    margin: EdgeInsets.only(right: 12),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      child: CahedImage(
                                          img:
                                              'https://images.midilibre.fr/api/v1/images/view/633da2e473564570454b7579/large-fit/image.jpg?v=1',
                                          box: BoxFit.cover),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                      Container(
                        width: ScreenUtil.defaultSize.width * 0.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AllText.Autotext(
                                text: "Services",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF000B3A)),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle_outlined,
                                          size: 18.sp,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        AllText.Autotext(
                                            text: "Kids Park",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF000B3A)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle_outlined,
                                          size: 18.sp,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        AllText.Autotext(
                                            text: "City Museum",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF000B3A)),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle_outlined,
                                          size: 18.sp,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        AllText.Autotext(
                                            text: "Kids Park",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF000B3A)),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle_outlined,
                                          size: 18.sp,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        SizedBox(
                                          width: 8.h,
                                        ),
                                        AllText.Autotext(
                                            text: "City Museum",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF000B3A)),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AllText.Autotext(
                                      text: "À partir de",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF9698A9)),
                                  SizedBox(height: 8.h),
                                  AllText.Autotext(
                                      text: "5 DT par Joueur",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF000B3A)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AllText.Autotext(
                                      text: "Telephone",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF9698A9)),
                                  SizedBox(height: 8),
                                  AllText.Autotext(
                                      text: "94 345 233",
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF000B3A)),
                                ],
                              ),
                              Container(
                                height: 48.h,
                                width: 48.w,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.r))),
                                child: Icon(
                                  Icons.local_phone_outlined,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
