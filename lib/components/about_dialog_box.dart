import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:boxoff/components/about_header.dart';
import 'package:boxoff/constants.dart';
import 'package:boxoff/utils/native_utils.dart';
import 'package:boxoff/utils/navigation_utils.dart';

class AboutDialogBox {
  static void show(BuildContext context) async {
    Color prevNavigationColor = navigationColor;
    bool prevNavigationLight = navigationLight;
    Dialog aboutDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 250,
        width: 300,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            children: <Widget>[
              AboutHeader(),
              Text(
                'Open-source box office app.',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              FlatButton(
                color: Color(0xffff0000),
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                onPressed: () => launchURL(REP_URL),
                child: Text(
                  'VIEW SOURCE CODE',
                  style: TextStyle(fontSize: 13),
                ),
              )
            ],
          ),
        ),
      ),
    );
    setNavigationBarColor(Colors.transparent, true);
    await showDialog(context: context, builder: (BuildContext context) => aboutDialog);
    setNavigationBarColor(prevNavigationColor, prevNavigationLight);
  }
}
