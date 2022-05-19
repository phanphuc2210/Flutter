import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/VNExpress/NewsList.dart';

import 'package:phuc_61cntt1/VNExpress/RSSItem.dart';
import 'package:phuc_61cntt1/VNExpress/RSS_Helper.dart';

class RSS_Page extends StatefulWidget {
  const RSS_Page({Key? key}) : super(key: key);

  @override
  State<RSS_Page> createState() => _RSS_PageState();
}

class _RSS_PageState extends State<RSS_Page> {
  late Future<List<RSSItem>?> rssItems;

  @override
  void initState() {
    super.initState();
    rssItems = RSS_Helper.readVNExpressRSS();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("VNExpress")),
        body: RefreshIndicator(
          onRefresh: () async {
            rssItems = RSS_Helper.readVNExpressRSS()
                .whenComplete(() => setState(() {}));
          },
          child: FutureBuilder<List<RSSItem>?>(
            future: rssItems,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print("Loi xay ra");
                return const Text("Lỗi xảy ra");
              }
              return snapshot.hasData
                  ? NewsList(
                      rssItems: snapshot.data!,
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ));
  }
}
