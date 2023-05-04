import 'dart:convert';
import 'package:flutter/material.dart';

AnalyticData analyticDataFromJson(String str) => AnalyticData.fromMap(json.decode(str));

String analyticDataToJson(AnalyticData data) => json.encode(data.toMap());

class AnalyticData {
  final String? title;
  final int? count;
  final Color? color;
  final String? imageCard;
  final String? imageCategory;

  AnalyticData({
    this.title,
    this.count,
    this.color,
    this.imageCard,
    this.imageCategory
  });


factory AnalyticData.fromMap(Map<String, dynamic> json) => AnalyticData(
    title: json['title'],
    count: json['count'],
    color: json['color'],
    imageCard: json['imageCard'],
    imageCategory: json['imageCategory'],
  );
  Map<String, dynamic> toMap() => {
    'title':title ,
    'count':count ,
    'color':color ,
    'imageCard':imageCard ,
    'imageCategory':imageCategory ,
  };

}