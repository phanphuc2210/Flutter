class MyNotificationMessage {
  String? title, body, from;
  String? time;
  MyNotificationMessage({this.title, this.body, this.from, this.time});

  Map<String, dynamic> toJson() {
    return {'title': title, 'body': body, 'from': from, 'time': time};
  }

  factory MyNotificationMessage.fromJson(Map<String, dynamic> map) {
    return MyNotificationMessage(
        title: map['title'] as String,
        body: map['body'] as String,
        from: map['from'] as String,
        time: map['time'] as String);
  }
}
