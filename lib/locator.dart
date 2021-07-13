import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:lifecoach_app/repository/user_repository.dart';
import 'package:lifecoach_app/services/fake_auth_service.dart';
import 'package:lifecoach_app/services/firebase_auth_service.dart';
import 'package:lifecoach_app/services/firestore_db_service.dart';

GetIt locator = GetIt();

void setupLocator() {
locator.registerLazySingleton(() => FirebaseAuthService());
locator.registerLazySingleton(() => FakeAuthenticationService());
locator.registerLazySingleton(() => FireStoreDBService());
locator.registerLazySingleton(() => Repository());
}