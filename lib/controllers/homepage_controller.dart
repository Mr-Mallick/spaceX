import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:spacex/model/rocket_list_model.dart';

import '../network/rest_ds.dart';

class HomePageController extends GetxController {
  //In this controller we're fetching data with the help of Model
  RxBool isLoading = true.obs;

  RestDatasource api = RestDatasource();
  RxList<RocketModel> rocketList = <RocketModel>[].obs;

  getData() async {
    var response = await api.getRocketList();
    List<RocketModel> l = [];
    for (var data in response) {
      var model = RocketModel.fromJson(data);
      l.add(model);
    }
    rocketList(l);

    isLoading(false);
  }
}
