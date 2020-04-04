import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Set<String> _saved = Set<String>();

// ignore: must_be_immutable
class FavoriteWidget extends StatefulWidget {
  String name;
  FavoriteWidget(String name) {
    this.name = name;
  }
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState(name);
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
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
        _saved.remove(hotelName);
      } else {
        _isFavorited = true;
        _saved.add(hotelName);
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
