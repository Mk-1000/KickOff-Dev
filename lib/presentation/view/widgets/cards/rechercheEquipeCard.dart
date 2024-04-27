import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takwira/presentation/view/widgets/cashedImage/cashedImage.dart';
import 'package:takwira/presentation/view/widgets/text/text.dart';

class RechrcheEquipe extends StatefulWidget {
  final bool send;
  const RechrcheEquipe({super.key, required this.send});

  @override
  State<RechrcheEquipe> createState() => _RechrcheEquipeState();
}

class _RechrcheEquipeState extends State<RechrcheEquipe> {
  late bool send;
  @override
  void initState() {
    send = widget.send;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      height: 100,
      decoration: BoxDecoration(
        border:
            Border.all(color: Theme.of(context).bottomAppBarColor, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(width: 8),
          Container(
            width: 65,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  child: Image.network(
                    "https://assets-fr.imgfoot.com/media/cache/642x382/osasuna-madridliga2324.jpg",
                    height: 54,
                    width: 54,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "WaBBro2",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).shadowColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            width: 2,
            height: 100,
            color: Theme.of(context).bottomAppBarColor,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.place_outlined, size: 16),
                    Text(
                      "Monastir / MAY Foot Land",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).shadowColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.watch_later_outlined, size: 16),
                    Text(
                      "24 Jan 2024 / 23:00 H",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).shadowColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.directions_run, size: 16),
                    Text(
                      "Gardien",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).shadowColor,
                      ),
                    ),
                    Icon(Icons.attach_money, size: 16),
                    Text(
                      "10 TND",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).shadowColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 47,
                child: SvgPicture.asset(
                  "assets/image/reserved.svg",
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 6, right: 6),
                height: 25,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                      color:
                          send ? Colors.white : Theme.of(context).primaryColor,
                      border: Border.all(
                        color: send
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(4)),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() => send = !send);
                    },
                    // style:
                    // send ? OutlinedButton.styleFrom(
                    //          primary: Theme.of(context).primaryColor,
                    //          side:  BorderSide(color: Theme.of(context).primaryColor),
                    //          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    //          backgroundColor: Colors.white,
                    //        ): ElevatedButton.styleFrom(
                    //   primary: Theme.of(context).primaryColor,
                    //   shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(4),
                    //   ),
                    // ),
                    child: Text(
                      send ? "Annuler" : "Envoyer",
                      style: TextStyle(
                        color: send
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
