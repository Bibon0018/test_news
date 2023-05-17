enum NewsType { feed, top, article }

extension NewsTypeExtension on NewsType {
  String? get id {
    switch (this) {
      case NewsType.feed:
        return null;
      case NewsType.top:
        return "top";
      case NewsType.article:
        return "article";
      default:
        return null;
    }
  }
}
