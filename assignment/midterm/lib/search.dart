import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // stores ExpansionPanel state information

  Map<String, bool> checkBoxState = {
    'No Kids Zone': false,
    'Pet-Friendly': false,
    'Feee Breakfast': false,
    'Free Wifi': false,
    'Electric Car Charging': false
  };

  bool isExpanded = false;

  String checkInDate = '';
  String checkOutDate = '';

  var formatter = new DateFormat('yyyy.MM.dd (E)');

  String checkedInfoStr() {
    String str = '';
    for (var entry in checkBoxState.entries) {
      if (entry.value) str = str + entry.key + ' / ';
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildPanel(),
                // Date Part //
                Container(
                  padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildDateSection(),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                    color: Colors.blue,
                    child: Text(
                      'Search',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Please check your choice :)"),
                            content: SingleChildScrollView(
                              padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
                              child: ListBody(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.wifi,
                                        color: Colors.blueAccent,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Text(
                                          checkedInfoStr(),
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.calendar_view_day,
                                        color: Colors.blueAccent,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'IN',
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'OUT',
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),


                                            ],
                                          ),
                                          SizedBox(width: 10,),
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                checkInDate,
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              ),
                                              Text(
                                                checkOutDate,
                                                style: TextStyle(
                                                    fontSize: 9,
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              Container(
                                child: ButtonBar(
                                  mainAxisSize: MainAxisSize.max,
                                  alignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    RaisedButton(
                                      color: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        'Search',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDateSection() {
    return <Widget>[
      Text(
        'Date',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.calendar_today),
                        Text(
                          'check-in',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      checkInDate,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                RaisedButton(
                  child: Text('Select Date'),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2019),
                            lastDate: DateTime(2022))
                        .then((date) {
                      setState(() {
                        checkInDate = formatter.format(date).toString();
                      });
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.calendar_today),
                        Text(
                          'check-out',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      checkOutDate,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                RaisedButton(
                  child: Text('Select Date'),
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2019),
                            lastDate: DateTime(2022))
                        .then((date) {
                      setState(() {
                        checkOutDate = formatter.format(date).toString();
                      });
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          this.isExpanded = !isExpanded;
        });
      },
      children: <ExpansionPanel>[
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              padding: EdgeInsets.only(left: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Filter',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Select Filters'),
                  SizedBox(
                    width: 0,
                  )
                ],
              ),
            );
          },
          body: Container(
            padding: EdgeInsets.only(left: 120),
            child: Column(
              children: _buildCheckBox(),
            ),
          ),
          isExpanded: isExpanded,
        ),
      ],
    );
  }

  List<Widget> _buildCheckBox() {
    return <Widget>[
      for (var entry in checkBoxState.entries)
        Row(
          children: <Widget>[
            Checkbox(
              value: entry.value,
              onChanged: (bool value) {
                setState(() {
                  checkBoxState.update(entry.key, (bool value) => !value);
                  print(checkBoxState.values);
                });
              },
            ),
            Text(entry.key),
          ],
        ),
    ];
  }
}
