import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/provider_vidu/my_provider.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<Counter>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Số lần bạn đã bấm nút", style: const TextStyle(fontSize: 30)),
            FutureBuilder<int>(
              future: counter.getValue(),
              builder: (context, snapshot) {
                return Text(
                  "${snapshot.data}",
                  style: const TextStyle(fontSize: 30),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          var provider = context.read<Counter>();
          provider.increment();
        },
        icon: const Icon(
          Icons.add_circle,
          color: Colors.blue,
          size: 50,
        ),
      ),
    );
  }
}
