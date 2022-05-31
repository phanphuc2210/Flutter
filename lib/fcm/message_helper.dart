import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:http/http.dart';
import 'package:phuc_61cntt1/fcm/message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MessageHelper {
  static String key_message_list = "fcm_message";
  static String key_count_message = "count_message";

  static Future<int> getCountMessage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return (sharedPreferences.getInt(key_count_message) ?? 0);
  }

  static Future<bool> writeMessage(
      MyNotificationMessage notificationMessage) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? strMessage =
        sharedPreferences.getStringList(key_message_list);
    int count = (sharedPreferences.getInt(key_count_message) ?? 0) + 1;
    FlutterAppBadger.updateBadgeCount(count);
    await sharedPreferences.setInt(key_count_message, count);
    if (strMessage != null) {
      strMessage.add(jsonEncode(notificationMessage));
      return sharedPreferences.setStringList(key_message_list, strMessage);
    } else {
      return sharedPreferences
          .setStringList(key_message_list, [jsonEncode(notificationMessage)]);
    }
  }

  static Future<List<MyNotificationMessage>?> readMessage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String>? strMessage =
        sharedPreferences.getStringList(key_message_list);
    FlutterAppBadger.removeBadge();
    sharedPreferences.remove(key_message_list);
    sharedPreferences.remove(key_count_message);
    return strMessage
        ?.map((strUserMessage) =>
            MyNotificationMessage.fromJson(jsonDecode(strUserMessage)))
        .toList();
  }

  static Future<void> fcm_BackgroundHandler(RemoteMessage message) async {
    //mac dinh ti nhan duoc hien thi o thanh trang thai cau thiet bi neu nhan o background
    //viet them code xu ly o day

    print("Handing a background message ${message.messageId}");
  }

  //nhận tin nhắn ở chế độ Foreground, lưu tin nhắn, cập nhật FlutterAppBadger
  static void fcm_ForegroundHandler(
      {required RemoteMessage message,
      required BuildContext context,
      void Function(BuildContext context, RemoteMessage message)?
          messageHandler}) {
    writeMessage(MyNotificationMessage(
            title: message.notification?.title,
            body: message.notification?.body,
            from: message.from,
            time: message.sentTime.toString()))
        .whenComplete(() {
      if (messageHandler != null) {
        messageHandler(context, message);
      }
    });

    print("Message write in foreground");
  }

  static void fcmOpenMessageHandler(
      {required BuildContext context,
      required RemoteMessage message,
      void Function(BuildContext context, RemoteMessage message)?
          messageHandler}) {
    print("Open fcm message");
    if (messageHandler != null) {
      messageHandler(context, message);
    }
  }

  static fcm_OpenAllMessageHandler(
      {required BuildContext context,
      void Function(BuildContext context, List<MyNotificationMessage>)?
          messageHandler}) async {
    List<MyNotificationMessage>? list = await readMessage();
    if (messageHandler != null) {
      messageHandler(context, list!);
    }
  }

  static String constructFCMPayLoad(
      {required content, required String to, required bool topic}) {
    String address = to;
    if (topic) {
      address = "/topics/$to";
    }
    return jsonEncode({
      'to': address,
      'priority': 'high',
      'data': <String, dynamic>{
        'via': 'FlutterFire Cloud Messaging!!!',
      },
      'notification': <String, dynamic>{
        'title': 'Hello FlutterFire!!!',
        'body': content,
        'sound': true
      }
    });
  }

  static Future<Response> sendPushMessageByHTTP_Post(
      {String? message, String? token, String? authorization_key}) async {
    if (token == null) {
      print("Unable to send FCM message, no token exists.");
      return Future.error("Chua co token");
    }
    try {
      Response response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          "Authorization": 'key=${authorization_key!}',
        },
        body: message,
      );
      print("FCM request for device sent!");
      return response;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
