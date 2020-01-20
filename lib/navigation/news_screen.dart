import 'dart:convert';
import 'package:transparent_image/transparent_image.dart';

import 'package:boxoff/components/article_detail.dart';
import 'package:boxoff/services/content_service.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  List articles = [];

  @override
  void initState() {
    super.initState();
  }

  void refresh() async {
    try {
      String body = (await ContentService.getNews()).body;
      setState(() => articles = json.decode(body));
      _refreshController.refreshCompleted();
    } catch (err) {
      _refreshController.refreshFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      header: WaterDropMaterialHeader(),
      onRefresh: refresh,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 150,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Box Office News'),
              background: articles.length > 0
                  ? Opacity(
                      opacity: 0.4,
                      child: FadeInImage.memoryNetwork(
                        image: articles[0]['image'],
                        placeholder: kTransparentImage,
                        fit: BoxFit.cover,
                      ),
                    )
                  : null,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final article = articles[index];
              return Article(
                url: article['url'],
                title: article['title'],
                author: article['author'],
                image: article['image'],
                date: article['date'],
              );
            }, childCount: articles?.length ?? 0),
          ),
        ],
      ),
    );
  }
}
