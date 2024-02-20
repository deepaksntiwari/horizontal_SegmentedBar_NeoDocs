import 'package:flutter/cupertino.dart';
import 'package:horizontal_segmentedbar_neodocs/data/models/section_data.dart';

class IndividualSection extends StatelessWidget {
  const IndividualSection(
      {super.key,
      required this.barData,
      required this.totalRange,
      required this.totalWidth});
  final SectionData barData;
  final int totalRange;
  final double totalWidth;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: (barData.end - barData.start) * totalWidth ~/ totalRange,
      child: Container(
        height: 20,
        color: barData.color,
      ),
    );
  }
}
