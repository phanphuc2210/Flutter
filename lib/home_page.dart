import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/PhotoJson/PhotoPage.dart';
import 'package:phuc_61cntt1/VNExpress/RSS_page.dart';
import 'package:phuc_61cntt1/coban/gridList.dart';
import 'package:phuc_61cntt1/coban/grid_view.dart';
import 'package:phuc_61cntt1/coban/list_view.dart';
import 'package:phuc_61cntt1/coban/my_image.dart';
import 'package:phuc_61cntt1/coban/photo_album.dart';
import 'package:phuc_61cntt1/coban/textField.dart';
import 'package:phuc_61cntt1/firebase/cloud_firestore/login_page.dart';
import 'package:phuc_61cntt1/firebase/cloud_firestore/page_firebase_app.dart';
import 'package:phuc_61cntt1/firebase/cloud_firestore/register_page.dart';
import 'package:phuc_61cntt1/form/page_form_mathang.dart';
import 'package:phuc_61cntt1/provider_baitap/sanpham_app.dart';
import 'package:phuc_61cntt1/provider_vidu/my_app.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My App")),
      body: Center(
        child: Column(children: [
          // buttonBuilder(context, title: "ListView", destination: MyListView()),
          // buttonBuilder(context,
          //     title: "Photo Album", destination: MyPhotoAlbum()),
          // buttonBuilder(context, title: "Grid List", destination: MyGridList()),
          // buttonBuilder(context, title: "Image", destination: MyImage()),
          // buttonBuilder(context,
          //     title: "TextField", destination: MyTextField()),
          buttonBuilder(context, title: "Form", destination: PageFormMatHang()),
          buttonBuilder(context, title: "GridView", destination: MyGridView()),
          buttonBuilder(context,
              title: "Provider", destination: MyProviderApp()),
          buttonBuilder(context,
              title: "Provider_BaiTap", destination: SanPhamApp()),
          buttonBuilder(context,
              title: "PhotosPage", destination: PhotosPage()),
          buttonBuilder(context,
              title: "My Firebase App", destination: MyFirebaseApp()),
          buttonBuilder(context, title: "Login", destination: LoginPage()),
          buttonBuilder(context,
              title: "Register", destination: RegisterPage()),
        ]),
      ),
    );
  }

  Widget buttonBuilder(BuildContext context,
      {required String title, required Widget destination}) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => destination,
            )),
        child: Text(title),
      ),
    );
  }
}
