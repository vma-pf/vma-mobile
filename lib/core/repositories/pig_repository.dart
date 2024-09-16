import 'package:vma/core/models/pig.dart';

class PigRepository {
  Future<List<Pig>> getAllPigs() async {
    List<Pig> pigList = [
      Pig(weight: 1, name: "Pig 1"),
      Pig(weight: 2, name: "Pig 2"),
      Pig(weight: 3, name: "Pig 3"),
      Pig(weight: 4, name: "Pig 4"),
      Pig(weight: 5, name: "Pig 5"),
    ];
    return Future.value(pigList);
  }
}
