import 'package:flutter/material.dart';
import 'package:login/prop-config.dart';
import 'package:login/analtyicsController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:login/userController.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login/src/messages/chat/view/view.dart';
import 'package:login/src/messages/chat/chatController.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login/userController.dart';
import 'package:login/analtyicsController.dart';
import 'dart:async';
import 'dart:io';
 
class Chat extends StatelessWidget {
  Chat({
    Key key, 
    @required this.peerId, 
    @required this.peerAvatar,
    this.peerName,
    this.analControl,
    this.user
  }) : super(key: key);

  final String peerId;
  final String peerAvatar;
  final String peerName;
  final userController user;
  final analyticsController analControl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(peerName),
        backgroundColor: Colors.lightGreen,
      ),
      body: ChatScreen(
        peerId: peerId,
        peerAvatar: peerAvatar,
        user: user,
        analControl: analControl
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  ChatScreen({
    Key key, 
    @required this.peerId, 
    @required this.peerAvatar,
    this.user,
    this.analControl,
  }) : super(key: key);

  final String peerId;
  final String peerAvatar;
  final userController user;
  final analyticsController analControl;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends StateMVC<ChatScreen> {
  _ChatScreenState()  : super(ChatController()) {
    chatController = ChatController.con;
  }
  ChatController chatController;

  @override
  void initState() {
    super.initState();
    chatController.set_id = widget.user.uid;
    chatController.set_peerId = widget.peerId;
    chatController.set_peerAvatar = widget.peerAvatar;

    chatController.set_groupChatId = '';

    chatController.set_isLoading = false;
    chatController.set_imageUrl = '';
    

    chatController.readLocal();
    print('\n\n GroupId: ${chatController.groupChatId}');
    
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              // List of messages
              buildListMessage(chatController),
              // Input content
              buildInput(chatController),
            ],
          ),
          // Loading
          buildLoading(chatController.isLoading)
        ],
      ),
      onWillPop: () => chatController.onBackPress(context),
    );
  }
}
