import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_segmentedbar_neodocs/data/models/section_data.dart';

class BarWithData extends StatefulWidget {
  @override
  _BarWithDataState createState() => _BarWithDataState();
}

class _BarWithDataState extends State<BarWithData> {
  final List<SectionData> data = [
    SectionData(start: 0, end: 30, color: Colors.red),
    SectionData(start: 30, end: 40, color: Colors.orange),
    SectionData(start: 40, end: 60, color: Colors.green),
    SectionData(start: 60, end: 70, color: Colors.orange),
    SectionData(start: 70, end: 120, color: Colors.red),
  ];

  final TextEditingController _textFieldController = TextEditingController();
  double _customWidth = 38; // Default width
  @override
  Widget build(BuildContext context) {
    final totalRange = data.last.end - data.first.start;
    double totalWidth = MediaQuery.of(context).size.width -
        36; // Total available width for the bar graph
    double pointerLocation = (_customWidth * totalWidth / totalRange) + 10;

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
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(90)),
                    child: Row(
                      children: [
                        for (var barData in data)
                          Expanded(
                            flex: (barData.end - barData.start) *
                                totalWidth ~/
                                totalRange,
                            child: Container(
                              height: 20,
                              color: barData.color,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: [
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
                    Row(
                      children: [
                        SizedBox(
                          width: pointerLocation > totalWidth
                              ? totalWidth
                              : pointerLocation,
                        ),
                        Column(
                          children: [
                            const Expanded(child: SizedBox()),
                            const Icon(CupertinoIcons.triangle_fill),
                            Text(_customWidth.toInt().toString())
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textFieldController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Enter ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(CupertinoIcons.arrow_right_circle, size: 50),
                  onPressed: () {
                    setState(() {
                      _customWidth = double.parse(_textFieldController.text);
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
