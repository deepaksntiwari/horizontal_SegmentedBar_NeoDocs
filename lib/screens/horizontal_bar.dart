import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horizontal_segmentedbar_neodocs/Constants.dart';
import 'package:horizontal_segmentedbar_neodocs/blocs/horizontal_bar/horizontal_bar_bloc.dart';
import 'package:horizontal_segmentedbar_neodocs/blocs/horizontal_bar/horizontal_bar_event.dart';
import 'package:horizontal_segmentedbar_neodocs/blocs/horizontal_bar/horizontal_bar_state.dart';
import 'package:horizontal_segmentedbar_neodocs/screens/widgets/pointer_widget.dart';
import 'package:horizontal_segmentedbar_neodocs/screens/widgets/sections_widget.dart';

class BarWithData extends StatelessWidget {
  final TextEditingController _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width -
        36; // Total available width for the bar graph

    return Scaffold(
      appBar: AppBar(
        title: const Text('Horizontal Level Bar'),
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
                    data: Constants.data,
                    totalRange: Constants.totalRange,
                    totalWidth: totalWidth,
                  ),
                ),
                for (var barData in Constants.data)
                  Positioned(
                    top: 0,
                    left: (barData.start * totalWidth / Constants.totalRange) +
                        10,
                    child: Text(
                      '${barData.start}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Text("${Constants.data.last.end}"),
                ),
                PointerWidget(),
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
                for (var sectionData in Constants.data) {
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
                        padding: const EdgeInsets.only(bottom: 50.0),
                        child: Text(
                          "Your level is: $meaning",
                          style: TextStyle(
                              fontSize: 20,
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
                                        _textFieldController.text.isNotEmpty
                                            ? int.parse(
                                                _textFieldController.text)
                                            : 0,
                                        Constants.totalRange,
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
                                        Constants.totalRange,
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
