import 'package:boxoff/navigation/latest_screen.dart';
import 'package:boxoff/navigation/news_screen.dart';
import 'package:boxoff/navigation/releases_screen.dart';
import 'package:boxoff/navigation/search_screen.dart';
import 'package:flutter/material.dart';
import 'drawer_content.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List articles = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bottomInset = MediaQuery.of(context).viewInsets.bottom;
    var theme = Theme.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: SizedBox(width: 280, child: Drawer(child: DrawerContent())),
      body: <Widget>[
        NewsScreen(),
        LatestScreen(),
        ReleasesScreen(),
        SearchScreen(),
      ][_selectedIndex],
      bottomNavigationBar: Container(
        height: 60 + bottomInset,
        child: Column(
          children: <Widget>[
            BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              backgroundColor: theme.backgroundColor,
              selectedItemColor: theme.brightness == Brightness.light ? theme.primaryColor : Colors.red,
              unselectedItemColor: theme.accentColor,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.timeline), title: Text('News')),
                BottomNavigationBarItem(icon: Icon(Icons.movie), title: Text('Box Office')),
                BottomNavigationBarItem(icon: Icon(Icons.today), title: Text('Releases')),
                BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('Search')),
              ],
              currentIndex: _selectedIndex,
              onTap: (int index) => setState(() => _selectedIndex = index),
            ),
            Container(height: bottomInset, color: theme.backgroundColor),
          ],
        ),
      ),
    );
  }
}
