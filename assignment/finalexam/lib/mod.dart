import 'package:Shrine/record.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ModItemPage extends StatefulWidget {
  final String docID;
  const ModItemPage(this.docID);
  @override
  State<StatefulWidget> createState() {
    return _ModItemPageState();
  }
}

class _ModItemPageState extends State<ModItemPage> {
  Record record;
  TextEditingController titleText;
  TextEditingController priceText;
  TextEditingController desText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton(
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 15),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text('Edit'),
            FlatButton(
              child: Text('Save'),
              onPressed: () async {
                await updateItem();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _buildBody(context, widget.docID),
    );
  }

  Widget _buildBody(BuildContext context, String docID) {
    return StreamBuilder(
      stream:
          Firestore.instance.collection('items').document(docID).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildDetail(context, snapshot.data);
      },
    );
  }

  Widget _buildDetail(BuildContext context, DocumentSnapshot data) {
    record = Record.fromSnapshot(data);
    titleText = TextEditingController(text: record.name);
    priceText = TextEditingController(text: record.price.toString());
    desText = TextEditingController(text: record.description);

    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            SetImage(record),
            Container(
              padding: EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: titleText,
                  ),
                  TextField(
                    controller: priceText,
                  ),
                  Divider(),
                  TextField(
                    controller: desText,
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  Future<void> updateItem() async {
    String imgURL = await uploadImage();

    FieldValue modTime = FieldValue.serverTimestamp();
    record.reference.updateData({
      'name' : titleText.text,
      'price' : int.parse(priceText.text),
      'description' : desText.text,
      'modTime' : modTime,
      if (imgURL != null) 'imageURL' : imgURL,
    });
  }

  Future<String> uploadImage() async {
    if (_SetImageState._image == null){
      return null;
    }
    File img = _SetImageState._image;
    StorageReference ref =
        FirebaseStorage.instance.ref().child(record.imageID).child('image.jpg');
    StorageUploadTask uploadTask = ref.putFile(img);
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();
    return url.toString();
  }
}

class SetImage extends StatefulWidget {
  final Record record;
  SetImage(this.record);
  _SetImageState createState() => _SetImageState();
}

class _SetImageState extends State<SetImage> {
  static File _image;

  getGalleryImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void dispose() {
    _image = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 250,
          child: _image == null
              ? Image.network(
                  widget.record.imageURL,
                  fit: BoxFit.scaleDown,
                )
              : Image.file(_image),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.camera_alt),
              onPressed: () {
                getGalleryImage();
              },
            )
          ],
        ),
      ],
    );
  }
}
