//import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_app/providers/generic_provider.dart';

final locator = GetIt.instance;

///Templated Code copied from YogaVillage Project
final appData = locator.get<GetStorage>();

void diSetup() {
  locator.registerSingleton<GetStorage>(GetStorage());
  locator.registerSingleton<GenericDi>(GenericDi());
}
