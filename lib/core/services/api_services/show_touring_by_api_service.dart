import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:touring_by/core/models/api_response.dart';
import 'package:touring_by/core/services/api_services/api_helpers.dart';

class ShowTouringByApiService {
  var client = new http.Client();

  Future<ApiResponse> showTouringBy(int touringById) async {
    try{
      var response = await client.get(
        "$endpoint/touringby/$touringById/showtouringby",
        headers: Map.fromEntries([
          acceptJsonHeader,
          await authenticationHeader
        ]),
      );
      if(response.statusCode == 200){
        return ApiResponse(success: true, body: jsonDecode(response.body));
      }
      else{
        return ApiResponse(success: false, body: jsonDecode(response.body));
      }
    }
    catch (e) {
      return ApiResponse(success: false, body: e );
    }
  }

  Future<ApiResponse> findUserByEmail(String email) async {
    try{
      var response = await client.get(
        "$endpoint/finduserbyemail?email=$email",
        headers: Map.fromEntries([
          acceptJsonHeader,
          await authenticationHeader
        ]),
      );
      if(response.statusCode == 200){
        return ApiResponse(success: true, body: jsonDecode(response.body));
      }
      else{
        return ApiResponse(success: false, body: jsonDecode(response.body));
      }
    }
    catch (e) {
      return ApiResponse(success: false, body: e );
    }
  }

  Future<ApiResponse> shareTouringByToUser(int touringById, int userId) async {
    // try{
      var response = await client.get(
        "$endpoint/touringby/$touringById/shareto/$userId",
        headers: Map.fromEntries([
          acceptJsonHeader,
          await authenticationHeader
        ]),
      );
      if(response.statusCode == 200){
        return ApiResponse(success: true, body: null);
      }
      else{
        return ApiResponse(success: false, body: null);
      }
    // }
    // catch (e) {
    //   return ApiResponse(success: false, body: e );
    // }
  }
}