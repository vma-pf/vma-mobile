class VaccinationSchedule {
  final String id;
  final String title;
  final DateTime start;
  final DateTime end;
  final bool isDone;
  final int type;

  VaccinationSchedule({
    required this.id,
    required this.title,
    required this.start,
    required this.end,
    required this.isDone,
    required this.type,
  });

  factory VaccinationSchedule.fromJson(Map<String, dynamic> json) {
    return VaccinationSchedule(
      id: json['id'],
      title: json['title'],
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
      isDone: json['isDone'],
      type: json['type'],
    );
  }
}
