import 'dart:convert';
import 'package:boxoff/services/content_service.dart';
import 'package:boxoff/utils/date_utils.dart';
import 'package:boxoff/components/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PersonScreen extends StatefulWidget {
  final String id;

  PersonScreen(this.id);

  @override
  _PersonScreenState createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  Map details;

  @override
  void initState() {
    super.initState();
  }

  void refresh() async {
    try {
      String id = widget.id;
      String body = (await ContentService.getPerson(id)).body;
      setState(() => details = json.decode(body));
      _refreshController.refreshCompleted();
    } catch (err) {
      _refreshController.refreshFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(elevation: 0),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropMaterialHeader(),
        onRefresh: refresh,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: details != null
                  ? Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: ProfileImage(details['profile_path'] ?? '', width: 160, height: 250),
                        ),
                        Text(details['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Opacity(
                          opacity: 0.5,
                          child: Text(
                            'Birthday',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                        details['birthday'] != null
                            ? Text(
                                '${formatDate(details['birthday'])} (age ${getYearsSince(details['birthday'])})',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            : Text('--'),
                        Text(details['place_of_birth'] ?? '', style: TextStyle(fontSize: 13)),
                        Text(
                          details['deathday'] != null ? 'Died ${formatDate(details['deathday'])}' : '',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(bottom: 100),
                          child: Text(
                            details['biography'],
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
