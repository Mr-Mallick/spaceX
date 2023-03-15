import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:spacex/network/rest_ds.dart';

class RocketInfoController extends GetxController {
  // -->In this Controller we're fetching data without the help of model

  RxBool isLoading = true.obs;
  RestDatasource api = RestDatasource();
  RxString name = "".obs;
  RxList images = [].obs;
  RxString activeStatus = ''.obs;
  RxString cpl = ''.obs;
  RxString sucessPercentage = ''.obs;
  RxString desc = "".obs;
  RxString heightInM = ''.obs;
  RxString heightInFeet = ''.obs;
  RxString diameterInM = ''.obs;
  RxString diameterInFeet = ''.obs;
  RxString url = ''.obs;

  getData(String id) async {
    //Function for calling api
    var response = await api.getRocketInfo(id); //api call

    //Assigning values
    name(response['name']);
    images(response['flickr_images']);
    activeStatus(response['active'].toString());
    cpl(response['cost_per_launch'].toString());
    sucessPercentage(response['success_rate_pct'].toString());
    desc(response['description']);
    heightInM(response['height']['meters'].toString());
    heightInFeet(response['height']['feet'].toString());
    diameterInM(response['diameter']['meters'].toString());
    diameterInFeet(response['diameter']['feet'].toString());
    url(response['wikipedia']);
    isLoading(false);
  }
}
