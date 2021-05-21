import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:touring_by/core/models/api_response.dart';
import 'package:touring_by/core/services/api_services/api_helpers.dart';


class GetModelApiService {
  var client = new http.Client();

  Future<ApiResponse> getPlacesForPage(int page) async {
    try {
      var response = await client.get(
        "$endpoint/places?page=$page",
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

  Future<ApiResponse> getToursForPlace(int placeId) async {
    try{
      var response = await client.get(
        "$endpoint/places/$placeId",
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

  // TODO implement pagination
  Future<ApiResponse> getPointsForTourForPage(int tourId, int page) async {
    try{
      var response = await client.get(
        "$endpoint/tours/$tourId?page=$page",
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

}