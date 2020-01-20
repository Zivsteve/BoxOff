import 'dart:convert';
import 'package:boxoff/components/movie_image_detail.dart';
import 'package:boxoff/services/content_service.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReleasesScreen extends StatefulWidget {
  const ReleasesScreen({Key key}) : super(key: key);

  @override
  _ReleasesScreenState createState() => _ReleasesScreenState();
}

class _ReleasesScreenState extends State<ReleasesScreen> {
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  Map upcomingSchedule = {};
  List theaterMovies = [];

  @override
  void initState() {
    super.initState();
  }

  void refresh() async {
    try {
      String body = (await ContentService.getUpcomingMovies()).body;
      setState(() => upcomingSchedule = json.decode(body));
      body = (await ContentService.getNowPlayingMovies()).body;
      setState(() => theaterMovies = json.decode(body));
    } catch (err) {}
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Release Schedule'),
          elevation: 0,
          bottom: TabBar(
            tabs: [Tab(text: 'Upcoming'), Tab(text: 'Now Playing')],
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: new BubbleTabIndicator(
              indicatorHeight: 30,
              indicatorColor: Color(0x50000000),
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _tab1(),
            _tab2(),
          ],
        ),
      ),
    );
  }

  Widget _tab1() {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      header: WaterDropMaterialHeader(),
      onRefresh: refresh,
      child: ListView.builder(
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: upcomingSchedule?.length,
        itemBuilder: (context, index) {
          final date = upcomingSchedule.keys.elementAt(index);
          final releases = upcomingSchedule.values.elementAt(index);
          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  date,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 0.675,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: releases?.length,
                  itemBuilder: (context, i) =>
                      MovieImageDetail(image: releases[i]['poster_path'], title: releases[i]['title']),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _tab2() {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      header: WaterDropMaterialHeader(),
      onRefresh: refresh,
      child: Container(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: 0.675,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: theaterMovies?.length,
          itemBuilder: (context, i) =>
              MovieImageDetail(image: theaterMovies[i]['poster_path'], title: theaterMovies[i]['title']),
        ),
      ),
    );
  }
}
