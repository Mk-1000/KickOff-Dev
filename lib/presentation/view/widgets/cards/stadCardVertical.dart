import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/presentation/view/StadeDetail/StadeDetails.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class StadeCardVertical extends StatelessWidget {
  final int index;
  final bool borderBlue;
  const StadeCardVertical(
      {super.key, required this.index, this.borderBlue = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const StadeDetails()),
        );
      },
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "stade" + index.toString(),
                child: Container(
                  height: 190.h,
                  width: 170.w,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          "https://images.midilibre.fr/api/v1/images/view/633da2e473564570454b7579/large-fit/image.jpg?v=1",
                          height: 190.h,
                          width: 170.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          height: 36,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              SizedBox(width: 1),
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
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Container(
                width: 175.w,
                padding: EdgeInsets.only(left: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AllText.Autotext(
                        color: Theme.of(context).shadowColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        text: 'MAY Foot Land'),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(left: 12),
                      alignment: Alignment.center,
                      height: 16,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: AllText.Autotext(
                          text: "8 DT",
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              Container(
                width: 170.w,
                padding: EdgeInsets.only(left: 5.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.place_outlined, size: 16),
                    Text(
                      "Monastir / MAY Foot Land",
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).shadowColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 30.w,
          )
        ],
      ),
    );
    ;
  }
}
