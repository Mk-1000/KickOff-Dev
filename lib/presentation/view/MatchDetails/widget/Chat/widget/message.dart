import 'package:flutter/material.dart';
import 'package:takwira/presentation/view/widgets/cashedImage/cashedImage.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class MessageUi extends StatelessWidget {
  final String imageUrl;
  final bool me;
  final String content;
  const MessageUi(
      {super.key,
      required this.imageUrl,
      required this.me,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: me ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (me) ...{
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                  color: const Color(0xFFE6F3FF),
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      topLeft: Radius.circular(12))),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.65),
              // width: MediaQuery.of(context).size.width*0.65 ,
              child: AllText.Autotext(
                  text: content,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  textAlign: TextAlign.start),
            )
          } else ...{
            Container(
              margin: const EdgeInsets.only(right: 8),
              height: 48,
              width: 48,
              child: const ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(26)),
                child: CahedImage(
                  img:
                      "https://www.francetvinfo.fr/pictures/tBur4XyZx1u4wpxdnDYs39PmEyg/0x223:5070x3072/2656x1494/filters:format(avif):quality(50)/2022/11/09/636bcaaf33314_066-dppi-40922040-014.jpg",
                  height: 48,
                  width: 48,
                  box: BoxFit.cover,
                ),
              ),
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AllText.Autotext(
                    text: "yassine youssef",
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).shadowColor),
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).bottomAppBarTheme.color!),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.65),
                  // width: MediaQuery.of(context).size.width*0.65 ,
                  child: AllText.Autotext(
                      text: content,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      textAlign: TextAlign.start),
                )
              ],
            )
          },
        ],
      ),
    );
  }
}
