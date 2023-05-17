// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class NewsDetailModel {
  String id;
  String title;
  String img;
  DateTime date;
  String text;
  String url;
  List<GalleryModel> gallery;
  NewsDetailModel({
    required this.id,
    required this.title,
    required this.img,
    required this.date,
    required this.text,
    required this.url,
    required this.gallery,
  });

  NewsDetailModel copyWith({
    String? id,
    String? title,
    String? img,
    DateTime? date,
    String? text,
    String? url,
    List<GalleryModel>? gallery,
  }) {
    return NewsDetailModel(
      id: id ?? this.id,
      title: title ?? this.title,
      img: img ?? this.img,
      date: date ?? this.date,
      text: text ?? this.text,
      url: url ?? this.url,
      gallery: gallery ?? this.gallery,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'img': img,
      'date': date.millisecondsSinceEpoch,
      'text': text,
      'url': url,
      'gallery': gallery.map((x) => x.toMap()).toList(),
    };
  }

  factory NewsDetailModel.fromMap(Map<String, dynamic> map) {
    final data = DateFormat("dd.MM.yy.HH.mm.ss");

    return NewsDetailModel(
      id: map['id'] as String,
      title: map['title'] as String,
      img: map['img'] as String,
      date: data.parse(map['date']
          .replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)}.")),
      text: map['text'] as String,
      url: map['url'] as String,
      gallery: map['gallery'] != null
          ? (map['gallery'] as List)
              .map((x) => GalleryModel.fromMap(Map<String, dynamic>.from(x)))
              .toList()
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsDetailModel.fromJson(String source) =>
      NewsDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NewsDetailModel(id: $id, title: $title, img: $img, date: $date, text: $text, url: $url, gallery: $gallery)';
  }

  @override
  bool operator ==(covariant NewsDetailModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.img == img &&
        other.date == date &&
        other.text == text &&
        other.url == url &&
        listEquals(other.gallery, gallery);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        img.hashCode ^
        date.hashCode ^
        text.hashCode ^
        url.hashCode ^
        gallery.hashCode;
  }
}

class GalleryModel {
  int sortId;
  String smallImg;
  String bigImg;
  GalleryModel({
    required this.sortId,
    required this.smallImg,
    required this.bigImg,
  });

  GalleryModel copyWith({
    int? sortId,
    String? smallImg,
    String? bigImg,
  }) {
    return GalleryModel(
      sortId: sortId ?? this.sortId,
      smallImg: smallImg ?? this.smallImg,
      bigImg: bigImg ?? this.bigImg,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sortId': sortId,
      'smallImg': smallImg,
      'bigImg': bigImg,
    };
  }

  factory GalleryModel.fromMap(Map<String, dynamic> map) {
    return GalleryModel(
      sortId: map['sortId'] as int,
      smallImg: map['smallImg'] as String,
      bigImg: map['bigImg'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GalleryModel.fromJson(String source) =>
      GalleryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Gallery(sortId: $sortId, smallImg: $smallImg, bigImg: $bigImg)';

  @override
  bool operator ==(covariant GalleryModel other) {
    if (identical(this, other)) return true;

    return other.sortId == sortId &&
        other.smallImg == smallImg &&
        other.bigImg == bigImg;
  }

  @override
  int get hashCode => sortId.hashCode ^ smallImg.hashCode ^ bigImg.hashCode;
}
