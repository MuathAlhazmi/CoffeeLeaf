import 'package:flutter/material.dart';

class InfoModel {
  final List<String> content;
  final String title;
  final String sub;
  final String image;
  final List<IconData> iconDataList;
  final List<String> contentTitle;
  const InfoModel(
      {required this.content,
      required this.image,
      required this.sub,
      required this.title,
      required this.contentTitle,
      required this.iconDataList});
}
