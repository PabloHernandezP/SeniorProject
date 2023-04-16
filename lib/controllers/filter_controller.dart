import 'package:get/get.dart';
import 'package:equine_ai/controllers/global_state_management.dart';

final authService = Get.find<AuthController>();

class FilterController extends GetxController {
  final RxSet<String> horseNames = authService.equineProfileNames;
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
