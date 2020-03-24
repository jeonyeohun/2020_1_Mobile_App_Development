// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    // Change Layout #1: Change the text as shown 'Result'
                    'JEON YEO HUN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  // Change Layout #1: Change the text as shown 'Result'
                  '21500630',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          FavoriteWidget(),
        ],
      ),
    );


    Color color = Colors.black; // Change Layout #2: Change the color of each button and text to black

    Widget buttonSection = Container(
      // Change Layout #3: buttonSection container needs padding (EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0))
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Change Layout #1: Remove appBar and make 5 buttons using buildButtonColumn
          _buildButtonColumn(color, Icons.call, 'CALL'),
          _buildButtonColumn(color, Icons.message, 'MESSAGE'),
          _buildButtonColumn(color, Icons.email, 'EMAIL'),
          _buildButtonColumn(color, Icons.share, 'SHARE'),
          _buildButtonColumn(color, Icons.description, 'ETC'),
        ],
      ),
    );

    Widget textSection = Container(
      // Change textSection #1: Edgeinsets.all(32) is applied all over textSection widget
      padding: const EdgeInsets.all(32.0),
      child: Row( // row를 만들어서 ICON 과 Column을 자녀로 가지게 한다.
        // Change textSection #5: Use CrossAxisAlignment.start each row and column
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Change textSection #2: Place the icon on the left and the text on the right
          // Change textSection #3: Set Icon with size 40.0
          Icon(Icons.message, size:40.0, color:Colors.black),
          Column( // Column은 두개의 container를 자녀로 가진다.
            // Change textSection #5: Use CrossAxisAlignment.start each row and column
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container( // 각 컨테이너는 padding 과 함께 문자 표현
                // // Change textSection #6: In right text part, apply padding as EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0)
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Text(
                  'Recent Message',
                  style: TextStyle(
                    // // Change textSection #4: "Recent Message" is FontWeight.bold
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Text(
                  'Long time no see!',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(

        body: ListView(
          children: [
            Image.asset(
              'images/lake.jpeg', // 이미지 추가
              width: 600,
              height: 240,
              fit: BoxFit.cover,
            ),
            titleSection,
            // Add Divider #1: Add Divider under the titleSection and buttonSection
            Divider(
              height: 1.0,
              color: Colors.black,
            ),
            buttonSection,
            Divider(
              height: 1.0,
              color: Colors.black,
            ),
            textSection,
          ],
        ),
      ),
    );
  }


  Column _buildButtonColumn(Color color, IconData icon, String label){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Icon(icon, color: color),
        Container(
          padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0), // margin을 padding으로 변경
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ]
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 12; // 값 변경

  @override
  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(

            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            // Change Interactivity Part #1: Change color of star icon
            color: Colors.yellow,
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
}