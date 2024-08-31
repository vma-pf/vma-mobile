class Pig {
  String name;
  int weight;

  Pig({required this.name, required this.weight});

  factory Pig.fromJson(Map<String, dynamic> json) {
    return Pig(
      name: json['name'],
      weight: json['weight'],
    );
  }
}
