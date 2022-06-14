import 'package:get_it/get_it.dart';
import 'package:harithakarma/service/firestore_service.dart';

import 'Screens/Auth/auth.dart';

GetIt locator = GetIt.instance;
void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => FirestoreService());
}
