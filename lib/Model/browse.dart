import 'package:flutter/material.dart';

class Browse {
  String title;
  String url;
  String desc;
  String? imgUrl;
  String? extract;

  Browse({
    required this.title,
    required this.url,
    required this.desc,
    required this.imgUrl,
    required this.extract,
  });

  Browse.fromMap(Map map)
      : this.title = map['title'],
        this.url = map['url'],
        this.desc = map['desc'],
        this.imgUrl = map['imgUrl'],
        this.extract = map['extract'];

  Map toMap() {
    return {
      'title': this.title,
      'url': this.url,
      'desc': this.desc,
      'imgUrl': this.imgUrl,
      'extract': this.extract,
    };
  }
}
