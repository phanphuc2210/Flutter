import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/firebase/cloud_firestore/login_page.dart';
import 'package:phuc_61cntt1/firebase/cloud_firestore/page_home_firebase_app.dart';

// adb kill-server
// adb start-server

class MyFirebaseApp extends StatefulWidget {
  const MyFirebaseApp({Key? key}) : super(key: key);

  @override
  State<MyFirebaseApp> createState() => _MyFirebaseAppState();
}

class _MyFirebaseAppState extends State<MyFirebaseApp> {
  bool ketnoi = false;
  bool loi = false;

  @override
  Widget build(BuildContext context) {
    if (loi) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: Text(
            "Có lỗi xảy ra",
            style: TextStyle(fontSize: 18),
            textDirection: TextDirection.ltr,
          ),
        ),
      );
    } else if (!ketnoi) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: Text(
            "Đang kết nối...",
            style: TextStyle(fontSize: 18),
            textDirection: TextDirection.ltr,
          ),
        ),
      );
    } else {
      return const MaterialApp(title: "My Firebase App", home: LoginPage());
    }
  }

  @override
  void initState() {
    super.initState();
    _khoiTaoFirebase();
  }

  _khoiTaoFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        ketnoi = true;
      });
    } catch (e) {
      loi = true;
    }
  }
}
