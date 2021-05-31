import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:touring_by/core/models/api_response.dart';
import 'package:touring_by/core/services/api_services/api_helpers.dart';

class TouringByApiService {
  var client = new http.Client();

  Future<ApiResponse> newTouringByForTour(int tourId) async {
    try {
      var response = await client.get(
        "$endpoint/touringby/start/$tourId",
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

  Future<ApiResponse> getTouringBy(int touringById) async {
    try {
      var response = await client.get(
        "$endpoint/touringby/$touringById/resume",
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

  Future<ApiResponse> finishTouringBy(int touringById) async{
    try {
      var response = await client.get(
        "$endpoint/touringby/$touringById/complete",
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

  Future<ApiResponse> curentTouringByPointForTouringBy(int touringById) async {
    try{
      var response = await client.get(
        "$endpoint/touringby/$touringById/currentpoint",
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

  Future<ApiResponse> NextTouringByPointForTouringBy(int touringById, bool skipeCurrent) async {
    try{
      var response = await client.get(
        "$endpoint/touringby/$touringById/nextpoint?skipcurrent=$skipeCurrent",
        headers: Map.fromEntries([
          acceptJsonHeader,
          await authenticationHeader
        ]),
      );
      if(response.statusCode == 200){
        return ApiResponse(success: true, body: jsonDecode(response.body));
      }
      else if(response.statusCode == 204){
        return ApiResponse(success: false, body: "No more points");
      }
      else{
        return ApiResponse(success: false, body: jsonDecode(response.body));
      }
    }
    catch (e) {
      return ApiResponse(success: false, body: e );
    }
  }

  Future<ApiResponse> likeUnlikeTouringByPoint({int touringByPointId, bool like}) async {
    try {
      if(like){
        var response = await client.get(
          "$endpoint/touringbypoint/$touringByPointId/like",
          headers: Map.fromEntries([
            acceptJsonHeader,
            await authenticationHeader
          ]),
        );
        if(response.statusCode == 200){
          return ApiResponse(success: true, body: jsonDecode(response.body));
        }
      }
      if(!like){
        var response = await client.get(
          "$endpoint/touringbypoint/$touringByPointId/unlike",
          headers: Map.fromEntries([
            acceptJsonHeader,
            await authenticationHeader
          ]),
        );
        if(response.statusCode == 200){
          return ApiResponse(success: true, body: jsonDecode(response.body));
        }
      }
    }
    catch (e){
      return ApiResponse(success: false, body: e );
    }
  }

  Future<ApiResponse> uploadImageForTouringByPoint(int touringByPointId, File image) async {
    try {
      http.MultipartFile imageFile = await http.MultipartFile.fromPath(
          'image',
          image.path
      );
      http.MultipartRequest request = http.MultipartRequest(
        'POST',
        Uri.parse("$endpoint/touringbypoint/$touringByPointId/uploadimage"),
      );
      request.headers.addAll(Map.fromEntries([
        acceptJsonHeader,
        await authenticationHeader
      ]));
      request.files.add(imageFile);

      var response = await request.send();

      if(response.statusCode == 200){
        return ApiResponse(success: true);
      }
      else{
        return ApiResponse(success: false);
      }
    }
    catch (e) {
      return ApiResponse(success: false, body: e );
    }



  }
}