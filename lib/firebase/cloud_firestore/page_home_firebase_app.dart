import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:phuc_61cntt1/firebase/cloud_firestore/firebase_data.dart';
import 'package:phuc_61cntt1/firebase/cloud_firestore/login_page.dart';
import 'package:phuc_61cntt1/firebase/cloud_firestore/page_firebase_detail_sv.dart';
import 'package:phuc_61cntt1/helper/dialog.dart';

class PageSinhViens extends StatefulWidget {
  const PageSinhViens({Key? key}) : super(key: key);

  @override
  State<PageSinhViens> createState() => _PageSinhViensState();
}

class _PageSinhViensState extends State<PageSinhViens> {
  BuildContext? dialogContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Firebase App"),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageSVDetail(xem: false),
                  )),
              icon: const Icon(
                Icons.add_circle_outline,
                color: Colors.white,
              ))
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Center(
            child: Column(
              children: [
                const Text("My Firebase App"),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    showSnackBar(context, "Signing out.....", 300);
                    FirebaseAuth.instance.signOut().whenComplete(() {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                          (route) => false);
                      showSnackBar(context, "Please sign in", 5);
                    }).catchError((error) {
                      showSnackBar(context, "Sign out not successfully", 3);
                    });
                  },
                  icon: const Icon(Icons.logout_outlined),
                  label: const Text("Sign out"),
                )
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder<List<SinhVienSnapshot>>(
        stream: SinhVienSnapshot.getAllSinhVien(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(
              child: Text("L???i x???y ra khi truy v???n d??? li???u"),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("??ang t???i d??? li???u..."),
            );
          } else {
            return ListView.separated(
                itemBuilder: (context, index) {
                  dialogContext = context;
                  return Slidable(
                    child: ListTile(
                      leading: Text(
                        "${snapshot.data![index].sinhVien!.id}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      title: Text("${snapshot.data![index].sinhVien!.ten}"),
                      subtitle: Text("${snapshot.data![index].sinhVien!.lop}"),
                    ),
                    endActionPane: ActionPane(
                      motion: ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PageSVDetail(
                                    sinhVienSnapshot: snapshot.data![index],
                                    xem: true),
                              )),
                          icon: Icons.details,
                          foregroundColor: Colors.green,
                        ),
                        SlidableAction(
                          onPressed: (context) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PageSVDetail(
                                    sinhVienSnapshot: snapshot.data![index],
                                    xem: false),
                              )),
                          icon: Icons.edit,
                          foregroundColor: Colors.blue,
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            _xoa(dialogContext, snapshot.data![index]);
                          },
                          icon: Icons.delete_forever,
                          foregroundColor: Colors.red,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                      thickness: 2,
                    ),
                itemCount: snapshot.data!.length);
          }
        },
      ),
    );
  }

  void _xoa(BuildContext? dialogContext, SinhVienSnapshot svs) async {
    String? confirm = await showConfirmDialog(
        context, "B???n mu???n x??a sv ${svs.sinhVien!.ten}");
    if (confirm == "ok") {
      if (svs.sinhVien!.anh != null) {
        FirebaseStorage _storage = FirebaseStorage.instance;
        Reference reference =
            _storage.ref().child("images").child("anh_${svs.sinhVien!.id}.jpg");
        print(reference.name);
        reference.delete();
      }

      svs
          .delete()
          .whenComplete(
              () => showSnackBar(context, "X??a d??? li???u th??nh c??ng", 3))
          .onError((error, stackTrace) {
        showSnackBar(context, "X??a d??? li???u kh??ng th??nh c??ng", 3);
        return Future.error("X??a d??? li???u kh??ng th??nh c??ng");
      });
    }
  }
}
