import 'dart:convert';
import 'package:boxoff/components/movie_revenue_detail.dart';
import 'package:boxoff/services/content_service.dart';
import 'package:boxoff/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LatestScreen extends StatefulWidget {
  @override
  _LatestScreenState createState() => _LatestScreenState();
}

class _LatestScreenState extends State<LatestScreen> {
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  List topMovies = [];

  @override
  void initState() {
    super.initState();
  }

  void refresh() async {
    try {
      String body = (await ContentService.getTopMovies()).body;
      setState(() => topMovies = json.decode(body));
      _refreshController.refreshCompleted();
    } catch (err) {
      _refreshController.refreshFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.menu), onPressed: () => Scaffold.of(context).openDrawer(), tooltip: 'Menu'),
        title: Column(
          children: <Widget>[
            Text('Box Office'),
            Text(
              formatDate(),
              style: TextStyle(fontSize: 12, color: Colors.white60),
            ),
          ],
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
            child: SvgPicture.asset('assets/usa_icon.svg'),
          ),
        ],
        elevation: 0,
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropMaterialHeader(),
        onRefresh: refresh,
        child: ListView(
          children: <Widget>[
            Container(
              constraints: BoxConstraints(maxWidth: 600),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Opacity(
                      opacity: 0.7,
                      child: Text(
                        'Latest Dailies',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(10),
                    child: Opacity(
                      opacity: 0.5,
                      child: Text(
                        'Domestic / Worldwide',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            for (int i = 0; i < topMovies?.length; i++)
              () {
                final movie = topMovies[i];
                return MovieRevenueDetail(
                    index: i, title: movie['title'], recent: movie['daily'], domestic: movie['total']);
              }(),
          ],
        ),
      ),
    );
  }
}
