import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/herds/widgets/herd_item.dart';
import 'package:vma/core/models/herd.dart';
import 'package:vma/core/view_models/herd_list_model.dart';

class HerdsScreen extends StatefulWidget {
  const HerdsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HerdScreenState();
}

class _HerdScreenState extends VMAState<HerdsScreen> {
  final _model = HerdListModel();

  @override
  void initState() {
    super.initState();
    _model.loadHerds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách đàn'),
      ),
      body: ScopedModel<HerdListModel>(
        model: _model,
        child: ScopedModelDescendant<HerdListModel>(
          builder: (BuildContext context, Widget? widget, HerdListModel model) {
            return FutureBuilder(
              future: _model.herds,
              builder:
                  (BuildContext context, AsyncSnapshot<List<Herd>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final List<Herd> herds = snapshot.data ?? [];

                  if (herds.isEmpty) {
                    return const Center(
                      child: Text('Không tìm thấy thông tin'),
                    );
                  }

                  return ListView.builder(
                    itemCount: herds.length,
                    itemBuilder: (context, index) {
                      final Herd herd = herds[index];
                      return HerdItem(herd: herd);
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}
