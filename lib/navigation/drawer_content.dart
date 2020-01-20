import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:boxoff/themes.dart';
import 'package:boxoff/utils/navigation_utils.dart';
import 'package:boxoff/components/about_header.dart';
import 'package:boxoff/components/about_dialog_box.dart';

///
class DrawerContent extends ListView {
  @override
  ListView build(BuildContext context) {
    Color accentColor = Theme.of(context).accentColor;
    ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context);
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        AboutHeader(),
        DrawerTitle('Movies'),
        DrawerItem(Icons.event, 'Upcoming Releases', path: '/releases'),
        DrawerTitle('Statistics'),
        DrawerItem(Icons.movie_filter, 'Daily', path: '/stat/date'),
        DrawerItem(Icons.movie_filter, 'Weekend', path: '/stat/weekend'),
        DrawerItem(Icons.movie_filter, 'Weekly', path: '/stat/weekly'),
        DrawerItem(Icons.movie_filter, 'Monthly', path: '/stat/month'),
        DrawerItem(Icons.movie_filter, 'Yearly', path: '/stat/year'),
        DrawerTitle('App'),
        DrawerItem(Icons.info_outline, 'About', onTap: () => AboutDialogBox.show(context)),
        Container(
          padding: EdgeInsets.only(top: 100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.brightness_7, color: accentColor, size: 24),
                tooltip: 'Light Mode',
                onPressed: () => themeNotifier.setTheme('light'),
              ),
              IconButton(
                icon: Icon(Icons.brightness_2, color: accentColor, size: 24),
                tooltip: 'Dark Mode',
                onPressed: () => themeNotifier.setTheme('dark'),
              ),
              IconButton(
                icon: Icon(Icons.brightness_1, color: accentColor, size: 24),
                tooltip: 'AMOLED Mode',
                onPressed: () => themeNotifier.setTheme('amoled'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DrawerTitle extends Container {
  final String title;

  DrawerTitle(this.title);

  @override
  Widget build(BuildContext context) {
    Color accentColor = Theme.of(context).accentColor;
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: 10, top: 10),
      child: Text(
        title,
        style: TextStyle(color: accentColor, fontWeight: FontWeight.bold, fontSize: 13),
      ),
    );
  }
}

class DrawerItem extends ListTile {
  final IconData icon;
  final String text;
  final String path;
  final Function() onTap;

  DrawerItem(this.icon, this.text, {this.path, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: () {
        Navigator.of(context).pop();
        this.onTap == null ? router.navigateTo(context, path) : onTap();
      },
      dense: true,
    );
  }
}
