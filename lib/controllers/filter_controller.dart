import 'package:get/get.dart';
import 'package:equine_ai/pages/login/global_state_management.dart';

class FilterController extends GetxController {
  final RxSet<String> horseNames = equineProfileNames;
  var selectedHorse = ''.obs;

  Set<String> get getNames => horseNames.toSet();

  void setHorseNames(Set<String> newHorseNames) {
    horseNames.assignAll(newHorseNames);
    update();
  }

  void addHorseName(String newHorseName) {
    horseNames.add(newHorseName);
    update();
  }

  void removeHorseName(String oldHorseName) {
    horseNames.remove(oldHorseName);
    update();
  }

  void replaceHorseName(String oldHorseName, String newHorseName) {
    removeHorseName(oldHorseName);
    addHorseName(newHorseName);
    update();
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
