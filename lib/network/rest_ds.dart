// ignore_for_file: non_constant_identifier_names, prefer_const_declarations

import 'dart:convert';

import 'package:spacex/network/network_util.dart';

class RestDatasource {
  final NetworkUtil _netUtil = NetworkUtil();
  static final BASE_URL = "https://api.spacexdata.com/v4/rockets";

  Future<List<dynamic>> getRocketList() {
    return _netUtil
        .getNew(
      BASE_URL,
    )
        .then((res) {
      return res;
    });
  }

  Future<dynamic> getRocketInfo(String id) {
    return _netUtil
        .getNew(
      BASE_URL + "/$id",
    )
        .then((res) {
      return res;
    });
  }
}
