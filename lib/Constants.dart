import 'package:flutter/material.dart';
import 'package:horizontal_segmentedbar_neodocs/data/models/section_data.dart';

class Constants {
  static final List<SectionData> data = [
    SectionData(start: 0, end: 30, color: Colors.red, meaning: "Dangerous"),
    SectionData(start: 30, end: 40, color: Colors.orange, meaning: "Moderate"),
    SectionData(start: 40, end: 60, color: Colors.green, meaning: "Ideal"),
    SectionData(start: 60, end: 70, color: Colors.orange, meaning: "Moderate"),
    SectionData(start: 70, end: 120, color: Colors.red, meaning: "Dangerous"),
  ];
  static final totalRange = data.last.end - data.first.start;
}
