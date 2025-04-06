import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/domain/entities/Stadium.dart';
import 'package:takwira/presentation/view/StadeDetail/StadeDetails.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class StadeCard extends StatelessWidget {
  final int index;
  final bool borderBlue;
  final Stadium stadium; // Ajouter cette ligne
  const StadeCard(
      {super.key,
      required this.index,
      required this.stadium, // Modifier cette ligne
      this.borderBlue = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StadeDetails(
              stadiumId: stadium.stadiumId, // Modifier cette ligne
              showReservationButton: true,
              isReserved: true,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 8.h),
        height: 82.h,
        decoration: BoxDecoration(
          border: Border.all(
              color: borderBlue
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).bottomAppBarTheme.color!,
              width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Hero(
              tag: "stade$index",
              child: SizedBox(
                height: 82.h,
                width: 88.w,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ),
                  child: Image.network(
                    stadium.mainImage ??
                        "https://fr.reformsports.com/oachoata/2020/09/mini-futbol-sahasi-ozellikleri-ve-olculeri.jpg",
                    height: 82.h,
                    width: 88.w,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/image/splash.png', // Add a placeholder image in your assets
                        height: 82.h,
                        width: 88.w,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 8),
              width: 2.w,
              height: 100.h,
              color: Theme.of(context).bottomAppBarTheme.color!,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AllText.Autotext(
                      color: Theme.of(context).shadowColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      text: stadium.name), // Modifier cette ligne
                  Row(
                    children: [
                      const Icon(Icons.place_outlined, size: 16),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        stadium.address ?? "", // Modifier cette ligne
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).shadowColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // const Icon(Icons.watch_later_outlined, size: 16),
                      // Text(
                      //   stadium., // Modifier cette ligne
                      //   style: TextStyle(
                      //     fontSize: 11.sp,
                      //     fontWeight: FontWeight.bold,
                      //     color: Theme.of(context).shadowColor,
                      //   ),
                      // ),
                      Container(
                        alignment: Alignment.center,
                        height: 16.sp,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.r))),
                        child: AllText.Autotext(
                            text: "120 prix", // Modifier cette ligne
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
