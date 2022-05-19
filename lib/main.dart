import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/SQlite/page_sqlite_app.dart';
import 'package:phuc_61cntt1/VNExpress/Detail_page.dart';
import 'package:phuc_61cntt1/VNExpress/RSS_page.dart';
import 'package:phuc_61cntt1/coban/webview.dart';
import 'package:phuc_61cntt1/cpu_z/cpuz_app.dart';
import 'package:phuc_61cntt1/cpu_z_version2/cpu_z_app.dart';
// import 'package:phuc_61cntt1/coban/quanPussy.dart';
// import 'package:phuc_61cntt1/form/page_form_mathang.dart';
// import 'package:phuc_61cntt1/coban/grid_view.dart';
import 'package:phuc_61cntt1/home_page.dart';
// import 'package:phuc_61cntt1/coban/list_view.dart';
// import 'package:phuc_61cntt1/coban/photo_album.dart';
// import 'package:phuc_61cntt1/coban/counter.dart';
// import 'package:phuc_61cntt1/coban/my_image.dart';
// import 'package:phuc_61cntt1/coban/gridList.dart';
// import 'package:phuc_61cntt1/coban/textField.dart';
// import 'package:phuc_61cntt1/coban/statefull_example.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      // home: SQLiteApp(),
      // home: CpuApp(),
      // home: MyCpuApp(),
      // home: WebViewExample(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hello World 61CNTT1"),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            height: 200,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                border: Border.all(color: Colors.brown),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Text("61 CNTT1"),
          ),
        ));
  }
}
