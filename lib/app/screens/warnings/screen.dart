import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/warnings/widgets/abnormality_item.dart';
import 'package:vma/core/models/abnormality.dart';
import 'package:vma/core/view_models/abnormality_model.dart';

class WarningScreen extends StatefulWidget {
  const WarningScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WarningScreenState();
}

class _WarningScreenState extends VMAState<WarningScreen> {
  final _model = AbnormalityModel();

  @override
  void initState() {
    super.initState();
    _model.loadAbnormalities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModel<AbnormalityModel>(
        model: _model,
        child: ScopedModelDescendant<AbnormalityModel>(
          builder: (context, widget, model) {
            return FutureBuilder(
              future: _model.abnormalities,
              builder: (
                BuildContext context,
                AsyncSnapshot<List<Abnormality>> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final abnormalities = snapshot.data ?? [];

                  if (abnormalities.isEmpty) {
                    return const Center(
                      child: Text('No data'),
                    );
                  }

                  return ListView.builder(
                    itemCount: abnormalities.length,
                    itemBuilder: (BuildContext context, index) {
                      final abnormality = abnormalities[index];
                      return AbnormalityItem(item: abnormality);
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
