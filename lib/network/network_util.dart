// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = JsonDecoder();

  Future<dynamic> get(String url) {
    return http.get(Uri.parse(url)).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> getNew(String url,
      {Map<String, String>? headers, body, encoding}) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      responseJson = _response(response);
      log(responseJson.toString());
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url,
      {Map<String, String>? headers, body, encoding}) async {
    var responseJson;
    try {
      final response = await http.post(Uri.parse(url),
          body: body, headers: headers, encoding: encoding);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<String> postBasic(String url, Map<String, String>? body) {
    return http.post(Uri.parse(url), body: body).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        throw Exception("Error while fetching data");
      }
      return res;
    });
  }

  Future<dynamic> postNew(String url,
      {Map<String, String>? headers, body, encoding}) async {
    var responseJson;
    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> putCall(String url,
      {Map<String, String>? headers, body, encoding}) async {
    var responseJson;
    try {
      final response =
          await http.put(Uri.parse(url), headers: headers, body: body);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> putNew(String url,
      {Map<String, String>? headers, body, encoding}) async {
    var responseJson;
    try {
      final response =
          await http.put(Uri.parse(url), headers: headers, body: body);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<String> postWithHeader(
      String url, Map<String, String>? body, Map<String, String>? header) {
    return http
        .post(Uri.parse(url), body: body, headers: header)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        log("400 found");
        throw new BadRequestException(castError(response.body.toString()));
      case 401:
      case 403:
        throw UnauthorisedException(castError(response.body.toString()));
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }

  castError(String completeBody) {
    Map<String, dynamic> jsonData = jsonDecode(completeBody);
    if (jsonData['message'] != null) {
      try {
        List<dynamic> messagesBody = jsonData['message'];
        if (messagesBody.isNotEmpty) {
          var first = messagesBody.first;
          if (first['messages'] != null) {
            List<dynamic> messagesBody2 = first['messages'];
            if (messagesBody2.isNotEmpty && messagesBody2.first != null) {
              return messagesBody2.first['message'] as String;
            }
          }
        }
      } catch (e) {
        return jsonData['message'] as String;
      }
    } else if (jsonData['error'] != null) {
      return jsonData['error'] as String;
    }
    return "Something went wrong";
  }
}

class CustomException implements Exception {
  final _message;
  final _prefix;

  CustomException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
