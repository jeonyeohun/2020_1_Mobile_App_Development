import 'package:flutter/material.dart';

import 'favorites.dart';

class BuildDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        DrawerHeader(
          padding: EdgeInsets.only(top: 90, left: 16),
          child: Text('Pages', style: TextStyle(fontSize: 25, color: Colors.white),),
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
            Navigator.pushNamed(context, '/webview');
          },
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text('My Page'),
          onTap: () {
            print(FavoriteInfo().get());
            if(FavoriteInfo().get().isNotEmpty)
              Navigator.pushNamed(context, '/mypage');
            else
              Navigator.pushNamed(context, '/emptyFavorite');
          },
        ),
      ],
    ));
  }
}
