import 'package:flutter/material.dart';

class Hall extends StatefulWidget {
  const Hall({Key? key}) : super(key: key);

  @override
  State<Hall> createState() => _HallState();
}

class _HallState extends State<Hall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Material Design cơ bản"),
        actions: [
          IconButton(
              onPressed: () => _showSnackBar(context,
                  "Hiện nội dung nút Share ở đây nha, sau 5 giây sẽ tự tắt"),
              icon: Icon(Icons.share)),
          IconButton(
              onPressed: () {
                _showSnackBar(
                    context, "Hiện nội dung ở đây nha, sau 5 giây sẽ tự tắt");
              },
              icon: Icon(Icons.call)),
          IconButton(onPressed: null, icon: Icon(Icons.person))
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      duration: const Duration(seconds: 5),
    ));
  }
}
