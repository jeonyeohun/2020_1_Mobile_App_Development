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
import 'drawer.dart';

import 'model/products_repository.dart';
import 'model/product.dart';

class HomePage extends StatelessWidget {
  // TODO: Add a variable for Category (104)

  List<Card> _buildGridCards(BuildContext context) {
    List<Hotel> hotels = ProductsRepository.loadHotels();

    if (hotels == null || hotels.isEmpty) {
      return const <Card>[];
    }

    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return hotels.map((product) {
      return Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 18 / 11,
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.fitWidth,
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
                          Row(
                            // Row to set stars
                            children: <Widget>[
                              for (var i = 0; i < product.stars; i++)
                                IconTheme(
                                  data: IconThemeData(color: Colors.yellow),
                                  child: Icon(Icons.star, size: 10),
                                ),
                            ],
                          ),
                          Text(
                            // Hotel name
                            product.name,
                            //overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            softWrap: true,
                          ),
                          SizedBox(height: 5.0),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Icon(Icons.location_on, color: Colors.blue, size: 12),
                        SizedBox(
                          width: 8,
                        ),
                        Flexible(
                          child: Text(
                            product.location,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text('more'),
                    textColor: Colors.blue,
                    onPressed: () {
                      print('goto more page');
                    }
                      ),
                      ],
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
              Navigator.pushNamed(context, '/website');
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
}
