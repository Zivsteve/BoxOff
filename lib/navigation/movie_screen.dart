import 'dart:convert';
import 'package:boxoff/components/person_detail.dart';
import 'package:boxoff/components/poster.dart';
import 'package:boxoff/utils/date_utils.dart';
import 'package:boxoff/utils/number_utils.dart';
import 'package:boxoff/services/content_service.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MovieScreen extends StatefulWidget {
  final String title;

  MovieScreen(this.title);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  String _title = '';
  String _errorMsg = '';
  Map movie;
  Map stats;

  @override
  void initState() {
    super.initState();
  }

  void refresh() async {
    try {
      _title = widget.title;
      String body = (await ContentService.getMovie(_title)).body;
      setState(() => movie = json.decode(body));
      body = (await ContentService.getMovie(_title, true)).body;
      setState(() => stats = json.decode(body));
      _refreshController.refreshCompleted();
    } catch (err) {
      if (mounted)
        setState(() {
          _errorMsg = 'Can\'t find any information about this movie';
        });
      _refreshController.refreshFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropMaterialHeader(),
        onRefresh: refresh,
        child: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 150,
              floating: false,
              pinned: false,
              backgroundColor: Color.fromARGB(20, 0, 0, 0),
              flexibleSpace: FlexibleSpaceBar(
                background: movie != null
                    ? Image.network(
                        movie['backdrop_path'] ?? movie['poster_path'],
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            SliverToBoxAdapter(
              child: movie != null
                  ? _buildBody()
                  : !_refreshController.isRefresh
                      ? Container(
                          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 50),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  _title,
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                _errorMsg,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    var domestic = formatCurrency(stats != null && stats['domestic']['value'] > 0 ? stats['domestic']['value'] : '--');
    var international =
        formatCurrency(stats != null && stats['international']['value'] > 0 ? stats['international']['value'] : '--');
    var worldwide =
        formatCurrency(stats != null && stats['worldwide']['value'] > 0 ? stats['worldwide']['value'] : '--');
    var budget = formatCurrency(movie['budget'] > 0 ? movie['budget'] : '--');
    var companies = movie['production_companies'].where((i) => i['logo_path'] != null).toList();
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 200),
          padding: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Poster(movie['poster_path']),
                        ),
                        Text(
                          movie['title'],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            getReadableDuration(movie['runtime']),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "Release Date:",
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        for (var date in movie['release_dates'])
                          () {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('${formatDate(date['release_date'])}'),
                                Text(' (${date['type']})')
                              ],
                            );
                          }(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              height: 50,
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.black,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Rated', style: TextStyle(color: Colors.white70)),
                                  Text(
                                    '${movie['certification']}',
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                            Tooltip(
                              message: 'Audience Score',
                              child: Stack(
                                children: <Widget>[
                                  SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 5,
                                        value: movie['vote_average'] / 10,
                                        backgroundColor: Colors.black12,
                                        valueColor: AlwaysStoppedAnimation(_getColorForValue(movie['vote_average'])),
                                      )),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${movie['vote_average']}',
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          spacing: 2,
                          runSpacing: -13,
                          children: <Widget>[
                            for (var genre in movie['genres'])
                              Chip(label: Text(genre['name'], style: TextStyle(fontSize: 12))),
                          ],
                        ),
                        ListTile(
                          title: Text(
                            'Domestic (${stats != null && stats['domestic']['percent'] != null ? stats['domestic']['percent'] : '--'})'
                                .toUpperCase(),
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          subtitle: Text(formatCurrency(domestic)),
                          dense: true,
                        ),
                        ListTile(
                          title: Text(
                            'International (${stats != null && stats['international']['percent'] != null ? stats['international']['percent'] : '--'})'
                                .toUpperCase(),
                            style: revenueTitleStyle,
                          ),
                          subtitle: Text(international),
                          dense: true,
                        ),
                        ListTile(
                          title: Text(
                            'Worldwide'.toUpperCase(),
                            style: revenueTitleStyle,
                          ),
                          subtitle: Text(
                            worldwide,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          dense: true,
                        ),
                        ListTile(
                          title: Text(
                            'Budget'.toUpperCase(),
                            style: revenueTitleStyle,
                          ),
                          subtitle: Text(budget),
                          dense: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          for (var company in companies)
                            Text(company['name'],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                )),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(30),
                        child: Text(
                          movie['overview'],
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Text(
                        'Cast',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Container(
                        height: 270,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: movie['credits']['cast'].length,
                          itemBuilder: (context, i) {
                            final actor = movie['credits']['cast'][i];
                            return PersonDetail(
                              id: actor['id'],
                              name: actor['name'],
                              image: actor['profile_path'],
                              role: actor['character'],
                            );
                          },
                        ),
                      ),
                      Text(
                        'Crew',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Container(
                        height: 270,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: movie['credits']['crew'].length,
                          itemBuilder: (context, i) {
                            final person = movie['credits']['crew'][i];
                            return PersonDetail(
                              id: person['id'],
                              name: person['name'],
                              image: person['profile_path'],
                              role: person['job'],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getColorForValue(num val) {
    if (val < 3)
      return Colors.red[900];
    else if (val < 5)
      return Colors.red;
    else if (val < 7)
      return Colors.yellow;
    else if (val < 8)
      return Colors.lightGreen;
    else
      return Colors.green;
  }
}

var revenueTitleStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 12,
);
