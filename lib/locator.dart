import 'package:get_it/get_it.dart';
import 'package:touring_by/core/services/api_services/auth_api_service.dart';
import 'package:touring_by/core/services/api_services/get_model_api_service.dart';
import 'package:touring_by/core/services/shared_preferences_service.dart';
import 'package:touring_by/core/services/user_service.dart';
import 'package:touring_by/core/services/validation_service.dart';
import 'package:touring_by/core/viewmodels/index_place_model.dart';
import 'package:touring_by/core/viewmodels/register_model.dart';
import 'package:touring_by/core/viewmodels/show_place_model.dart';
import 'package:touring_by/core/viewmodels/show_tour_model.dart';
import 'package:touring_by/core/viewmodels/touring_by_model.dart';

import 'core/services/device_info_service.dart';
import 'core/viewmodels/login_model.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerFactory(() =>  RegisterModel());
  locator.registerFactory(() =>  LoginModel());
  locator.registerFactory(() =>  ValidationService());
  locator.registerFactory(() =>  AuthApiService());
  locator.registerFactory(() =>  DeviceInfoService());
  locator.registerFactory(() =>  SharedPreferencesService());
  locator.registerLazySingleton(() =>  UserService());
  locator.registerFactory(() =>  GetModelApiService());
  locator.registerFactory(() =>  IndexPlaceModel());
  locator.registerFactory(() =>  ShowPlaceModel());
  locator.registerFactory(() =>  ShowTourModel());
  locator.registerFactory(() =>  TouringByModel());
}