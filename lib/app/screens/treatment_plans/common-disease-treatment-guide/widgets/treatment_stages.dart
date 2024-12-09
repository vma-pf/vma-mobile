import 'package:accordion/accordion.dart';
import 'package:flutter/cupertino.dart';
import 'package:vma/app/screens/treatment_plans/common-disease-treatment-guide/widgets/treatment_stage_detail.dart';
import 'package:vma/core/models/treatment_stage.dart';
import 'package:vma/core/utils/date_time_helper.dart';

class TreatmentStages extends StatelessWidget {
  final List<TreatmentStage> treatmentStages;
  const TreatmentStages({super.key, required this.treatmentStages});

  List<TreatmentStage> sortStages() {
    return treatmentStages
      ..sort(
        (current, next) =>
            current.applyStageTime.compareTo(next.applyStageTime),
      );
  }

  @override
  Widget build(BuildContext context) {
    final sortedStages = sortStages();

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: treatmentStages.length,
      itemBuilder: (BuildContext context, int index) {
        final TreatmentStage stage = sortedStages[index];

        return Accordion(
          disableScrolling: true,
          children: [
            AccordionSection(
              header: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(
                        stage.title,
                        style: const TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Text(
                      DateTimeHelper.getFormattedDate(stage.applyStageTime),
                      style: const TextStyle(
                        fontSize: 12,
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              content: TreatmentStageDetail(treatmentStage: stage),
            ),
          ],
        );
      },
    );
  }
}
