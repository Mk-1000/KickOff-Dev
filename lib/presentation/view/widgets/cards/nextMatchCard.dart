import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/presentation/view/widgets/cashedImage/cashedImage.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class NextMatchCard extends StatefulWidget {
  final String stade;
  final String time;
  final String homeImage;
  final String awayImage;
  final String nameHome;
  final String nameAway;

  const NextMatchCard({
    super.key,
    required this.stade,
    required this.time,
    required this.homeImage,
    required this.awayImage,
    required this.nameHome,
    required this.nameAway,
  });

  @override
  State<NextMatchCard> createState() => _NextMatchCardState();
}

class _NextMatchCardState extends State<NextMatchCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool detailsVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _fadeAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleDetails() {
    setState(() {
      detailsVisible = !detailsVisible;
    });
    _animationController.reset();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (detailsVisible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleDetails,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(top: 8.h),
        width: double.infinity,
        height: detailsVisible ? 162.h : 100.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(Icons.place_outlined),
                      AllText.Autotext(
                        text: widget.stade,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).shadowColor,
                      ),
                    ],
                  ),
                  AllText.Autotext(
                    text: widget.time,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: CahedImage(
                      img: widget.homeImage,
                      height: 50.h,
                      width: 44.w,
                      box: BoxFit.cover,
                    ),
                  ),
                  AllText.Autotext(
                    text: widget.nameHome,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).shadowColor,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AllText.Autotext(
                        text: "Vs",
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                      Icon(Icons.keyboard_arrow_down_rounded),
                    ],
                  ),
                  AllText.Autotext(
                    text: widget.nameAway,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).shadowColor,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    child: CahedImage(
                      img: widget.awayImage,
                      height: 50.h,
                      width: 44.w,
                      box: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: detailsVisible
                      ? Column(
                          children: [
                            SizedBox(
                              height: 8.h,
                            ),
                            Divider(height: 1.h, color: Colors.grey),
                            SizedBox(
                              height: 8.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Icons.place_outlined,
                                      color: Colors.grey,
                                    ),
                                    AllText.Autotext(
                                      text: "Direction",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.local_phone_outlined,
                                      color: Colors.grey,
                                    ),
                                    AllText.Autotext(
                                      text: "Appeler le capitaine",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Icons.share_outlined,
                                      color: Colors.grey,
                                    ),
                                    AllText.Autotext(
                                      text: "Publier",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      : SizedBox(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
