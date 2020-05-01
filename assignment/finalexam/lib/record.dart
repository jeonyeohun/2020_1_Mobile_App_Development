
import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final String name;
  final int votes;
  final Timestamp modTime;
  final Timestamp createdTime;
  final String imageURL;
  final String imageID;
  final int price;
  final String uid;
  final List<dynamic> voteList;
  final String description;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        name = map['name'],
        votes = map['votes'],
        modTime = map['modTime'],
        createdTime = map['createdTime'],
        imageURL = map['imageURL'],
        imageID = map['imageID'],
        price = map['price'],
        uid = map['uid'],
        voteList = map['voteList'],
        description = map['description'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
