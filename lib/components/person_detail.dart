import 'package:boxoff/components/profile_image.dart';
import 'package:boxoff/utils/navigation_utils.dart';
import 'package:flutter/material.dart';

class PersonDetail extends StatelessWidget {
  final int id;
  final String image;
  final String name;
  final String role;

  PersonDetail({
    @required this.id,
    @required this.image,
    @required this.name,
    this.role = '',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: Card(
        child: InkWell(
          onTap: () {
            router.navigateTo(context, '/person/$id');
          },
          child: Column(
            children: [
              ProfileImage(image, width: 100, height: 150),
              Container(
                padding: EdgeInsets.all(5),
                child: Column(children: <Widget>[
                  Text(
                    name,
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      role,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
