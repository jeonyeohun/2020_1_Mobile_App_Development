import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FavoritePage extends StatefulWidget {
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  Set<String> _saved = _FavoriteWidgetState._saved;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Favorite Hotels'),
        ),
        body: ListView.builder(
          itemCount: _saved.length,
          itemBuilder: (context, index) {
            final item = _saved.elementAt(index);

            return Dismissible(
              key: Key(item),
              onDismissed: (direction) {
                setState(() {
                  _saved.remove(item);
                  print(_saved);
                });
              },
              background: Container(
                color: Colors.redAccent,
              ),
              child: ListTile(title: Text('$item')),
            );
          },
        ));
  }
}

class FavoriteWidget extends StatefulWidget {
  String name;
  FavoriteWidget(String name) {
    this.name = name;
  }
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState(name);

}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  static Set<String> _saved = Set<String>();
  bool _isFavorited = false;
  String hotelName;

  _FavoriteWidgetState(String name) {
    if (_saved.contains(name)) {
      _isFavorited = true;
    }
    hotelName = name;
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
        setState(() {
          _saved.remove(hotelName);
        });

      } else {
        _isFavorited = true;
        setState(() {
          _saved.add(hotelName);
        });
      }
    });
    print(_saved);
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_isFavorited
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border)),
            color: Colors.redAccent,
            onPressed: _toggleFavorite,
          ),
        ),
      ],
    );
  }
}

class FavoriteInfo {
  Set<String> get(){
    return _FavoriteWidgetState._saved;
  }
}
