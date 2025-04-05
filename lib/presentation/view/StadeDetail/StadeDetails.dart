import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/presentation/view/widgets/cashedImage/cashedImage.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:takwira/presentation/view/widgets/cashedImage/cashedImage.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class StadeDetails extends StatefulWidget {
  final bool showReservationButton;
  final bool isReserved;

  const StadeDetails({
    super.key,
    required this.showReservationButton,
    this.isReserved = false,
  });

  @override
  State<StadeDetails> createState() => _StadeDetailsState();
}

class _StadeDetailsState extends State<StadeDetails> {
  late bool _isCurrentlyReserved;

  @override
  void initState() {
    super.initState();
    _isCurrentlyReserved = widget.isReserved;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: "stade0",
            child: SizedBox(
              height: 265.h,
              child: const CahedImage(
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
                        icon: const Icon(Icons.arrow_back_ios_new),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        height: 26.h,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(Icons.star, color: Colors.amber),
                            const SizedBox(width: 2),
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
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AllText.Autotext(
                              text: "May foot land",
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF000B3A)),
                          if (!widget.showReservationButton)
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _isCurrentlyReserved = !_isCurrentlyReserved;
                                });
                                // TODO: Implement actual reservation/cancellation API call
                                print(_isCurrentlyReserved
                                    ? "Réserver"
                                    : "Annuler");
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(_isCurrentlyReserved
                                  ? "Annuler"
                                  : "Réserver"),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.place_outlined,
                              size: 14.sp,
                              color: Theme.of(context).primaryColor),
                          AllText.Autotext(
                              text: "Route de lapin skanes, Monastir, Tunisia ",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              color: const Color(0xFF9698A9)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30.h),
                          AllText.Autotext(
                              text: "Photos",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF000B3A)),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 80.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 23,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: 80.w,
                                    margin: const EdgeInsets.only(right: 12),
                                    child: const ClipRRect(
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AllText.Autotext(
                                      text: "À partir de",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w300,
                                      color: const Color(0xFF9698A9)),
                                  SizedBox(height: 8.h),
                                  AllText.Autotext(
                                      text: "5 DT par Joueur",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF000B3A)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AllText.Autotext(
                                      text: "Téléphone",
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w300,
                                      color: const Color(0xFF9698A9)),
                                  const SizedBox(height: 8),
                                  AllText.Autotext(
                                      text: "94 345 233",
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF000B3A)),
                                ],
                              ),
                              Container(
                                height: 48.h,
                                width: 48.w,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.r))),
                                child: const Icon(
                                  Icons.local_phone_outlined,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
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
