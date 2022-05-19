import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phuc_61cntt1/provider_baitap/sanpham_provider.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ChiTietPage extends StatefulWidget {
  SanPham? sp;
  ChiTietPage({Key? key, this.sp}) : super(key: key);

  @override
  State<ChiTietPage> createState() => _ChiTietPageState();
}

class _ChiTietPageState extends State<ChiTietPage> {
  SanPham? spCu, spMoi;
  String labelButton = "Thêm";
  bool them = true;
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtMoTa = TextEditingController();
  TextEditingController txtGia = TextEditingController();
  File? image;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);
    this.image = imageTemporary;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientText(
          "$labelButton sản phẩm",
          style: const TextStyle(
            fontSize: 25.0,
          ),
          gradientType: GradientType.radial,
          gradientDirection: GradientDirection.ttb,
          radius: 6,
          colors: const [
            Color(0xff159DFF),
            Color(0xff002981),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: txtTen,
              decoration: const InputDecoration(
                labelText: "Tên sản phẩm:",
              ),
            ),
            TextFormField(
              controller: txtMoTa,
              decoration: const InputDecoration(
                labelText: "Mô tả:",
              ),
            ),
            TextFormField(
              controller: txtGia,
              decoration: const InputDecoration(
                labelText: "Giá bán:",
              ),
              keyboardType: TextInputType.number,
            ),
            Container(
              child: Row(
                children: [
                  Text("Hình ảnh: "),
                  ElevatedButton(
                      onPressed: () => pickImage(), child: Text("Chọn ảnh."))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (them == true) {
                      themMoi();
                    } else {
                      capNhat();
                    }
                  },
                  child: GradientText(
                    labelButton,
                    gradientType: GradientType.radial,
                    gradientDirection: GradientDirection.ttb,
                    radius: 6,
                    colors: const [
                      Color(0xff159DFF),
                      Color(0xff002981),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void themMoi() {
    spMoi = SanPham(
        ten: txtTen.text,
        moTa: txtMoTa.text,
        gia: int.parse(txtGia.text),
        img: image);

    // var provider = context.read<QLSanPham>();
    var provider = Provider.of<QLSanPham>(context, listen: false);
    provider.add(spMoi!);

    Navigator.pop(context);
  }

  void capNhat() {
    spMoi = SanPham(
        ten: txtTen.text,
        moTa: txtMoTa.text,
        gia: int.parse(txtGia.text),
        img: image);

    var provider = context.read<QLSanPham>();
    provider.update_Thay(spCu!, spMoi!);

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    spCu = widget.sp;
    if (spCu != null) {
      them = false;
      labelButton = "Cập nhật";
      txtTen.text = spCu!.ten;
      txtMoTa.text = spCu!.moTa;
      txtGia.text = spCu!.gia.toString();
    }
  }
}
