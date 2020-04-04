import 'package:flutter/material.dart';

class BuildDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text('Pages'),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
        ListTile(
          leading: Icon(Icons.search),
          title: Text('Search'),
          onTap: () {
            Navigator.pushNamed(context, '/search');
          },
        ),
        ListTile(
          leading: Icon(Icons.location_city),
          title: Text('Favorite Hotel'),
          onTap: () {
            Navigator.pushNamed(context, '/favorites');
          },
        ),
        ListTile(
          leading: Icon(Icons.language),
          title: Text('Website'),
          onTap: () {
            Navigator.pushNamed(context, '/website');
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('My Page'),
          onTap: () {
            Navigator.pushNamed(context, '/mypage');
          },
        ),
      ],
    ));
  }
}
