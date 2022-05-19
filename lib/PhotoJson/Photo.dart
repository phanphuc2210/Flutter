import 'dart:convert';

import 'package:http/http.dart' as http;

class Photo {
  late int albumId;
  late int id;
  late String title;
  late String url;
  late String thumbnailUrl;

  Photo(
      {required this.albumId,
      required this.id,
      required this.title,
      required this.url,
      required this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        albumId: json['albumId'] as int,
        id: json['id'] as int,
        title: json['title'] as String,
        url: json['url'] as String,
        thumbnailUrl: json['thumbnailUrl'] as String);
  }
}

Future<List<Photo>> fetchPhotos() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  if (response.statusCode == 200) {
    List<Photo> photos;
    var list = json.decode(response.body) as List;
    photos = list.map((item) => Photo.fromJson(item)).toList();
    return photos;
  } else {
    print("khong tai duoc Album");
    throw Exception("khong ti duoc Album");
  }
}
