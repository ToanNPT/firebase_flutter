import 'package:cloud_firestore/cloud_firestore.dart';

class Voter {
  final num id;
  final String content;
  final String voter;
  final DocumentReference reference;
  Voter.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
    snapshot.data() as Map<dynamic, dynamic>,
    reference: snapshot.reference,
  );
  Voter.fromMap(
      Map<dynamic, dynamic> map, {
        required this.reference,
      }) :
        assert(map['id'] != null),
        assert(map['content'] != null),
        assert(map['voter'] != null),
        id = map['id'],
        content = map['content'],
        voter = map['voter'];
  @override
  String toString() => "Record<$voter:$voter>";
}