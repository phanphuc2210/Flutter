import 'package:flutter/material.dart';

class MyStateFullWidget extends StatefulWidget {
  const MyStateFullWidget({Key? key}) : super(key: key);

  @override
  _MyStateFullWidgetState createState() => _MyStateFullWidgetState();
}

class _MyStateFullWidgetState extends State<MyStateFullWidget> {
  String st = "yes";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Statefull Widget"),
      ),
      body: Column(children: [
        Text("My Text: $st"),
        ElevatedButton(
            onPressed: () {
              setState(() {
                if (st == "yes") {
                  st = "no";
                } else {
                  st = "yes";
                }
              });
            },
            child: Text("Bam vao day"))
      ]),
    );
  }
}
