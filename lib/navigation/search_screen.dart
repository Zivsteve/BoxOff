import 'dart:convert';
import 'package:boxoff/components/movie_image_detail.dart';
import 'package:boxoff/services/content_service.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchField = TextEditingController();
  List results = [];
  List movies = [];

  @override
  void initState() {
    super.initState();
  }

  void _onChanged(String val) async {
    try {
      if (val.length < 2) {
        throw Error();
      }
      String body = (await ContentService.getSearchAutocomplete(val)).body;
      setState(() => results = json.decode(body));
    } catch (e) {
      setState(() => results = []);
    }
  }

  void _onSubmitted(String val) async {
    FocusScope.of(context).unfocus();
    setState(() => results = []);
    try {
      if (val.length < 2) {
        throw Error();
      }
      String body = (await ContentService.getSearchResults(val)).body;
      setState(() => movies = json.decode(body));
    } catch (e) {
      setState(() => movies = []);
    }
    searchField.text = val;
  }

  void _clearInput() {
    searchField.clear();
    _onChanged(null);
    _onSubmitted(null);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: TextField(
          controller: searchField,
          onChanged: _onChanged,
          onSubmitted: _onSubmitted,
          autofocus: true,
          decoration: InputDecoration.collapsed(hintText: 'Search', hintStyle: TextStyle(color: Colors.white54)),
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: _clearInput,
            tooltip: 'Clear',
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 0.675,
            ),
            itemCount: movies?.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieImageDetail(image: movie['poster_path'], title: movie['title']);
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: screenWidth * 0.95,
              constraints: BoxConstraints(maxWidth: 600, maxHeight: 250),
              child: results.length > 0
                  ? Card(
                      child: Column(
                        children: <Widget>[
                          for (var result in results)
                            ListTile(
                              onTap: () => _onSubmitted(result),
                              title: Text(truncate(result, 100), style: TextStyle(color: Color(0xff000000))),
                              dense: true,
                            ),
                        ],
                      ),
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

String truncate(String str, int len) {
  return (str.length <= len) ? str : '${str.substring(0, len)}...';
}
