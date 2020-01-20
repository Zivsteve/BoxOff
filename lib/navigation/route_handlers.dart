import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'movie_screen.dart';
import 'article_screen.dart';
import 'releases_screen.dart';
import 'stat_table_screen.dart';
import 'person_screen.dart';

var homeHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomeScreen();
});

var movieHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String title = params['title']?.first;
  return MovieScreen(title);
});

var releasesHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ReleasesScreen();
});

var articleHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String url = params['url']?.first;
  return ArticleScreen(url);
});

var personHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params['id']?.first;
  return PersonScreen(id);
});

var statHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String type = params['type']?.first;
  return StatTableScreen(type);
});
