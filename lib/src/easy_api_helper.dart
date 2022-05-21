import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:easy_api/src/easy_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

abstract class ApiRequests {
  final String baseApiUrl;
  Map<String, String>? headers;

  ApiRequests({
    required this.baseApiUrl,
    headers,
  }) : headers = headers ??
            {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              "Access-Control-Allow-Origin": "*"
            };

  Client client = http.Client();

  Future<dynamic> sendGetRequest(
      {required String route, String? params}) async {
    try {
      var kParams = params ?? "";
      Uri uri = Uri.parse(baseApiUrl + route + kParams.toLowerCase());
      http.Response response = await client.get(uri, headers: headers);
      dynamic res = jsonDecode(response.body);
      return res;
    } on SocketException catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    } on FormatException catch (e) {
      debugPrint(e.toString());
      throw FormatInputException();
    } on HttpException catch (e) {
      debugPrint(e.toString());
      throw BadRequestException();
    } catch (e) {
      debugPrint(e.toString());
      throw AnonymousException();
    }
  }

  Future<dynamic> sendPostRequest(
      {required String route, required Map body}) async {
    try {
      Uri uri = Uri.parse(baseApiUrl + route);
      http.Response response =
          await client.post(uri, body: jsonEncode(body), headers: headers);
      int code = response.statusCode;
      if (code == 200 || code == 201) {
        return jsonDecode(response.body);
      } else if (code == 401) {
        throw UnauthorizedException();
      } else if (code == 500) {
        throw BadRequestException();
      } else {
        throw AnonymousException();
      }
    } on SocketException catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    } on FormatException catch (e) {
      debugPrint(e.toString());
      throw FormatInputException();
    } on HttpException catch (e) {
      debugPrint(e.toString());
      throw BadRequestException();
    }
  }

  Future<dynamic> sendPutRequest(
      {required String route, required Map body}) async {
    try {
      Uri uri = Uri.parse(baseApiUrl + route);
      http.Response response =
          await client.put(uri, body: jsonEncode(body), headers: headers);
      int code = response.statusCode;
      if (code == 401) {
        throw UnauthorizedException();
      } else if (code == 500) {
        throw BadRequestException();
      } else {
        return jsonDecode(response.body);
      }
    } on SocketException catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    } on FormatException catch (e) {
      debugPrint(e.toString());
      throw FormatInputException();
    } on HttpException catch (e) {
      debugPrint(e.toString());
      throw BadRequestException();
    } catch (e) {
      debugPrint(e.toString());
      throw AnonymousException();
    }
  }

  Future<dynamic> sendDeleteRequest(
      {required String route,
      required bool isParams,
      Map? body,
      String? params}) async {
    try {
      if (isParams) {
        String subUrl = route;
        Uri uri = Uri.parse(baseApiUrl + subUrl + params!.toLowerCase());
        http.Response response = await client.delete(uri, headers: headers);
        int code = response.statusCode;
        if (code == 401) {
          throw UnauthorizedException();
        } else if (code == 500) {
          throw BadRequestException();
        } else {
          return jsonDecode(response.body);
        }
      } else {
        String subUrl = route;
        Uri uri = Uri.parse(baseApiUrl + subUrl);
        http.Response response =
            await client.delete(uri, body: jsonEncode(body), headers: headers);
        int code = response.statusCode;
        if (code == 401) {
          throw Exception("Unauthorized");
        } else if (code == 500) {
          throw Exception("Server Error");
        } else {
          return jsonDecode(response.body);
        }
      }
    } on SocketException catch (e) {
      debugPrint(e.toString());
      throw ServerException();
    } on FormatException catch (e) {
      debugPrint(e.toString());
      throw FormatInputException();
    } on HttpException catch (e) {
      debugPrint(e.toString());
      throw BadRequestException();
    } catch (e) {
      debugPrint(e.toString());
      throw AnonymousException();
    }
  }
}
