import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:touring_by/core/models/api_response.dart';
import 'package:touring_by/core/services/api_services/api_helpers.dart';
import 'package:touring_by/locator.dart';

import '../device_info_service.dart';

class AuthApiService {
  var client = new http.Client();

  Future<ApiResponse> registerUser(String name, String email, String password) async {

    String deviceName = await locator<DeviceInfoService>().deviceName();

    try{
      var response = await client.post(
        "$endpoint/register?name=$name&email=$email&password=$password&device_name=$deviceName",
        headers: Map.fromEntries([acceptJsonHeader]),
      );
      if(response.statusCode == 200){
        return ApiResponse(success: true, body: jsonDecode(response.body));
      }
      else{
        return ApiResponse(success: false, body: jsonDecode(response.body));
      }
    }
    catch (e){
      return ApiResponse(success: false, body: e );

    }
  }

  Future<ApiResponse> loginUser(String email, String password) async {

    String deviceName = await locator<DeviceInfoService>().deviceName();

    try{
      var response = await client.post(
        "$endpoint/login?email=$email&password=$password&device_name=$deviceName",
        headers: Map.fromEntries([acceptJsonHeader]),
      );
      if(response.statusCode == 200){
        return ApiResponse(success: true, body: jsonDecode(response.body));
      }
      else{
        return ApiResponse(success: false, body: jsonDecode(response.body));
      }
    }
    catch (e){
      return ApiResponse(success: false, body: e );

    }
  }
}