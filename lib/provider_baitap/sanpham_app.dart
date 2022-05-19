import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/provider_baitap/sanpham_page.dart';
import 'package:phuc_61cntt1/provider_baitap/sanpham_provider.dart';
import 'package:provider/provider.dart';

class SanPhamApp extends StatelessWidget {
  const SanPhamApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QLSanPham(),
      child: const MaterialApp(
        title: "Danh sách sản phẩm",
        home: SanPhamPage(),
      ),
    );
  }
}
