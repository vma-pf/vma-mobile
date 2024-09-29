import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/pig_detail/widgets/detail_info.dart';
import 'package:vma/core/view_models/pig_detail_model.dart';

class PigDetail extends StatefulWidget {
  final String pigId;
  const PigDetail({super.key, required this.pigId});

  @override
  State<PigDetail> createState() => _PigDetailState();
}

class _PigDetailState extends VMAState<PigDetail> {
  final PigDetailModel _model = PigDetailModel();

  @override
  void initState() {
    super.initState();
    _model.loadPig(widget.pigId);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PigDetailModel>(
      model: _model,
      child: ScopedModelDescendant<PigDetailModel>(
        builder: (BuildContext context, Widget? child, PigDetailModel model) {
          return FutureBuilder(
            future: model.pig,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final pig = snapshot.data;
                if (pig == null) {
                  return const Center(child: Text('Không tìm thấy thông tin'));
                }
                return DetailInfo(pigDetail: pig);
              }
            },
          );
        },
      ),
    );
  }
}
