import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:touring_by/core/enums/index_state.dart';
import 'package:touring_by/core/models/api_response.dart';
import 'package:touring_by/core/services/api_services/api_helpers.dart';

class IndexTouringByApiService {
  var client = new http.Client();

  Future<ApiResponse> indexTouringBy(IndexState indexState, int page) async {
    String url;
    switch (indexState) {
      case IndexState.Finished:
        url = "touringby/index?completed=true&page=$page";
        break;
      case IndexState.Unfinished:
        url = "touringby/index?completed=false&page=$page";
        break;
      case IndexState.Shared:
        url = "sharedtouringby/index?page=$page";
        break;
    }
    try{
      var response = await client.get(
        "$endpoint/$url",
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