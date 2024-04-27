import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:takwira/presentation/view/widgets/cashedImage/cashedImage.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class Message extends StatelessWidget {
  final String imageUrl;
  final bool me;
  const Message({super.key, required this.imageUrl, required this.me});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: me ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (me) ...{
            Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                  color: Color(0xFFE6F3FF),
                  border: Border.all(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      topLeft: Radius.circular(12))),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.65),
              // width: MediaQuery.of(context).size.width*0.65 ,
              child: AllText.Autotext(
                  text:
                      "Nous et nos partenaires sollicitons votre consentement afin de traiter vos donné",
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  textalgin: TextAlign.start),
            )
          } else ...{
            Container(
              margin: EdgeInsets.only(right: 8),
              height: 48,
              width: 48,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(26)),
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
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).bottomAppBarColor),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12))),
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.65),
                  // width: MediaQuery.of(context).size.width*0.65 ,
                  child: AllText.Autotext(
                      text:
                          "Nous et nos partenaires sollicitons votre consentement afin de traiter vos donné",
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      textalgin: TextAlign.start),
                )
              ],
            )
          },
        ],
      ),
    );
  }
}
