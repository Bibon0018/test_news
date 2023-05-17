import 'dart:convert';

import 'package:intl/intl.dart';

class NewsModel {
  String id;
  String img;
  DateTime date;
  String title;
  String? subtitle;
  bool important;
  NewsModel({
    required this.id,
    required this.img,
    required this.date,
    required this.title,
    this.subtitle,
    required this.important,
  });

  NewsModel copyWith({
    String? id,
    String? img,
    DateTime? date,
    String? title,
    String? subtitle,
    bool? important,
  }) {
    return NewsModel(
      id: id ?? this.id,
      img: img ?? this.img,
      date: date ?? this.date,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      important: important ?? this.important,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'img': img,
      'date': date.millisecondsSinceEpoch,
      'title': title,
      'subtitle': subtitle,
      'important': important,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    final data = DateFormat("dd.MM.yy.HH.mm.ss");

    return NewsModel(
      id: map['id'] as String,
      img: map['img'] as String,
      date: data.parse(map['date']
          .replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)}.")),
      title: map['title'] as String,
      subtitle: map['subtitle'] != null ? map['subtitle'] as String : null,
      important: map['important'] != 0 && map['important'] != null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) =>
      NewsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewsModel(id: $id, img: $img, date: $date, title: $title, subtitle: $subtitle, important: $important)';
  }

  @override
  bool operator ==(covariant NewsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.img == img &&
        other.date == date &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.important == important;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        img.hashCode ^
        date.hashCode ^
        title.hashCode ^
        subtitle.hashCode ^
        important.hashCode;
  }
}
