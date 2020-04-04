// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:ui';

import 'package:Shrine/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'details.dart';
import 'drawer.dart';

import 'model/products_repository.dart';
import 'model/product.dart';

class HomePage extends StatelessWidget {
  Set<String> _saved = Set<String>();

  List<Card> _buildGridCards(BuildContext context) {
    List<Hotel> hotels = ProductsRepository.loadHotels();

    if (hotels == null || hotels.isEmpty) {
      return const <Card>[];
    }

    return hotels.asMap().entries.map((entry) {
      Hotel hotel = entry.value;
      int idx = entry.key;
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Hero(
                tag: hotel.assetName,
                child: Image.asset(
                  hotel.assetName,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            child: Row(
                                // Row to set stars
                                children: drawStars(hotel.stars)),
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            child: Text(
                              // Hotel name
                              hotel.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              softWrap: true,
                            ),
                          ),
                          SizedBox(height: 2.0),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.location_on, color: Colors.blue, size: 15),
                          SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            child: Text(
                              hotel.location,
                              softWrap: true,

                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.only(bottom: 5),
              child: SizedBox(
                height: 15,
                width: 60,
                child: FlatButton(
                    child: Text(
                      'more',
                      style: TextStyle(fontSize: 10),
                    ),
                    textColor: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(),
                          settings: RouteSettings(
                            arguments: idx,
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BuildDrawer(),
      appBar: AppBar(
        title: Text('Main'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.language,
              semanticLabel: 'Website',
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/webview');
            },
          ),
        ],
      ),
      body: Center(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              padding: EdgeInsets.all(16.0),
              childAspectRatio: 8.0 / 9.0,
              children: _buildGridCards(context),
            );
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
    );

  }

  List<Widget> drawStars(int n) {
    return <Widget>[
      for (var i = 0; i < n; i++)
        IconTheme(
          data: IconThemeData(color: Colors.yellow),
          child: Icon(Icons.star, size: 12),
        ),
    ];
  }
}
