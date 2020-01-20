import 'package:boxoff/utils/navigation_utils.dart';
import 'package:boxoff/utils/number_utils.dart';
import 'package:flutter/material.dart';

class MovieRevenueDetail extends StatelessWidget {
  final int index;
  final String title;
  final int recent;
  final int domestic;

  MovieRevenueDetail({
    this.index = 1,
    this.title,
    this.recent,
    this.domestic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation: 2,
        child: ListTile(
          onTap: () => router.navigateTo(context, '/movie/$title'),
          title: Row(
            children: <Widget>[
              Container(
                width: 35,
                child: Opacity(
                  opacity: 0.5,
                  child: Text("${index + 1}", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '\$${formatNumber(recent)}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$${formatNumber(domestic)}',
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
