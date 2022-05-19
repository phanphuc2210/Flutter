import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/PhotoJson/Photo.dart';
import 'package:phuc_61cntt1/PhotoJson/PhotoList.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  late Future<List<Photo>> photos;

  @override
  void initState() {
    super.initState();
    photos = fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Photos Page")),
        body: FutureBuilder<List<Photo>>(
          future: photos,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print("loi xay ra");
              return Text("lỗi xảy ra");
            }
            return snapshot.hasData
                ? PhotoList(
                    photos: snapshot.data!,
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ));
  }
}
