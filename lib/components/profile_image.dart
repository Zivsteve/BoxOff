import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final Color backgroundColor;
  final BoxFit fit;

  ProfileImage(
    this.url, {
    this.width = 160,
    this.height = 250,
    this.backgroundColor = Colors.grey,
    this.fit = BoxFit.fitHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: backgroundColor),
      child: FadeInImage.memoryNetwork(image: url ?? '', placeholder: kTransparentImage, fit: fit),
    );
  }
}
