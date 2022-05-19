import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/coban/fruit_model.dart';

class MyGridView extends StatelessWidget {
  const MyGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giải cứu nông sản'),
      ),
      body: GridView.extent(
          maxCrossAxisExtent: 250,
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8,
          children: listSP
              .map((sp) => Card(
                    elevation: 5,
                    shadowColor: Colors.black,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.network(
                            sp.url,
                            height: 150,
                          ),
                          Text(sp.ten),
                          Text(
                            "Giá: ${sp.gia}/kg",
                            style: const TextStyle(color: Colors.red),
                          ),
                        ]),
                  ))
              .toList()),
    );
  }
}
