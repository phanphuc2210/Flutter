abstract class RSSItem {
  String? title;
  String? pubDate;
  String? description;
  String? link;
  String? imageUrl;

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "date": pubDate,
      "description": description,
      "url": link,
      "imageUrl": imageUrl
    };
  }

  RSSItem getRSSFromJson(Map<String, dynamic> json) {
    title = json['title'];
    pubDate = json['pubDate'];
    description = _getDescription(json['description']);
    link = json['link'];
    imageUrl = _getImageUrl(json['description']);
    return this;
  }

  String _getDescription(String rawDescription);
  String? _getImageUrl(String rawDescription);
}

class VNExpressRSSItem extends RSSItem {
  @override
  String _getDescription(String rawDescription) {
    int start = rawDescription.indexOf('</a></br>') + 9;
    if (start > 9) {
      return rawDescription.substring(start);
    }
    return "";
  }

  @override
  String? _getImageUrl(String rawDescription) {
    int start = rawDescription.indexOf('img src="') + 9;
    if (start > 9) {
      int end = rawDescription.indexOf('"', start);
      return rawDescription.substring(start, end);
    }
    return null;
  }
}
