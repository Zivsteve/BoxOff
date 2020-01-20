import 'package:boxoff/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AboutHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Container(
        width: 300,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                'assets/logo-white-1024x1024.png',
                width: 50,
                height: 50,
              ),
            ),
            Text(
              APP_NAME,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                'Version $APP_VERSION',
                style: TextStyle(color: Colors.white60, fontSize: 13, fontWeight: FontWeight.normal),
              ),
            )
          ],
        ),
      ),
    );
  }
}
