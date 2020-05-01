import 'dart:io';

import 'package:Shrine/record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'mod.dart';

class DetailPage extends StatefulWidget {
  final String docID;
  const DetailPage(this.docID);
  @override
  State<StatefulWidget> createState() {
    return _DetailPageState();
  }
}

class _DetailPageState extends State<DetailPage> {
  Record record;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Detail')),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.mode_edit),
            onPressed: () async {
              FirebaseUser user = await FirebaseAuth.instance.currentUser();
              if (record.uid == user.uid) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ModItemPage(widget.docID)));
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.restore_from_trash),
            onPressed: () async {
              FirebaseUser user = await FirebaseAuth.instance.currentUser();
              if (record.uid == user.uid) {
                record.reference.delete();
                StorageReference ref = await FirebaseStorage.instance.getReferenceFromUrl(record.imageURL);
                ref.delete();
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
      body: _buildBody(context, widget.docID),
    );
  }

  Widget _buildBody(BuildContext context, String docID) {
    return StreamBuilder(
      stream: Firestore.instance.collection('items').document(docID).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildDetail(context, snapshot.data);
      },
    );
  }

  Widget _buildDetail(BuildContext context, DocumentSnapshot data) {
    record = Record.fromSnapshot(data);
    if (record == null) print('null getted');
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Image.network(
              record.imageURL,
              fit: BoxFit.fill,
            ),
            Container(
              padding: EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        record.name,
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.thumb_up),
                              color: Colors.redAccent,
                              onPressed: () async {
                                FirebaseUser u = await FirebaseAuth.instance.currentUser();
                                final uid = u.uid;
                                final userID = uid.toString();
                                List<String> str = ['I LIKE IT', 'You can only do it once!!'];
                                int dupCheck = 1;
                                if (!record.voteList.contains(userID)) {
                                  dupCheck = 0;
                                  record.reference.updateData({
                                    'votes': FieldValue.increment(1),
                                    'voteList':
                                    FieldValue.arrayUnion([userID]),
                                  });
                                }
                                final snackBar = SnackBar(
                                  content: Text(str[dupCheck]),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                              },
                            ),
                            Text(
                              record.votes.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Text(
                    '\$ ' + record.price.toString(),
                    style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                  ),
                  Divider(),
                  Text(record.description),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text('creator : ' + record.uid,
                            style: TextStyle(color: Colors.grey, fontSize: 10)),
                        Text(
                          record.createdTime.toDate().toString() + ' created',
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                        Text(
                            record.modTime == null ? 'updating..' : record.modTime.toDate().toString() + ' modified',
                            style: TextStyle(color: Colors.grey, fontSize: 10)),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}


