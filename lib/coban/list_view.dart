import 'package:flutter/material.dart';

List<String> list = ["Mận", "Mơ", "Sầu riêng", "Dưa hấu", "Bưởi", "Cam"];

class MyListView extends StatelessWidget {
  const MyListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My ListView")),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(list[index]),
              leading: const Icon(Icons.apple),
              subtitle: const Text("Cửa hàng trái cây 61CNTT1"),
            );
          },
          separatorBuilder: (context, index) => const Divider(
                thickness: 2,
              ),
          itemCount: list.length),
    );
  }
}
