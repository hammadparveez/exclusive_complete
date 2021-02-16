import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixvalley_ui_kit/data/model/body/login_model.dart';
import 'package:sixvalley_ui_kit/data/model/body/register_model.dart';
import 'package:sixvalley_ui_kit/data/model/body/user_model.dart';
import 'package:sixvalley_ui_kit/utill/app_constants.dart';

class AuthRepo {
  final SharedPreferences sharedPreferences;
  AuthRepo({@required this.sharedPreferences});

  sharedPreferencesx() async {}

  // for  user token
  Future<void> saveUserToken(String token) async {
    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      throw e;
    }
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> clearSharedData() async {
    sharedPreferences.remove(AppConstants.CART_LIST);
    sharedPreferences.remove(AppConstants.CURRENCY);
    return sharedPreferences.remove(AppConstants.TOKEN);
  }

  Future<bool> signOut() async {
    final isEmailRemoved =
        await sharedPreferences.remove(AppConstants.USER_EMAIL);
    final iDisplayNameRemoved =
        await sharedPreferences.remove(AppConstants.USER_DISPLAY_NAME);
    final isTokenRemoved = await sharedPreferences.remove(AppConstants.TOKEN);
    final isUserID = await sharedPreferences.remove(AppConstants.WP_USER_ID);
    final cart = await sharedPreferences.remove(AppConstants.CART_LIST);
    final jwtToken = await sharedPreferences.remove(AppConstants.JWT_TOKEN_KEY);

    print("User id Cleared $isUserID and ${cart}");

    return isTokenRemoved == isEmailRemoved;
  }

  // for  Remember Email
  Future<void> saveUserEmailAndPassword(String email, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
      await sharedPreferences.setString(AppConstants.USER_EMAIL, email);
    } catch (e) {
      throw e;
    }
  }

  String getUserEmail() {
    final anEmail = sharedPreferences.getString(AppConstants.USER_EMAIL) ?? "";
    return anEmail;
  }

  String getUserDisplayName() {
    final anEmail =
        sharedPreferences.getString(AppConstants.USER_DISPLAY_NAME) ?? "Guest";
    return anEmail;
  }

  int getUserID() {
    if (sharedPreferences.containsKey(AppConstants.WP_USER_ID)) {
      final userID = sharedPreferences.getInt(AppConstants.WP_USER_ID);
      print("Access User ID $userID");
      return userID;
    } else {
      return null;
      //throw AssertionError("ID doesn't exists");
    }
  }

  Future<void> saveUserEmail(String email) async {
    final exmailAdded =
        await sharedPreferences.setString(AppConstants.USER_EMAIL, email);
    print("User email Address Saved? $exmailAdded}");
    print(
        "user email address is : ${sharedPreferences.get(AppConstants.USER_EMAIL)}");
  }

  Future<void> saveDisplayName(String displayName) async {
    await sharedPreferences.setString(
        AppConstants.USER_DISPLAY_NAME, displayName);
  }

  Future<void> saveUserId(int userId) async {
    print("My User ID SavUserID $userId");
    await sharedPreferences.setInt(AppConstants.WP_USER_ID, userId);
  }

  String getUserPassword() {
    return sharedPreferences.getString(AppConstants.USER_PASSWORD) ?? "";
  }

  Future<bool> clearUserEmailAndPassword() async {
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    return await sharedPreferences.remove(AppConstants.USER_EMAIL);
  }

  Future<UserModel> login(LoginModel loginModel) async {
    print(
        "Display me Use Email ${loginModel.email} amd asswprd ${loginModel.password}");
    final response = await post(AppConstants.WP_LOGIN_URI, body: {
      "username": loginModel.email,
      "password": loginModel.password,
    });
    final jwt_response = await post(AppConstants.WP_JWT_URI, body: {
      "username": loginModel.email,
      "password": loginModel.password,
    });

    print("Try to check JWT ${jwt_response.body} and ");
    if (response.statusCode == 200) {
      print("Response body : ${response.body}");
      if (jwt_response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final jwtData = jsonDecode(jwt_response.body);
        print("Data is ${data["data"]["ID"]}");
        if (data["data"]["ID"] != null && jwtData["token"] != null) {
          sharedPreferences.setString(
              AppConstants.JWT_TOKEN_KEY, jwtData["token"]);
          print("Shared Perfenct token ${jwtData["token"]}");
          return UserModel.fromJson(data);
        } else {
          print("Token was null");
          return null;
        }
      } else {
        throw Exception("Something went wrong");
      }
    } else {
      return null;
    }
  }

  Future<UserModel> register(RegisterModel registerModel) async {
    final response = await post(AppConstants.WP_REGISTER_URI, body: {
      "username": registerModel.userName,
      "email": registerModel.email,
      "password": registerModel.password,
      "first_name": registerModel.fName,
      "last_name": registerModel.lName,
    });

    print("Body Of Response ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      final jwt_response = await post(AppConstants.WP_JWT_URI, body: {
        "username": registerModel.email,
        "password": registerModel.password,
      });
      if (jwt_response.statusCode == 200 || jwt_response.statusCode == 201) {
        print("Response body : ${response.body}");
        final data = await jsonDecode(response.body);
        final jsonData = await jsonDecode(jwt_response.body);
        print("New Token JSON $jsonData");
        if (data["id"] != null && jsonData["token"] != null) {
          sharedPreferences.setString(
              AppConstants.JWT_TOKEN_KEY, jsonData["token"]);
          print("Shared Perfenct token ${jsonData["token"]}");
          final registerModel = RegisterModel.fromJson(data);
          print(
              "${registerModel.fName} lastName ${registerModel.lName} and email ${registerModel.email}");
          return UserModel(
              id: data["id"],
              display_name: "${registerModel.fName} ${registerModel.lName}",
              user_email: registerModel.email,
              user_nicename: data["nickname"]);
        }
      } else {
        throw Exception("Something went wrong");
      }
    }
    return null;
  }
}
