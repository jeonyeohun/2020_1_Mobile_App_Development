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

import 'detail.dart';
import 'package:Shrine/record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  Card _buildGridCards(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    final ThemeData theme = Theme.of(context);
    final NumberFormat formatter = NumberFormat.simpleCurrency(
        locale: Localizations.localeOf(context).toString());

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 18 / 11,
            child: Image.network(
              record.imageURL,
              fit: BoxFit.fitWidth,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 12.0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    record.name,
                    style: theme.textTheme.body2,
                    maxLines: 1,
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    formatter.format(record.price),
                    style: TextStyle(fontSize: 10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                          height: 30,
                          width: 60,
                          child: FlatButton(
                            child: Text(
                              'more',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.blueAccent),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(record.reference.documentID)));
                            },
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<DocumentSnapshot> snapshot) {
    if (snapshot.isEmpty)
      return Scaffold(
          body: Container(
        alignment: Alignment.center,
        child: Text('No Item!'),
      ));
    int getPrice(DocumentSnapshot data) {
      return data.data['price'];
    }

    if (!DropdownMenu._isAsc)
      snapshot.sort((a, b) => getPrice(a).compareTo(getPrice(b)));

    return Column(
      children: <Widget>[
        DropdownMenu(),
        Expanded(
          child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(16.0),
              childAspectRatio: 8.0 / 9.0,
              children: snapshot
                  .map((data) => _buildGridCards(context, data))
                  .toList()),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.person,
            semanticLabel: 'menu',
          ),
          onPressed: () {
            print('Menu button');
          },
        ),
        title: Text('Main'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/add');
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('items').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return LinearProgressIndicator();
            return _buildGrid(context, snapshot.data.documents);
          }),
      resizeToAvoidBottomInset: false,
    );
  }
}

class DropdownMenu extends StatefulWidget {
  static bool _isAsc = true;
  _DropdownMenuState createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  String value = 'ascending';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton<String>(
        value: value,
        items: <String>['ascending', 'descending'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            if (value == 'acsending') {
              DropdownMenu._isAsc = true;
              this.value = value;
            } else {
              DropdownMenu._isAsc = false;
              this.value = value;
            }
          });
        },
      ),
    );
  }
}
