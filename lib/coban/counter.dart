import 'package:flutter/material.dart';

class MyCounter extends StatefulWidget {
  const MyCounter({Key? key}) : super(key: key);

  @override
  State<MyCounter> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyCounter> {
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Counter"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => setState(() {
                    counter = counter + 1;
                  }),
              child: const Text(
                "+",
                style: TextStyle(fontSize: 40),
              )),
          Text("$counter",
              style: const TextStyle(color: Colors.blue, fontSize: 40)),
          ElevatedButton(
              onPressed: () => setState(() {
                    counter = counter - 1;
                  }),
              child: const Text(
                "-",
                style: TextStyle(fontSize: 40),
              )),
        ],
      )),
    );
  }
}
