import 'package:accordion/accordion.dart';
import 'package:flutter/cupertino.dart';
import 'package:vma/app/screens/vaccination_plan_details/widgets/vaccination_stage_detail.dart';
import 'package:vma/core/models/vaccination_stage.dart';
import 'package:vma/core/utils/date_time_helper.dart';

class VaccinationStages extends StatelessWidget {
  final List<VaccinationStage> vaccinationStages;
  const VaccinationStages({super.key, required this.vaccinationStages});

  List<VaccinationStage> sortStages() {
    return vaccinationStages
      ..sort((a, b) => a.applyStageTime.compareTo(b.applyStageTime));
  }

  @override
  Widget build(BuildContext context) {
    final sortedStages = sortStages();

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: vaccinationStages.length,
      itemBuilder: (BuildContext context, int index) {
        final stage = sortedStages[index];

        return Accordion(
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
              content: VaccinationStageDetail(vaccinationStage: stage),
            ),
          ],
        );
      },
    );
  }
}
