import 'dart:async';
import 'dart:async';

import 'package:aaishani_store_user_app/models/ModelCommonResponse.dart';
import 'package:aaishani_store_user_app/models/ModelOrderHistory.dart';
import 'package:aaishani_store_user_app/models/Model_Login.dart';
import 'package:aaishani_store_user_app/models/Model_MobileVerification.dart';
import 'package:aaishani_store_user_app/models/Model_UserData.dart';
import 'package:aaishani_store_user_app/models/Model_UserRegistration.dart';
import 'package:aaishani_store_user_app/models/ServicesModel.dart';
import 'package:aaishani_store_user_app/models/model_album.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiProvider {
  final storage = FlutterSecureStorage();

  Future<List<Model_Album>> get_album_data() async {
    final response = await http.get(
        "https://jsonplaceholder.typicode.com/photos",
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      List<Model_Album> modelAlbulList = json
          .decode(response.body)
          .map((x) => Model_Album.fromJson(x))
          .toList()
          .cast<Model_Album>();
      return modelAlbulList;
    } else {
      throw Exception('Failed to get album data');
    }
  }

  // API for getting services 

  Future<ServicesModel> getServices() async
  {
    var token = await storage.read(key: 'token');
    final response = await http.get("https://limitless-oasis-41478.herokuapp.com/api/services/get_services"
    );
    print(response.body);
    ServicesModel servicesModel = ServicesModel.fromJson(json.decode(response.body),response.statusCode.toString());
    return servicesModel;
  }

  Future<Model_Login> requestLogin(userName, password) async {
    final response = await http.post(
        "https://limitless-oasis-41478.herokuapp.com/api/users/login",
        body: {'contact': userName, 'password': password});

    Model_Login modelLogin = Model_Login.fromJson(
        json.decode(response.body), response.statusCode.toString());
    return modelLogin;
  }

  Future<Model_UserRegistration> requestUserRegistration(
      name, contact, email, password) async {
    final response = await http.post(
        "https://limitless-oasis-41478.herokuapp.com/api/users/register",
        body: {
          'name': name,
          'contact': contact,
          'email': email,
          'password': password,
        });

    Model_UserRegistration modelUserRegistration =
        Model_UserRegistration.fromJson(
            json.decode(response.body), response.statusCode.toString());
    return modelUserRegistration;
  }

  Future<Model_MobileVerification> requestMobileVerification(
      contact, otp, flag) async {
    final response = await http.post(
        "https://limitless-oasis-41478.herokuapp.com/api/users/verify_otp",
        body: {
          'contact': contact,
          'otp': otp,
          'flag': flag,
        });

    Model_MobileVerification modelMobileVerification =
        Model_MobileVerification.fromJson(
            json.decode(response.body), response.statusCode.toString());
    return modelMobileVerification;
  }

  Future<ModelOrderHistory> requestOrderHistory() async {
    var token = await storage.read(key: "token");
    final response = await http.get(
        "https://limitless-oasis-41478.herokuapp.com/api/users/get_order_history",
        headers: {"Authorization": "Bearer " + token});
    ModelOrderHistory modelOrderHistory = ModelOrderHistory.fromJson(
        json.decode(response.body), response.statusCode.toString());
    return modelOrderHistory;
  }

  Future<ModelCommonResponse> updateFCM(fcmToken) async {
    var token = await storage.read(key: "token");
    final response = await http.post(
        "https://limitless-oasis-41478.herokuapp.com/api/users/update_fcm_token",
        body: {'fcm_token': fcmToken},
        headers: {"Authorization": "Bearer " + token});

    ModelCommonResponse modelCommonResponse = ModelCommonResponse.fromJson(
        json.decode(response.body), response.statusCode.toString());
    return modelCommonResponse;
  }

  Future<ModelUserData> getUserData() async {
    final response = await http.get(
        "https://limitless-oasis-41478.herokuapp.com/api/users/get_user_data");

    ModelUserData modelUserData = ModelUserData.fromJson(
      json.decode(response.body),response.statusCode.toString()
    );
    return modelUserData;
  }
}
