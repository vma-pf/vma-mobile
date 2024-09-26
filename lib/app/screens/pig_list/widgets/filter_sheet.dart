import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/pig_list/widgets/selectable_label.dart';
import 'package:vma/core/models/enums/pig_health_status.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends VMAState<FilterSheet> {
  final _defaultWeightRange = const RangeValues(0, 50);
  final _defaultHeightRange = const RangeValues(0, 50);
  final _defaultWidthRange = const RangeValues(0, 50);

  late RangeValues _weightRange;
  late RangeValues _heightRange;
  late RangeValues _widthRange;

  void _resetFilter() {
    setState(() {
      _weightRange = _defaultWeightRange;
      _heightRange = _defaultHeightRange;
      _widthRange = _defaultWidthRange;
    });
  }

  @override
  void initState() {
    super.initState();
    _weightRange = _defaultWeightRange;
    _heightRange = _defaultHeightRange;
    _widthRange = _defaultWidthRange;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: context.pop,
                alignment: Alignment.centerLeft,
                color: Theme.of(context).primaryColor,
              ),
              TextButton(
                onPressed: _resetFilter,
                child: const Text('Đặt lại'),
              ),
            ],
          ),
          Accordion(
            children: [
              AccordionSection(
                header: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Tình trạng sức khỏe',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                content: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    SelectableLabel(
                      text: PigHealthStatus.normal.name,
                      onTap: () => {},
                    ),
                    SelectableLabel(
                      text: PigHealthStatus.sick.name,
                      onTap: () => {},
                    ),
                  ],
                ),
              ),
              AccordionSection(
                header: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child:
                      Text('Thông số', style: TextStyle(color: Colors.white)),
                ),
                content: StatefulBuilder(
                  builder: (context, setState) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            const Text('Cân nặng:'),
                            RangeSlider(
                              values: _weightRange,
                              onChanged: (RangeValues values) => setState(() {
                                _weightRange = values;
                              }),
                              max: 150,
                              divisions: 10,
                              labels: RangeLabels(
                                '${_weightRange.start.round().toString()} kg',
                                '${_weightRange.end.round().toString()} kg',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Chiều cao:'),
                            RangeSlider(
                              values: _heightRange,
                              onChanged: (RangeValues values) => setState(() {
                                _heightRange = values;
                              }),
                              max: 200,
                              divisions: 10,
                              labels: RangeLabels(
                                '${_heightRange.start.round().toString()} cm',
                                '${_heightRange.end.round().toString()} cm',
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text('Chiều rộng:'),
                            RangeSlider(
                              values: _widthRange,
                              onChanged: (RangeValues values) => setState(() {
                                _widthRange = values;
                              }),
                              max: 100,
                              divisions: 10,
                              labels: RangeLabels(
                                '${_widthRange.start.round().toString()} cm',
                                '${_widthRange.end.round().toString()} cm',
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              AccordionSection(
                header: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Giống', style: TextStyle(color: Colors.white)),
                ),
                content: Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 10,
                  runSpacing: 10,
                  // FIXME: Load breeds from API
                  children: [
                    SelectableLabel(text: 'Vietnamese', onTap: () => {}),
                    SelectableLabel(text: 'Yorkshire', onTap: () => {}),
                    SelectableLabel(text: 'Landrace', onTap: () => {}),
                    SelectableLabel(text: 'Duroc', onTap: () => {}),
                    SelectableLabel(text: 'Vietnamese', onTap: () => {}),
                    SelectableLabel(text: 'Yorkshire', onTap: () => {}),
                    SelectableLabel(text: 'Landrace', onTap: () => {}),
                    SelectableLabel(text: 'Duroc', onTap: () => {}),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
