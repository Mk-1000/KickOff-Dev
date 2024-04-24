import 'package:flutter/material.dart';
import 'package:takwira/view/widgets/cashedImage/cashedImage.dart';
import 'package:takwira/view/widgets/text/text.dart';

class DemandeCard extends StatelessWidget {
  final String name;
  final String photo;
  final String postion;
  final String place;
  final int id;
  const DemandeCard(
      {super.key,
      required this.name,
      required this.photo,
      required this.postion,
      required this.place,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      height: 72,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Hero(
              tag: "id_" + id.toString(),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(26)),
                child: CahedImage(
                  img: photo,
                  height: 48,
                  width: 48,
                  box: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(Icons.person_outline_outlined,size: 18,),
                    AllText.Autotext(
                        text: name,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).shadowColor),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.directions_run, color: Colors.grey,size: 18,),
                    AllText.Autotext(
                        text: "Capitaine",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey),
                  ],
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: AllText.Autotext(
                          text: "7",
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 6),
                      child: AllText.Autotext(
                          text: place,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).shadowColor),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.place_outlined, color: Colors.grey,size: 18,),
                    AllText.Autotext(
                        text: postion,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ],
                ),
              ],
            ), 
            
            Container(
              height: 32,
              width: 32,
                decoration: BoxDecoration(
    border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.all(
        Radius.circular(4.0) //                 <--- border radius here
    ),
  ),
  // close
  child: Icon(Icons.close,color: Colors.red,) ,
            ),
                        Container(
              height: 32,
              width: 32,
                decoration: BoxDecoration(
    border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.all(
        Radius.circular(4.0) //                 <--- border radius here
    ),
  ),
  // close
  child: Icon(Icons.check_rounded,color: Theme.of(context).primaryColor,) ,
            ),
            
            // Expanded(
            //   child: Padding(
            //     padding: EdgeInsets.zero,
            //     child:
            //     Column(
            //       // crossAxisAlignment: CrossAxisAlignment.s,
            //       // mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           children: [
            //             const Icon(Icons.person_outline_outlined),
            //             AllText.Autotext(text: name, fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).shadowColor),

            //                 Container(
            //               alignment: Alignment.center,
            //               height: 12,
            //               width: 12,
            //               decoration: BoxDecoration(
            //                 color: Theme.of(context).primaryColor,
            //                 borderRadius: BorderRadius.circular(4),
            //               ),
            //               child: AllText.Autotext(text: "7", fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
            //             ),
            //             AllText.Autotext(text: place, fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).shadowColor),
            //           ],
            //         ),
            //         Row(
            //            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //           children: [
            //                  const Icon(Icons.directions_run, color: Colors.grey),
            //             AllText.Autotext(text: "Capitaine", fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey),

            //             const Icon(Icons.place_outlined, color: Colors.grey),
            //             AllText.Autotext(text: postion, fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
