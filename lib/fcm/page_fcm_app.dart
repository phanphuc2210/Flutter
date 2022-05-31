import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/fcm/page_home_fcm.dart';
import 'package:phuc_61cntt1/widgets/widget_connect_firebase.dart';

class PageAppFCM extends StatelessWidget {
  const PageAppFCM({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        errorMessage: "Lỗi kết nối",
        connectingMessage: "Đang kết nối",
        builder: (context) => const MaterialApp(
              debugShowCheckedModeBanner: false,
              title: "FCM Demo",
              home: PageHomeFCM(),
            ));
  }
}
