import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  final num id;
  final String name;
  final num vote;
  final DocumentReference reference;
  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
    snapshot.data() as Map<dynamic, dynamic>,
    reference: snapshot.reference,
  );
  Record.fromMap(
      Map<dynamic, dynamic> map, {
        required this.reference,
      }) :
        assert(map['name'] != null),
        assert(map['vote'] != null),
        assert(map["id"] != null),
        name = map['name'],
        vote = map['vote'],
        id = map['id'];
  @override
  String toString() => "Record<$name:$vote>";
}