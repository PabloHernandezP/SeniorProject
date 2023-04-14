import 'package:get/get.dart';

class FilterController extends GetxController {
  final RxList<String> horseNames = <String>[].obs;
  var selectedHorse = ''.obs;

  List<String> get getNames => horseNames.toList();

  void setHorseNames(List<String> newHorseNames) {
    horseNames.assignAll(newHorseNames);
  }

  void addHorseName(String newHorseName) {
    horseNames.add(newHorseName);
  }

  void removeHorseName(String oldHorseName) {
    horseNames.remove(oldHorseName);
  }

  void replaceHorseName(String oldHorseName, String newHorseName) {
    removeHorseName(oldHorseName);
    addHorseName(newHorseName);
  }

  void setSelectedHorse(String value) {
    selectedHorse.value = value;
    update();
  }

  String? getSelectedHorse() {
    if (selectedHorse.value.isEmpty) {
      return null;
    } else {
      return selectedHorse.value;
    }
  }
}
