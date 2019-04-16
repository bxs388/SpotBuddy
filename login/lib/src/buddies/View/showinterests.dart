import 'package:flutter/material.dart';
import 'package:login/prop-config.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login/userController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowInterestsPage extends StatelessWidget {
  ShowInterestsPage({Key key, this.document})
      : super(key: key);

  final DocumentSnapshot document;
  List<ListView> items = document.data['interests'];
  @override
  Widget build(BuildContext context) {
    var linearGradient = const BoxDecoration(
      gradient: const LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[
          const Color(0xFF413070),
          const Color(0xFF2B264A),
        ],
      ),
    );
    
    return Scaffold(
      appBar: AppBar(
        title: Text(Userinfo.interests),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container (
          decoration: linearGradient,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, position) {
              return ListTile(
                title: Text('${document[interests]}'),
              );
            },
          )
          // child: Column(
          //   // mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.stretch,
          //   children: <Widget>[
              
          // ]
          //),
      ),
    );
  }
}