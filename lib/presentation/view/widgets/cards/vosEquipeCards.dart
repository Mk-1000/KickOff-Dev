import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/presentation/view/widgets/cashedImage/cashedImage.dart'; // Assuming CachedImage is the correct class name
import 'package:takwira/presentation/view/widgets/text/text.dart';

class VosEquipeCard extends StatefulWidget {
  final String name;
  final String photo;
  final String postion;
  final String place;
  final bool captine;
  final String id;

  const VosEquipeCard(
      {Key? key,
      required this.photo,
      required this.postion,
      required this.place,
      required this.name,
      required this.captine,
      required this.id})
      : super(key: key);

  @override
  _VosEquipeCardState createState() => _VosEquipeCardState();
}

class _VosEquipeCardState extends State<VosEquipeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 7.0).animate(_animationController);
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero)
            .animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: buildCard(context),
      ),
    );
  }

  Widget buildCard(BuildContext context) {
    const double imageSize = 80;
    const double cornerRadius = 8;
    const double iconSize = 14;
    const EdgeInsets geometryPadding = EdgeInsets.symmetric(horizontal: 8);

    return Container(
      margin: EdgeInsets.only(top: 8.h),
      height: 80.h,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).bottomAppBarTheme.color!),
        borderRadius: BorderRadius.circular(cornerRadius),
      ),
      child: Row(
        children: [
          Hero(
            tag: widget.id,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(cornerRadius),
                bottomLeft: Radius.circular(cornerRadius),
              ),
              child: CahedImage(
                img: widget.photo,
                height: imageSize.h,
                width: imageSize.w,
                box: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: geometryPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AllText.Autotext(
                      text: widget.name,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).shadowColor),
                  Row(
                    children: [
                      Icon(
                        Icons.place_outlined,
                        size: 16.sp,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      AllText.Autotext(
                          text: widget.place,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    ],
                  ),
                  Row(
                    children: [
                      if (widget.captine) ...{
                        Container(
                          alignment: Alignment.center,
                          height: iconSize + 4.w,
                          width: iconSize + 4.w,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: AllText.Autotext(
                                text: "C",
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 8),
                        AllText.Autotext(
                            text: "Capitaine",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                        const SizedBox(width: 16),
                      },
                      Icon(
                        Icons.directions_run,
                        color: Colors.grey,
                        size: 14.sp,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      AllText.Autotext(
                          text: widget.postion,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
