import 'package:get/get.dart';
import 'package:location/location.dart';

class StateController extends GetxController {
  var locationIsEnabled = false.obs;
  var position = LocationData.fromMap(<String, dynamic>{}).obs;

  var isLoading = false.obs;
}
