import 'package:flutter/material.dart';

class MyGridList extends StatelessWidget {
  const MyGridList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("My Grid List")),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(100, (index) {
            return Center(
              child: Text(
                "Item $index",
                style: Theme.of(context).textTheme.headline5,
              ),
            );
          }),
        ));
  }
}
