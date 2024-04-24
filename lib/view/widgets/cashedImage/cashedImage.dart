import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class CahedImage extends StatefulWidget {
  final String  img  ;
  final double? height ;
  final double? width;
  final BoxFit? box  ;
   CahedImage({super.key, required this.img,  this.height,  this.width,  this.box});

  @override
  State<CahedImage> createState() => _CahedImageState();
}

class _CahedImageState extends State<CahedImage> {
  set() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
      });
    });
    return Container() ;
  }
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: widget.height,
      width: widget.width,
      fit: widget.box,
      imageUrl:widget.img,
      errorWidget: (context, url, error) => set(),
    );
  }
}