import 'package:get_it/get_it.dart';
import 'package:touring_by/core/services/api_services/auth_api_service.dart';
import 'package:touring_by/core/services/api_services/choose_tour_api_service.dart';
import 'package:touring_by/core/services/api_services/index_touring_by_api_service.dart';
import 'package:touring_by/core/services/api_services/show_touring_by_api_service.dart';
import 'package:touring_by/core/services/api_services/touring_by_api_service.dart';
import 'package:touring_by/core/services/image_picker_service.dart';
import 'package:touring_by/core/services/local_notifications_service.dart';
import 'package:touring_by/core/services/pick_image_with_dialog_service.dart';
import 'package:touring_by/core/services/shared_preferences_service.dart';
import 'package:touring_by/core/services/user_service.dart';
import 'package:touring_by/core/services/validation_service.dart';
import 'package:touring_by/core/viewmodels/index_place_model.dart';
import 'package:touring_by/core/viewmodels/index_touring_by_model.dart';
import 'package:touring_by/core/viewmodels/logout_model.dart';
import 'package:touring_by/core/viewmodels/register_model.dart';
import 'package:touring_by/core/viewmodels/show_place_model.dart';
import 'package:touring_by/core/viewmodels/show_tour_model.dart';
import 'package:touring_by/core/viewmodels/show_touring_by_model.dart';
import 'package:touring_by/core/viewmodels/touring_by_model.dart';
import 'package:touring_by/core/viewmodels/share_touring_by_model.dart';

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
  locator.registerFactory(() =>  TouringByApiService());
  locator.registerFactory(() =>  PickImageWithDialogService());
  locator.registerFactory(() =>  ImagePickerService());
  locator.registerFactory(() =>  ShowTouringByApiService());
  locator.registerFactory(() =>  ShowTouringByModel());
  locator.registerFactory(() =>  ShareTouringByModel());
  locator.registerFactory(() =>  IndexTouringByModel());
  locator.registerFactory(() =>  IndexTouringByApiService());
  locator.registerFactory(() =>  LogoutModel());
  locator.registerSingleton<LocalNotificationsService>(LocalNotificationsService());
}