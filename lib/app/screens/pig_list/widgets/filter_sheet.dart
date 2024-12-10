import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/pig_list/widgets/selectable_label.dart';
import 'package:vma/core/models/enums/pig_health_status.dart';
import 'package:vma/core/utils/pig_health_status_transformer.dart';
import 'package:vma/core/view_models/pig_list_model.dart';

class FilterSheet extends StatefulWidget {
  final PigListModel model;
  const FilterSheet({super.key, required this.model});

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends VMAState<FilterSheet> {
  late RangeValues _weightRange;
  late RangeValues _heightRange;
  late RangeValues _widthRange;

  void _setFilter({bool resetValues = false}) {
    if (resetValues) widget.model.resetSearchParameters();
    setState(() {
      _weightRange =
          RangeValues(widget.model.minWeight, widget.model.maxWeight);
      _heightRange =
          RangeValues(widget.model.minHeight, widget.model.maxHeight);
      _widthRange = RangeValues(widget.model.minWidth, widget.model.maxWidth);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      widget.model.loadBreeds();
    });
    _setFilter();
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
                onPressed: () => _setFilter(resetValues: true),
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
                      isSelected: widget.model.healthStatuses
                          .contains(PigHealthStatus.normal.name),
                      text: PigHealthStatusTransformer.tranformToText(
                        PigHealthStatus.normal,
                      ),
                      onTap: () {
                        final String status =
                            PigHealthStatusTransformer.tranformToText(
                          PigHealthStatus.normal,
                        );
                        if (widget.model.healthStatuses.contains(status)) {
                          widget.model.healthStatuses.remove(status);
                        } else {
                          widget.model.healthStatuses.add(status);
                        }
                      },
                    ),
                    SelectableLabel(
                      isSelected: widget.model.healthStatuses
                          .contains(PigHealthStatus.sick.name),
                      text: PigHealthStatusTransformer.tranformToText(
                        PigHealthStatus.sick,
                      ),
                      onTap: () {
                        final String status =
                            PigHealthStatusTransformer.tranformToText(
                          PigHealthStatus.sick,
                        );
                        if (widget.model.healthStatuses.contains(status)) {
                          widget.model.healthStatuses.remove(status);
                        } else {
                          widget.model.healthStatuses.add(status);
                        }
                      },
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
                                widget.model.minWeight = _weightRange.start;
                                widget.model.maxWeight = _weightRange.end;
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
                                widget.model.minHeight = _heightRange.start;
                                widget.model.maxHeight = _heightRange.end;
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
                                widget.model.minWidth = _widthRange.start;
                                widget.model.maxWidth = _widthRange.end;
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
                content: FutureBuilder<List<String>>(
                  future: widget.model.breeds,
                  builder: (
                    BuildContext futureContext,
                    AsyncSnapshot<List<String>> snapshot,
                  ) {
                    final List<String> breeds = snapshot.data ?? [];

                    return Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        ...breeds.map(
                          (String breed) => SelectableLabel(
                            isSelected:
                                widget.model.selectedBreeds.contains(breed),
                            text: breed,
                            onTap: () {
                              if (widget.model.selectedBreeds.contains(breed)) {
                                widget.model.selectedBreeds.remove(breed);
                              } else {
                                widget.model.selectedBreeds.add(breed);
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
