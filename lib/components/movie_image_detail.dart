import 'package:boxoff/components/poster.dart';
import 'package:boxoff/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class MovieImageDetail extends StatelessWidget {
  final String image;
  final String title;
  final double width;
  final double height;

  MovieImageDetail({
    this.image,
    this.title,
    this.width = 200,
    this.height = 300,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Card(
        elevation: 2,
        child: InkWell(
          onTap: () {
            router.navigateTo(context, '/movie/$title');
          },
          child: Tooltip(
            message: title,
            child: Poster(image),
          ),
        ),
      ),
    );
  }
}
