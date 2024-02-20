import 'package:flutter/cupertino.dart';
import 'package:horizontal_segmentedbar_neodocs/data/models/section_data.dart';
import 'package:horizontal_segmentedbar_neodocs/screens/widgets/individual_section_widget.dart';

class Sections extends StatelessWidget {
  const Sections(
      {super.key,
      required this.data,
      required this.totalRange,
      required this.totalWidth});
  final List<SectionData> data;
  final int totalRange;
  final double totalWidth;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(90)),
      child: Row(
        children: [
          for (var barData in data)
            IndividualSection(
                barData: barData,
                totalRange: totalRange,
                totalWidth: totalWidth),
        ],
      ),
    );
  }
}
