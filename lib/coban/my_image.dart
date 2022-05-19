import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  const MyImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Image"),
        leading: Icon(Icons.menu),
        actions: [
          IconButton(onPressed: () => {}, icon: Icon(Icons.share)),
          IconButton(onPressed: () => {}, icon: Icon(Icons.call))
        ],
      ),
      body: Column(
        children: [
          Container(
            width: 250,
            child: Image.asset("asset/images/sontung9.jpg"),
          ),
          Container(
            width: 250,
            child:
                Image.network("https://wallpaperaccess.com/full/2104517.jpg"),
          ),
          SizedBox(height: 10),
          Row(
            children: const [
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star, color: Colors.yellow),
              Icon(Icons.star, color: Colors.black),
              Icon(Icons.star, color: Colors.black),
              Text("150 đánh giá")
            ],
          )
        ],
      ),
    );
  }
}
