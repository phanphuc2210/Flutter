import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/fcm/message.dart';
import 'package:phuc_61cntt1/fcm/message_helper.dart';

class PageListMessage extends StatefulWidget {
  const PageListMessage({Key? key}) : super(key: key);

  @override
  State<PageListMessage> createState() => _PageListMessageState();
}

class _PageListMessageState extends State<PageListMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of messages"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<MyNotificationMessage>?>(
          future: MessageHelper.readMessage(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Có lỗi xảy ra");
            } else if (!snapshot.hasData) {
              return const Text("Không có dữ liệu");
            } else {
              List<MyNotificationMessage>? listMessage = snapshot.data;
              return ListView.separated(
                itemBuilder: (context, index) => ListTile(
                  leading: Text(listMessage?[index].from ?? "Unknow"),
                  title: Text(listMessage?[index].title ?? "No title"),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(listMessage?[index].body ?? "No body"),
                        Text(listMessage?[index].time ?? "Unknow")
                      ]),
                ),
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                ),
                itemCount: listMessage?.length ?? 0,
              );
            }
          },
        ),
      ),
    );
  }
}
