import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/treatment_plans/common-disease-treatment-guide/widgets/common_disease_item.dart';
import 'package:vma/core/models/common_disease.dart';
import 'package:vma/core/view_models/common_disease_model.dart';

class CommonDiseaseList extends StatefulWidget {
  const CommonDiseaseList({super.key});

  @override
  State<CommonDiseaseList> createState() => _CommonDiseaseListState();
}

class _CommonDiseaseListState extends VMAState<CommonDiseaseList> {
  final CommonDiseaseModel _model = CommonDiseaseModel();

  @override
  initState() {
    super.initState();
    _model.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModel<CommonDiseaseModel>(
        model: _model,
        child: ScopedModelDescendant<CommonDiseaseModel>(
          builder: (
            BuildContext context,
            Widget? child,
            CommonDiseaseModel model,
          ) {
            return FutureBuilder(
              future: model.commonDiseases,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final List<CommonDisease>? commonDiseases = snapshot.data;
                  if (commonDiseases == null || commonDiseases.isEmpty) {
                    return const Center(
                      child: Text('Không tìm thấy thông tin'),
                    );
                  }
                  return ListView.builder(
                    itemCount: commonDiseases.length,
                    itemBuilder: (BuildContext context, int index) {
                      final CommonDisease commonDisease = commonDiseases[index];
                      return CommonDiseaseItem(
                        request: commonDisease,
                        context: context,
                      );
                    },
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
