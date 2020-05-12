import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final defaultImageURL = 'http://handong.edu/site/handong/res/img/logo.png';



class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app),
              color: Colors.white,
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.popAndPushNamed(context, '/login');
              },
            ),
          ],
        ),
        body: _buildUserInfo(context, user));
  }

  Widget _buildUserInfo(BuildContext context, FirebaseUser user) {
    return Container(
      padding: EdgeInsets.all(50),
      child: Column(
        children: <Widget>[
          Center(
            child: Image.network(
                user.isAnonymous ? defaultImageURL : user.photoUrl),
          ),
          Container(
              margin: EdgeInsets.only(top: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user.uid,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Text(
                    user.isAnonymous ? 'Anonymous' : user.email,
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
