import 'package:vma/core/models/enums/pig_status.dart';
import 'package:vma/core/models/monitoring_development_log.dart';
import 'package:vma/core/models/pig.dart';
import 'package:vma/core/models/enums/pig_health_status.dart';
import 'package:vma/core/models/pig_detail.dart';
import 'package:vma/core/models/pig_vaccination_stage.dart';
import 'package:vma/core/network/api.dart';
import 'package:vma/core/network/paginated_response.dart';

class PigRepository {
  Future<PaginatedResponse<Pig>> getAllPigs(
    int pageSize,
    int pageIndex,
  ) async {
    final query = {
      'pageSize': pageSize.toString(),
      'pageIndex': pageIndex.toString(),
    };
    final result = await ApiCaller.instance.request(
      path: '/api/Pigs',
      method: ApiMethod.get,
      queryParams: query,
    );

    PaginatedResponse<Pig> response = PaginatedResponse(
      pageIndex: 1,
      pageSize: 10,
      totalRecords: 0,
      totalPages: 0,
      data: [],
    );

    result.either((success) {
      response = PaginatedResponse.fromJson(
        success.data,
        (e) => Pig.fromJson(e),
      );
    }, (error) {
      // TODO: handle error
    });

    return Future.value(response);
  }

  Future<PigDetail?> getPigById(String id) {
    var pig = PigDetail(
      id: '1',
      breed: 'Pig 1',
      herdId: '1',
      code: 'PIG0001',
      gender: 'Male',
      status: PigStatus.alive,
      monitoringDevelopmentLogs: [
        MonitoringDevelopmentLog(
          id: '3',
          cageCode: 'CA1234',
          healthStatus: PigHealthStatus.normal,
          cageId: '1',
          weight: 10,
          height: 30,
          width: 20,
          checkupAt: DateTime.parse('2021-01-01'),
        ),
        MonitoringDevelopmentLog(
          id: '3',
          cageCode: 'CA1234',
          healthStatus: PigHealthStatus.normal,
          cageId: '1',
          weight: 30,
          height: 50,
          width: 22,
          checkupAt: DateTime.parse('2021-02-02'),
        ),
        MonitoringDevelopmentLog(
          id: '3',
          cageCode: 'CA1234',
          healthStatus: PigHealthStatus.normal,
          cageId: '1',
          weight: 70,
          height: 55,
          width: 25,
          checkupAt: DateTime.parse('2021-03-03'),
        ),
        MonitoringDevelopmentLog(
          id: '3',
          cageCode: 'CA1234',
          healthStatus: PigHealthStatus.normal,
          cageId: '1',
          weight: 50,
          height: 70,
          width: 30,
          checkupAt: DateTime.parse('2021-07-04'),
        ),
      ],
      pigVaccinationStages: [
        PigVaccinationStage(
          isDone: true,
          applyStageTime: DateTime.parse('2021-01-01'),
          vaccinationStageId: '1',
        ),
        PigVaccinationStage(
          isDone: false,
          applyStageTime: DateTime.parse('2021-02-02'),
          vaccinationStageId: '2',
        ),
        PigVaccinationStage(
          isDone: false,
          applyStageTime: DateTime.parse('2025-03-03'),
          vaccinationStageId: '3',
        ),
      ],
    );
    return Future.value(pig);
  }
}
