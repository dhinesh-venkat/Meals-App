import 'package:flutter/material.dart';

class Category{
  @required final String id;
  @required final String title;
  final Color color;

  const Category({this.id,this.title,this.color});
}