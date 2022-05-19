import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/PhotoJson/Photo.dart';

class PhotoList extends StatelessWidget {
  List<Photo> photos;
  PhotoList({Key? key, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 200,
      padding: EdgeInsets.all(5),
      mainAxisSpacing: 5,
      crossAxisSpacing: 5,
      children: List.generate(
          photos.length,
          (index) => Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blue)),
                child: Image.network(photos[index].thumbnailUrl),
              )),
    );
  }
}
