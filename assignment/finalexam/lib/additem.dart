import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddItemPage extends StatelessWidget {
  final TextEditingController titleText = TextEditingController();
  final TextEditingController priceText = TextEditingController();
  final TextEditingController desText = TextEditingController();
  final String uuid = Uuid().v1();

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
            Text('Add'),
            FlatButton(
              child: Text('Save'),
              onPressed: () {
                createItem();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          SetImage(),
          Container(
            padding: EdgeInsets.all(50),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Product Name'),
                  controller: titleText,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Price'),
                  controller: priceText,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Description'),
                  controller: desText,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void createItem() async {
    final FirebaseUser userID = await FirebaseAuth.instance.currentUser();
    String uid = userID.uid;
    String imgURL = await uploadImage();

    Firestore.instance.collection('items').add({
      'name': titleText.text,
      'description': desText.text,
      'price': int.parse(priceText.text),
      'votes': 0,
      'uid': uid,
      'createdTime': FieldValue.serverTimestamp(),
      'modTime' : FieldValue.serverTimestamp(),
      'imageURL' : imgURL,
      'imageID' : uuid,
      'voteList' : [],
    });
  }

  Future<String> uploadImage() async {
    File img = _SetImageState._image;
    if (img != null) {
      StorageReference ref =
      FirebaseStorage.instance.ref().child(uuid).child('image.jpg');
      StorageUploadTask uploadTask = ref.putFile(img);
      var url  = await (await uploadTask.onComplete).ref.getDownloadURL();
      return url.toString();
    }
    return _SetImageState.defaultImgURL;
  }

}

class SetImage extends StatefulWidget {
  _SetImageState createState() => _SetImageState();
}

class _SetImageState extends State<SetImage> {
  static int init = 0;
  static File _image;
  static String defaultImgURL = 'http://handong.edu/site/handong/res/img/logo.png';

  getGalleryImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void dispose(){
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
                defaultImgURL,
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


