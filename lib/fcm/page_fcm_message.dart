import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/fcm/message.dart';

class PageFCM_Message extends StatefulWidget {
  RemoteMessage? message;
  PageFCM_Message({Key? key, required this.message}) : super(key: key);

  @override
  State<PageFCM_Message> createState() => _PageFCM_MessageState();
}

class _PageFCM_MessageState extends State<PageFCM_Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Message Infor")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Title: ${widget.message?.notification?.title ?? 'No title'}"),
          Text("From: ${widget.message?.from}"),
          Text("Body: ${widget.message?.notification?.body ?? 'No body'}"),
          Text("Sent time: ${widget.message?.sentTime}")
        ],
      ),
    );
  }
}
