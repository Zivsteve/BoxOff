import 'package:boxoff/services/content_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StatTableScreen extends StatefulWidget {
  final String type;

  StatTableScreen(this.type);

  @override
  _StatTableScreenState createState() => _StatTableScreenState();
}

class _StatTableScreenState extends State<StatTableScreen> {
  RefreshController _refreshController = RefreshController(initialRefresh: true);
  String statType = '';
  String html = '';

  @override
  void initState() {
    super.initState();
  }

  void refresh() async {
    try {
      String type = widget.type;
      setState(() => statType = type);
      String body = (await ContentService.getStatTable(type)).body;
      setState(() => html = body);
      _refreshController.refreshCompleted();
    } catch (err) {
      _refreshController.refreshFailed();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text(_getStatTitle(statType)), elevation: 0),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropMaterialHeader(),
        onRefresh: refresh,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 100),
                child: Html(
                  data: html,
                  useRichText: false,
                  defaultTextStyle: TextStyle(fontSize: 15, fontFamily: 'sans-serif'),
                  customRender: (node, children) {
                    if (node is dom.Element) {
                      switch (node.localName) {
                        case 'p':
                          return Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(node.text, textAlign: TextAlign.justify),
                          );
                        case 'h1':
                          return Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Text(
                              node.text,
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          );
                        case 'table':
                          return Container(
                            decoration: BoxDecoration(border: Border.all(color: Theme.of(context).accentColor)),
                            margin: EdgeInsets.only(top: 10, bottom: 20),
                            padding: EdgeInsets.all(5),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Column(children: children),
                            ),
                          );
                        case 'a':
                          return Column(children: children);
                        case 'th':
                          return Container(
                              color: Color(0x20000000), width: 200, padding: EdgeInsets.all(5), child: Text(node.text));
                        case 'td':
                          Color textColor = _getTableTextColor(node.text);
                          return Container(
                            width: 200,
                            padding: EdgeInsets.all(5),
                            child: Text(node.text, style: TextStyle(color: textColor)),
                          );
                      }
                    }
                    return null;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStatTitle(String type) {
    DateTime now = DateTime.now();
    String date = DateFormat(statType == 'month' ? 'MMMM' : 'yyyy').format(now);
    return '${toBeginningOfSentenceCase(type)} - $date';
  }

  Color _getTableTextColor(String text) {
    if (text.endsWith('%')) {
      return text.startsWith('-') ? Colors.red : Colors.green;
    }
    return Theme.of(context).accentColor;
  }
}
