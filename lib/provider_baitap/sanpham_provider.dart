import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SanPham {
  late String ten;
  late String moTa;
  late int gia;
  File? img;

  SanPham({required this.ten, required this.moTa, required this.gia, this.img});
}

class QLSanPham extends ChangeNotifier {
  final List<SanPham> _list = [
    // SanPham(
    //     ten: "Mít",
    //     moTa: "Mít Thái loại 1",
    //     gia: 20000,
    //     img: File('/sdcard/Download/Go-Bananas.jpg')),
    // SanPham(
    //     ten: "Xoài các Hòa lộc",
    //     moTa: "Xoài các xuất xứ Long Khánh",
    //     gia: 75000,
    //     img: File('/sdcard/Download/Go-Bananas.jpg')),
    // SanPham(
    //     ten: "Sầu riêng Ri6",
    //     moTa: "Sầu riêng xuất xứ Khánh Sơn",
    //     gia: 80000,
    //     img: File('/sdcard/Download/Go-Bananas.jpg')),
    // SanPham(
    //     ten: "Bưởi da xanh",
    //     moTa: "Bưởi xuất xứ Tiền Giang",
    //     gia: 40000,
    //     img: File('/sdcard/Download/Go-Bananas.jpg')),
    // SanPham(
    //     ten: "Càm sành",
    //     moTa: "Càm sành Tiền Giang loại 1",
    //     gia: 25000,
    //     img: File('/sdcard/Download/Go-Bananas.jpg')),
    // SanPham(
    //     ten: "Thanh long",
    //     moTa: "Thanh long giải cứu Phan Thiết",
    //     gia: 10000,
    //     img: File('/sdcard/Download/Go-Bananas.jpg')),
    // SanPham(
    //     ten: "Mãng cầu",
    //     moTa: "Mãng cầu xuất xứ Khánh Vĩnh",
    //     gia: 35000,
    //     img: File('/sdcard/Download/Go-Bananas.jpg')),
    // SanPham(
    //     ten: "Vãi thiều",
    //     moTa: "Vãi thiều xuất xứ Diêm Khánh",
    //     gia: 30000,
    //     img: File('/sdcard/Download/Go-Bananas.jpg')),
  ];

  List<SanPham> get list => _list;

  

  void add(SanPham sp) {
    _list.add(sp);
    notifyListeners();
  }

  void delete(int index) {
    _list.removeAt(index);
    notifyListeners();
  }

  void update(int index, SanPham spNew) {
    _list[index] = spNew;
    notifyListeners();
  }

  void update_Thay(SanPham spCu, SanPham spMoi) {
    spCu.ten = spMoi.ten;
    spCu.moTa = spMoi.moTa;
    spCu.gia = spMoi.gia;
    notifyListeners();
  }
}
