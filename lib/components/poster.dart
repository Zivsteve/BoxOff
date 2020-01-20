import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Poster extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final Color backgroundColor;
  final BoxFit fit;

  Poster(
    this.url, {
    this.width = 200,
    this.height = 300,
    this.backgroundColor = Colors.grey,
    this.fit = BoxFit.cover,
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
