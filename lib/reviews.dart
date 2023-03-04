import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/model/Voter.dart';
import 'package:flutter/material.dart';

import 'model/Record.dart';

Stream<QuerySnapshot> fetchReviews(movieId) {
  final CollectionReference moviesCollection =
      FirebaseFirestore.instance.collection('votes');
  Stream<QuerySnapshot> snapshot =
      moviesCollection.where('id', isEqualTo: movieId).snapshots();
  return snapshot;
}

class ReviewState extends StatefulWidget {
  //final num movieId;
  final Record record;

  const ReviewState(this.record);

  @override
  State<ReviewState> createState() => _ReviewState();
}

class _ReviewState extends State<ReviewState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            alignment: Alignment.center,
            child: Text("Feedbacks about movie: ${widget.record.name}",style: new TextStyle(fontWeight: FontWeight.bold),),
          ),
          Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: fetchReviews(widget.record.id),
              builder: (context, snapshot) {
                print(snapshot.data);
                if (!snapshot.hasData) return LinearProgressIndicator();
                return _buildList(context, snapshot.data?.docs ?? []);
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.8,
      child: ListView(
        padding: const EdgeInsets.only(top: 22.0),
        children: snapshot.map((data) => _buildListItem(context, data)).toList(),
      )
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final vote = Voter.fromSnapshot(data);
    print(vote);
    return Padding(
      key: ValueKey(vote.voter),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: ListTile(
            title: Text(vote.content),
            trailing: Text(vote.voter as String),
            onTap: () => {}),
      ),
    );
  }
}
