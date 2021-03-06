import 'package:badges/badges.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/fcm/message_helper.dart';
import 'package:phuc_61cntt1/fcm/page_fcm_message.dart';
import 'package:phuc_61cntt1/fcm/page_list_message.dart';

String authorization_key =
    "AAAAHljslQs:APA91bGjzp-A7HunaK5RfdsKkaD9-5zIt7_MEUTRXYF-knU3R9r83_yh_oyTcsKc-6yA0H5OABNFF302mZUFQwQyMxCia4XdXuAa-5jXngdZzI5h1pUKq_cYOlltvo41DuhARsp5hXqB";
String topic = "my_fcm_test";

class PageHomeFCM extends StatefulWidget {
  const PageHomeFCM({Key? key}) : super(key: key);

  @override
  State<PageHomeFCM> createState() => _PageHomeFCMState();
}

class _PageHomeFCMState extends State<PageHomeFCM> {
  int count = 10;
  int index = 0;
  String? token;
  String? topicStatus = 'fcm_test';
  String incoming_message = "No message";
  TextEditingController textContent = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FCM Demo")),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) {
          if (value == 1 && count > 0) {
            setState(() {
              count = 0;
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageListMessage(),
                ));
          }
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.blue[800],
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Badge(
                badgeColor: Colors.red,
                showBadge: count > 0,
                position: BadgePosition.topEnd(top: -12, end: -18),
                badgeContent: Text(
                  "$count",
                  style: TextStyle(color: Colors.white),
                ),
                child: Icon(
                  Icons.message,
                  color: Colors.green,
                ),
              ),
              label: 'Message'),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("FCM token: $token"),
            const SizedBox(
              height: 10,
            ),
            Text("Topic: $topicStatus"),
            const SizedBox(
              height: 10,
            ),
            Text("Message: $incoming_message"),
            Center(
              child: ElevatedButton(
                child: const Text("Subcribe to topic"),
                onPressed: () {
                  FirebaseMessaging.instance
                      .subscribeToTopic(topic)
                      .whenComplete(() {
                    setState(() {
                      topicStatus = topic;
                    });
                  });
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                child: const Text("Unsubcribe to topic"),
                onPressed: () {
                  FirebaseMessaging.instance
                      .unsubscribeFromTopic(topic)
                      .whenComplete(() {
                    setState(() {
                      topicStatus = "None";
                    });
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: textContent,
              decoration: const InputDecoration(labelText: "N???i dung tin nh???n"),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                child: const Text("Send message to topic"),
                onPressed: () {
                  String messageToSend = MessageHelper.constructFCMPayLoad(
                      content: textContent.text, to: topic, topic: true);
                  MessageHelper.sendPushMessageByHTTP_Post(
                      authorization_key: authorization_key,
                      token: token,
                      message: messageToSend);
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                child: const Text("Send message to myself"),
                onPressed: () {
                  String message = MessageHelper.constructFCMPayLoad(
                      content: textContent.text, to: token!, topic: false);
                  MessageHelper.sendPushMessageByHTTP_Post(
                      message: message,
                      token: token,
                      authorization_key: authorization_key);
                },
              ),
            )
          ],
        ),
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    // L???y token ???? d??ng k?? khi ch???y ???ng d???ng l???n ?????u
    // Th??ng th?????ng token n??y s??? ???????c l??u tr??n server ????? c?? th??? dduc d??ng ????? g???i ti nh???n
    // L???y m?? th??ng b??o FCM m???c ?????nh cho thi???t b??? n??y.
    FirebaseMessaging.instance.getToken().then((value) {
      print("Token message: $value");
      setState(() {
        token = value;
      });
    });

    // ????ng k?? v???i topic
    FirebaseMessaging.instance.subscribeToTopic(topic).whenComplete(() {
      setState(() {
        topicStatus = topic;
      });
    });

    //l???y s??? l?????ng tin nh???n v?? c???p nh???t l??n badge widget
    MessageHelper.getCountMessage().then((value) {
      setState(() {
        count = value;
      });
    });

    //S??? ki???n s??? l?? khi ng?????i d??ng b???m v??o n??t tin nh???n tr??n thanh tr???ng th??i
    // khi ???ng d???ng chay duoi background
    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      MessageHelper.fcmOpenMessageHandler(
          context: context,
          message: remoteMessage,
          messageHandler: (context, message) {
            // ??i???u h?????ng ?????n trang hi???n th??? tin nh???n
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageFCM_Message(message: message),
                ));
          });
    });

    //S??? ki???n s??? l?? khi ng?????i d??ng b???m v??o n??t tin nh???n tr??n thanh tr???ng th??i
    // khi ???ng d???ng ??ang ??? tr???ng th??i terminate
    FirebaseMessaging.instance.getInitialMessage().then((remoteMessage) {
      if (remoteMessage != null) {
        MessageHelper.fcmOpenMessageHandler(
            context: context,
            message: remoteMessage,
            messageHandler: (context, message) {
              // ??i???u h?????ng ?????n trang hi???n th??? tin nh???n
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageFCM_Message(message: message),
                  ));
            });
      }
    });

    // S??? ki???n x??? l?? nh???n tin nh???n ??? mode Foreground
    FirebaseMessaging.onMessage.listen((remoteMessage) {
      MessageHelper.fcm_ForegroundHandler(
          message: remoteMessage,
          context: context,
          messageHandler: (context, message) {
            setState(() {
              incoming_message =
                  message.notification?.body ?? "Kh??ng c?? n???i dung";
            });
            // X??? l?? th??m vi???c nh???n tin nh???n ??? ????y
            // C???p nh???t hi???n th??? cho s??? l?????ng tin nh???n cho badge
            MessageHelper.getCountMessage().then((value) {
              setState(() {
                count = value;
              });
            });
          });
    });
  }
}
