import 'package:flutter/material.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/pig_list/widgets/search_bar.dart' as vma;
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/screens/pig_list/widgets/pig_item.dart';
import 'package:vma/core/view_models/pig_list_model.dart';
import 'package:vma/core/models/pig.dart';

class PigList extends StatefulWidget {
  final String herdId;
  const PigList({super.key, required this.herdId});

  @override
  State<PigList> createState() => _PigListState();
}

class _PigListState extends VMAState<PigList> {
  final PigListModel _model = PigListModel();

  @override
  void initState() {
    super.initState();
    _model.herdId = widget.herdId;
    _model.loadPigs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách heo'),
      ),
      body: ScopedModel<PigListModel>(
        model: _model,
        child: ScopedModelDescendant<PigListModel>(
          builder: (context, child, model) {
            return Column(
              children: [
                const SizedBox(height: 10),
                vma.SearchBar(model: _model),
                const SizedBox(height: 10),
                FutureBuilder<List<Pig>>(
                  future: _model.pigs,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      var pigs = snapshot.data ?? [];

                      if (pigs.isEmpty) {
                        return Center(child: Text('Không có heo nào'));
                      }

                      return Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 0,
                          ),
                          itemCount: pigs.length,
                          itemBuilder: (context, index) {
                            var pig = pigs[index];
                            return PigItem(pig: pig);
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
