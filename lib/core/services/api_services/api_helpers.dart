
import 'package:touring_by/core/models/user.dart';
import 'package:touring_by/core/services/user_service.dart';
import 'package:touring_by/locator.dart';

// const endpoint = "http://10.0.2.2:8000/api";
const endpoint = "https://touring-by.herokuapp.com/api";

const MapEntry<String, String> acceptJsonHeader = MapEntry("accept",  "aplication/json");

Future<MapEntry<String, String>> get authenticationHeader async {
  String token = await locator<UserService>().getUsersToken();
  // print(token);
  return MapEntry("Authorization", "Bearer $token");
}