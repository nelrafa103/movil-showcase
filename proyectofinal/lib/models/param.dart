import 'package:flutter/material.dart';

class Param {
  final String url;
  final String icon;
  final Color color;
  final String title;
  final int id;
  Param(
      {required this.icon,
      required this.id,
      required this.title,
      required this.url,
      required this.color});
}
