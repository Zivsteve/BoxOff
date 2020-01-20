import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:boxoff/utils/date_utils.dart';
import 'package:boxoff/utils/navigation_utils.dart';

class Article extends StatelessWidget {
  final String url;
  final String title;
  final String author;
  final String image;
  final int date;

  Article({
    this.url,
    this.title,
    this.author,
    this.image,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxWidth: 300,
      child: Padding(
        padding: EdgeInsets.all(3),
        child: Material(
          child: InkWell(
            onTap: () => router.navigateTo(context, '/article/$url'),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            title,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Opacity(
                              opacity: 0.5,
                              child: Text(
                                author,
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: 0.3,
                            child: Text(
                              formatTimestamp(date),
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.memoryNetwork(
                    image: image,
                    placeholder: kTransparentImage,
                    fit: BoxFit.fitWidth,
                    width: 400,
                    height: 250,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
