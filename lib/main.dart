import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/reviews.dart';
import 'package:flutter/material.dart';

import 'model/Record.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyDw6Ls3rt-3NFfGigW8N3poWMANKGb53Ug",
            appId: "1:693076958278:android:10e1f0a9c43a1e2618fe47",
            messagingSenderId: "693076958278",
            projectId: 'fir-flutter-976e6'));

    print('Firebase connected successfully!');
  } catch (e) {
    print('Firebase connection failed: $e');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('test').snapshots(),
      builder: (context, snapshot) {
        print(snapshot.data);
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data?.docs ?? []);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 22.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);
    return Padding(
      key: ValueKey(record.name),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: ListTile(
            title: Text(record.name),
            trailing: Text(record.vote.toString()),
            onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReviewState(record)))
                }),
      ),
    );
  }
}
