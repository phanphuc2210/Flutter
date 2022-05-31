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
              decoration: const InputDecoration(labelText: "Nội dung tin nhắn"),
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
    // Lấy token đã dăng ký khi chạy ứng dụng lần đầu
    // Thông thường token này sẽ được lưu trên server để có thể dduc dùng để gửi ti nhắn
    // Lấy mã thông báo FCM mặc định cho thiết bị này.
    FirebaseMessaging.instance.getToken().then((value) {
      print("Token message: $value");
      setState(() {
        token = value;
      });
    });

    // Đăng ký với topic
    FirebaseMessaging.instance.subscribeToTopic(topic).whenComplete(() {
      setState(() {
        topicStatus = topic;
      });
    });

    //lấy số lượng tin nhắn và cập nhật lên badge widget
    MessageHelper.getCountMessage().then((value) {
      setState(() {
        count = value;
      });
    });

    //Sự kiện sử lý khi người dùng bấm vào nút tin nhắn trên thanh trạng thái
    // khi ứng dụng chay duoi background
    FirebaseMessaging.onMessageOpenedApp.listen((remoteMessage) {
      MessageHelper.fcmOpenMessageHandler(
          context: context,
          message: remoteMessage,
          messageHandler: (context, message) {
            // điều hướng đến trang hiển thị tin nhắn
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageFCM_Message(message: message),
                ));
          });
    });

    //Sự kiện sử lý khi người dùng bấm vào nút tin nhắn trên thanh trạng thái
    // khi ứng dụng đang ở trạng thái terminate
    FirebaseMessaging.instance.getInitialMessage().then((remoteMessage) {
      if (remoteMessage != null) {
        MessageHelper.fcmOpenMessageHandler(
            context: context,
            message: remoteMessage,
            messageHandler: (context, message) {
              // điều hướng đến trang hiển thị tin nhắn
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageFCM_Message(message: message),
                  ));
            });
      }
    });

    // Sự kiện xử lý nhận tin nhắn ở mode Foreground
    FirebaseMessaging.onMessage.listen((remoteMessage) {
      MessageHelper.fcm_ForegroundHandler(
          message: remoteMessage,
          context: context,
          messageHandler: (context, message) {
            setState(() {
              incoming_message =
                  message.notification?.body ?? "Không có nội dung";
            });
            // Xử lý thêm việc nhận tin nhắn ở đây
            // Cập nhật hiển thị cho số lượng tin nhắn cho badge
            MessageHelper.getCountMessage().then((value) {
              setState(() {
                count = value;
              });
            });
          });
    });
  }
}
