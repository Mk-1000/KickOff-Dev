import 'package:flutter/material.dart';
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
        height: detailsVisible ? 180.h : 120.h,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.place_outlined),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: AllText.Autotext(
                              text: widget.stade,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).shadowColor,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  AllText.Autotext(
                    text: widget.time,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    child: CahedImage(
                      img: widget.homeImage,
                      height: 50.h,
                      width: 44.w,
                      box: BoxFit.contain,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: AllText.Autotext(
                        text: widget.nameHome,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).shadowColor,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
                      const Icon(Icons.keyboard_arrow_down_rounded),
                    ],
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: AllText.Autotext(
                        text: widget.nameAway,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).shadowColor,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(8.r)),
                    child: CahedImage(
                      img: widget.awayImage,
                      height: 50.h,
                      width: 44.w,
                      box: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              if (detailsVisible)
                FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 4.h),
                        Divider(height: 1.h, color: Colors.grey),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                const Icon(
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
                                const Icon(
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
                                const Icon(
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
                        ),
                      ],
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
