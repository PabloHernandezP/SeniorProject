import 'package:get/get.dart';

class FilterController extends GetxController {
  var horseNames = ['Horse 1', 'Horse 2', 'Horse 3'];
  var selectedHorse = ''.obs;

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
