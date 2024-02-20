import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_segmentedbar_neodocs/blocs/horizontal_bar/horizontal_bar_bloc.dart';
import 'package:horizontal_segmentedbar_neodocs/blocs/horizontal_bar/horizontal_bar_event.dart';
import 'package:horizontal_segmentedbar_neodocs/blocs/horizontal_bar/horizontal_bar_state.dart';
import 'package:horizontal_segmentedbar_neodocs/data/models/section_data.dart';
import 'package:horizontal_segmentedbar_neodocs/screens/widgets/sections_widget.dart';

class BarWithData extends StatelessWidget {
  final List<SectionData> data = [
    SectionData(start: 0, end: 30, color: Colors.red, meaning: "Dangerous"),
    SectionData(start: 30, end: 40, color: Colors.orange, meaning: "Moderate"),
    SectionData(start: 40, end: 60, color: Colors.green, meaning: "Ideal"),
    SectionData(start: 60, end: 70, color: Colors.orange, meaning: "Moderate"),
    SectionData(start: 70, end: 120, color: Colors.red, meaning: "Dangerous"),
  ];

  final TextEditingController _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final totalRange = data.last.end - data.first.start;
    double totalWidth = MediaQuery.of(context).size.width -
        36; // Total available width for the bar graph

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Bar'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 72,
            child: Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 14.0),
                  child: Sections(
                    data: data,
                    totalRange: totalRange,
                    totalWidth: totalWidth,
                  ),
                ),
                for (var barData in data)
                  Positioned(
                    top: 0,
                    left: (barData.start * totalWidth / totalRange) + 10,
                    child: Text(
                      '${barData.start}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Text("${data.last.end}"),
                ),
                BlocBuilder<HorizontalBarBloc, HorizontalBarState>(
                  builder: (context, state) {
                    if (state is HorizontalBarPlotBarState) {
                      return Row(
                        children: [
                          SizedBox(
                            width: state.pointerPosition,
                          ),
                          Column(
                            children: [
                              const Expanded(child: SizedBox()),
                              const Icon(CupertinoIcons.triangle_fill),
                              Text(state.pointerValue.toString())
                            ],
                          ),
                        ],
                      );
                    }
                    return SizedBox();
                  },
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          BlocBuilder<HorizontalBarBloc, HorizontalBarState>(
            builder: (context, state) {
              String meaning = '';
              Color textColor = Colors.black;
              if (state is HorizontalBarPlotBarState) {
                int enteredValue = state.pointerValue;
                for (var sectionData in data) {
                  if (enteredValue >= sectionData.start &&
                      enteredValue <= sectionData.end) {
                    meaning = sectionData.meaning;
                    textColor = sectionData.color;
                    break;
                  }
                }
              }
              return Padding(
                padding: const EdgeInsets.all(11.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (meaning.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(28.0),
                        child: Text(
                          "Your level is: $meaning",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: textColor),
                        ),
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            onChanged: (value) =>
                                BlocProvider.of<HorizontalBarBloc>(context).add(
                                    HorizontalBarOnValueChangeEvent(
                                        int.parse(_textFieldController.text),
                                        totalRange,
                                        totalWidth)),
                            controller: _textFieldController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Enter value',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90))),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                            onTap: () => state is HorizontalBarInvalidValueState
                                ? () {}
                                : BlocProvider.of<HorizontalBarBloc>(context)
                                    .add(HorizontalBarValueSubmitEvent(
                                        int.parse(_textFieldController.text),
                                        totalRange,
                                        totalWidth)),
                            child: const Icon(
                              CupertinoIcons.arrow_right_circle,
                              size: 50,
                            ))
                      ],
                    ),
                    if (state is HorizontalBarInvalidValueState)
                      Text(
                        state.errorMsg,
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.start,
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
