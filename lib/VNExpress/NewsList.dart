import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/VNExpress/Detail_page.dart';
import 'package:phuc_61cntt1/VNExpress/RSSItem.dart';

class NewsList extends StatelessWidget {
  List<RSSItem>? rssItems;
  NewsList({Key? key, required this.rssItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print(rssItems![index].link);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailPage(link: rssItems![index].link),
                  ));
            },
            child: ListTile(
              title: Text(rssItems![index].title!),
              leading: SizedBox(
                width: 100,
                child: _getImage(rssItems![index].imageUrl),
              ),
              // leading: _getImage(rssItems![index].imageUrl),
              subtitle: Text(rssItems![index].description!),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(
              thickness: 2,
            ),
        itemCount: rssItems!.length);
  }

  Widget _getImage(String? url) {
    if (url != null) {
      return Image.network(
        url,
        fit: BoxFit.fitWidth,
      );
    }

    return const Center(
      child: Icon(Icons.image),
    );
  }
}
