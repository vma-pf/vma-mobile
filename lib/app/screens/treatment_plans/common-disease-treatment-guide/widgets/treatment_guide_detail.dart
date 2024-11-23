import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/core/models/treatment_guide.dart';
import 'package:vma/core/utils/string_helper.dart';
import 'package:vma/core/view_models/treatment_guide_model.dart';

class TreatmentGuideDetail extends StatefulWidget {
  final String id;

  const TreatmentGuideDetail({super.key, required this.id});

  @override
  State<StatefulWidget> createState() => _TreatmentGuideDetailState();
}

class _TreatmentGuideDetailState extends VMAState<TreatmentGuideDetail> {
  final TreatmentGuideModel _model = TreatmentGuideModel();

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
          child: ScopedModelDescendant<TreatmentGuideModel>(
            builder: (
              BuildContext context,
              Widget? child,
              TreatmentGuideModel model,
            ) {
              return FutureBuilder(
                future: model.treatmentGuide,
                builder: (BuildContext context,
                    AsyncSnapshot<TreatmentGuide?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final TreatmentGuide? data = snapshot.data;
                    if (data == null) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringHelper.resolveNullableString(
                              data.diseaseTitle, 'Không có tiêu đề'),
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
                                text: 'Người tạo: ',
                                style: TextStyle(
                                  fontSize: 16, // Font size
                                  fontWeight:
                                      FontWeight.bold, // Bold for "Tên tác giả"
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: StringHelper.resolveNullableString(
                                  data.authorName,
                                  'Không rõ',
                                ),
                                style: TextStyle(
                                  fontSize: 16, // Font size for the author name
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
                                text: 'Mức độ: ',
                                style: TextStyle(
                                  fontSize: 16, // Font size
                                  fontWeight:
                                      FontWeight.bold, // Bold for "Mức độ"
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: data.diseaseType ?? '',
                                style: TextStyle(
                                  fontSize:
                                      16, // Font size for the disease type
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
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: data.diseaseDescription ?? '',
                                style: TextStyle(
                                  fontSize: 16, // Font size for the description
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
                                  fontWeight:
                                      FontWeight.bold, // Bold for "Triệu chứng"
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: data.diseaseSymptoms ?? '',
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
                                text: data.cure ?? '',
                                style: TextStyle(
                                  fontSize: 16, // Font size for the treatment
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
