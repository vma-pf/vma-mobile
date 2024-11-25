import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:vma/app/common/vma_state.dart';
import 'package:vma/app/screens/warnings/widgets/text_row.dart';
import 'package:vma/app/widgets/full_screen_image.dart';
import 'package:vma/core/models/abnormality.dart';
import 'package:vma/core/utils/date_time_helper.dart';
import 'package:vma/core/view_models/abnormality_model.dart';

class AbnormalityDetail extends StatefulWidget {
  final String abnormalityId;

  const AbnormalityDetail({super.key, required this.abnormalityId});

  @override
  State<StatefulWidget> createState() => _AbnormalityDetailState();
}

class _AbnormalityDetailState extends VMAState<AbnormalityDetail> {
  final _model = AbnormalityModel();

  @override
  void initState() {
    super.initState();
    _model.loadAbnormality(widget.abnormalityId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Color(0xFFFFC1C1),
        color: Colors.red.withOpacity(0.9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
          width: double.infinity,
          child: ScopedModel(
            model: _model,
            child: ScopedModelDescendant<AbnormalityModel>(
              builder: (
                BuildContext context,
                Widget? child,
                AbnormalityModel model,
              ) {
                return FutureBuilder(
                  future: model.abnormality,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<Abnormality?> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else {
                      final Abnormality? abnormality = snapshot.data;
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (abnormality == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.exclamationmark_triangle_fill,
                                  size: 40,
                                  color: Color(0xFFFFF8E1),
                                ),
                                const SizedBox(width: 12),
                                Flexible(
                                  child: Text(
                                    abnormality.title,
                                    style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            TextRow(
                              text: 'Mã chuồng: ',
                              value: abnormality.cageCode,
                            ),
                            TextRow(
                              text: 'Loại cảnh báo: ',
                              value: abnormality.abnormalityType,
                            ),
                            TextRow(
                              text: 'Mô tả: ',
                              value: abnormality.description,
                            ),
                            TextRow(
                              text: 'Thời gian: ',
                              value: DateTimeHelper.getFormattedDateTime(
                                abnormality.createdAt,
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FullScreenImage(
                                      imageUrl: abnormality.imageUrl,
                                    ),
                                  ),
                                );
                              },
                              child: Image.network(
                                abnormality.imageUrl,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        );
                      }

                      return const Text('Không tìm thấy thông tin');
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
