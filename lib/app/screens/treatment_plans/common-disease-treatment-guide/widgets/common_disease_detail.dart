import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/core/models/common_disease.dart';
import 'package:vma/core/view_models/common_disease_model.dart';

class CommonDiseaseDetail extends StatefulWidget {
  final String id;

  const CommonDiseaseDetail({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _CommonDiseaseDetailState();
}

class _CommonDiseaseDetailState extends VMAState<CommonDiseaseDetail> {
  final CommonDiseaseModel _model = CommonDiseaseModel();

  @override
  initState() {
    super.initState();
    _model.loadDataById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        width: double.infinity,
        child: ScopedModel(
          model: _model,
          child: ScopedModelDescendant<CommonDiseaseModel>(
            builder: (
              BuildContext context,
              Widget? child,
              CommonDiseaseModel model,
            ) {
              return FutureBuilder(
                future: model.commonDisease,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<CommonDisease?> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final CommonDisease? data = snapshot.data;
                    if (data == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title ?? '',
                            style: TextStyle(
                              fontSize: 28, // Font size for title
                              fontWeight: FontWeight.bold, // Bold for the title
                            ),
                          ),
                          SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Mức độ: ',
                                  style: TextStyle(
                                    fontSize: 16, // Font size
                                    fontWeight:
                                        FontWeight.bold, // Bold for "Điều trị"
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: data.diseaseType ?? '',
                                  style: TextStyle(
                                    fontSize: 16, // Font size for the treatment
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8), // Spacing between elements
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Mô tả: ',
                                  style: TextStyle(
                                    fontSize: 16, // Font size
                                    fontWeight:
                                        FontWeight.bold, // Bold for "Mô tả"
                                    color:
                                        Colors.black, // Ensure text is visible
                                  ),
                                ),
                                TextSpan(
                                  text: data.description ?? '',
                                  style: TextStyle(
                                    fontSize:
                                        16, // Font size for the description
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Triệu chứng: ',
                                  style: TextStyle(
                                    fontSize: 16, // Font size
                                    fontWeight: FontWeight
                                        .bold, // Bold for "Triệu chứng"
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: data.symptom ?? '',
                                  style: TextStyle(
                                    fontSize: 16, // Font size for the symptom
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Điều trị: ',
                                  style: TextStyle(
                                    fontSize: 16, // Font size
                                    fontWeight:
                                        FontWeight.bold, // Bold for "Điều trị"
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: data.treatment ?? '',
                                  style: TextStyle(
                                    fontSize: 16, // Font size for the treatment
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
