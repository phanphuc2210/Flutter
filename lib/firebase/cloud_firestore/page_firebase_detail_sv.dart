import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phuc_61cntt1/firebase/cloud_firestore/firebase_data.dart';
import 'package:phuc_61cntt1/helper/dialog.dart';

class PageSVDetail extends StatefulWidget {
  SinhVienSnapshot? sinhVienSnapshot;
  bool? xem;
  PageSVDetail({Key? key, this.sinhVienSnapshot, required this.xem})
      : super(key: key);

  @override
  State<PageSVDetail> createState() => _PageSVDetailState();
}

class _PageSVDetailState extends State<PageSVDetail> {
  bool _imageChange = false; // neu chon anh thi gia tri true
  XFile?
      _xImage; // khi chọn xong ảnh thì thông tin của ảnh sẽ lưu trong biến này

  SinhVienSnapshot? svs;
  bool? xem;
  String buttonLabel = "Thêm";
  String title = "Thêm SV mới";
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtLop = TextEditingController();
  TextEditingController txtQueQuan = TextEditingController();
  TextEditingController txtNamSinh = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 200,
              child: _imageChange
                  ? Image.file(File(_xImage!.path))
                  : svs?.sinhVien!.anh != null
                      ? Image.network(svs!.sinhVien!.anh!)
                      : null,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: xem != true ? () => _chonAnh(context) : null,
                    child: const Icon(Icons.image))
              ],
            ),
            TextField(
              controller: txtId,
              decoration: const InputDecoration(label: Text("Id:")),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: txtTen,
              decoration: const InputDecoration(label: Text("Tên:")),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: txtLop,
              decoration: const InputDecoration(label: Text("Lớp:")),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: txtNamSinh,
              decoration: const InputDecoration(label: Text("Năm sinh:")),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: txtQueQuan,
              decoration: const InputDecoration(label: Text("Quê quán:")),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      if (xem == true) {
                        Navigator.of(context).pop();
                      } else {
                        _capNhat(context);

                        // Navigator.pop(context);
                      }
                    },
                    child: Text(buttonLabel)),
                const SizedBox(
                  width: 10,
                ),
                xem == true
                    ? const SizedBox(
                        width: 1,
                      )
                    : ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text("Đóng")),
              ],
            )
          ],
        )),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    svs = widget.sinhVienSnapshot;
    xem = widget.xem;
    if (svs != null) {
      txtId.text = svs!.sinhVien!.id ?? "";
      txtTen.text = svs!.sinhVien!.ten ?? "";
      txtLop.text = svs!.sinhVien!.lop ?? "";
      txtQueQuan.text = svs!.sinhVien!.que_quan ?? "";
      txtNamSinh.text = svs!.sinhVien!.nam_sinh ?? "";

      if (xem! == true) {
        buttonLabel = "Đóng";
        title = "Thông tin sinh viên";
      } else {
        buttonLabel = "Cập nhật";
        title = "Cập nhật thông tin";
      }
    }
  }

  _chonAnh(BuildContext context) async {
    _xImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_xImage != null) {
      setState(() {
        _imageChange = true;
      });
    }
  }

  _capNhat(BuildContext context) async {
    showSnackBar(context, "Đang cập nhật dữ liệu...", 300);
    SinhVien sv = SinhVien(
        id: txtId.text,
        ten: txtTen.text,
        lop: txtLop.text,
        que_quan: txtQueQuan.text,
        nam_sinh: txtNamSinh.text,
        anh: null);
    if (_imageChange) {
      FirebaseStorage _storage = FirebaseStorage.instance;
      Reference reference =
          _storage.ref().child("images").child("anh_${sv.id}.jpg");

      UploadTask uploadTask = await _uploadTask(reference, _xImage!);
      uploadTask.whenComplete(() async {
        // Lấy url của ảnh và cập nhật sv vào CSDL
        sv.anh = await reference.getDownloadURL();
        if (svs != null) {
          _capNhatSV(svs, sv);
        } else {
          _themSV(sv);
        }
      }).onError((error, stackTrace) => Future.error("Lỗi xảy ra"));
    } else {
      // neu khong co su thay doi anh
      if (svs != null) {
        sv.anh = svs!.sinhVien!.anh;
        _capNhatSV(svs, sv);
      } else {
        _themSV(sv);
      }
    }
  }

  Future<UploadTask> _uploadTask(Reference reference, XFile xImage) async {
    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': xImage.path});
    UploadTask uploadTask;
    if (kIsWeb) {
      uploadTask = reference.putData(await xImage.readAsBytes(), metadata);
    } else {
      uploadTask = reference.putFile(File(xImage.path), metadata);
    }
    return Future.value(uploadTask);
  }

  _capNhatSV(SinhVienSnapshot? svs, SinhVien sv) {
    svs!
        .capNhat(sv)
        .whenComplete(
            () => showSnackBar(context, "Cập nhật dữ liệu thành công", 3))
        .onError((error, stackTrace) =>
            showSnackBar(context, "Cập nhật dữ liệu không thành công", 3));
  }

  _themSV(SinhVien sv) {
    SinhVienSnapshot.addNew(sv)
        .whenComplete(() => showSnackBar(context, "Thêm dữ liệu thành công", 3))
        .onError((error, stackTrace) {
      showSnackBar(context, "Thêm dữ liệu không thành công", 3);
      return Future.error("Lỗi khi thêm");
    });
  }
}
