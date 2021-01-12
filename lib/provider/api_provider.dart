import 'dart:convert';

import 'package:ecom/model/api_model.dart';
import 'package:ecom/model/login_result.dart';
import 'package:ecom/model/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class ApiProvider {
  static final ApiProvider _instance = ApiProvider._internal();
  ApiProvider._internal();
  static ApiProvider get instance => _instance;

  final loginResultStorageKey = '__login_result';
  User user;
  String _token;

  Future<ApiModel> login(String email, String password) async {
    final url = 'http://localhost:8000/api/login';
    final params = {'email': email, 'password': password};
    final response = await post(url, body: params);
    if (response.statusCode != 200) {
      print('[login] Error while connecting to the server.');
      return ApiModel(false, 'Error while connecting to the server.', null);
    }

    final responseBodyJson = jsonDecode(response.body);
    final apiResult = ApiModel.fromJson(responseBodyJson);
    if (!apiResult.success) {
      print('[login] ' + apiResult.message);
      return ApiModel(false, apiResult.message, null);
    }

    final loginResult = LoginResult.fromJson(apiResult.data);
    user = loginResult.user;
    _token = loginResult.token;
    print('Login sucess: user = ' + user.name + ', token: $_token');
    // Store user info and token for later launch
    final secureStorage = FlutterSecureStorage();
    await secureStorage.write(
        key: loginResultStorageKey, value: loginResult.toJson().toString());

    return apiResult;
  }

  Future<User> loadCurrentUser() async {
    final url = 'http://localhost:8000/api/me';
    final requestHeaders = {'Authorization': 'Bearer $_token'};
    final response = await get(url, headers: requestHeaders);

    if (response.statusCode != 200) {
      print('[loadCurrentUser] Error while connecting to the server.');
      return null;
    }

    final responseBodyJson = jsonDecode(response.body);
    final apiResult = ApiModel.fromJson(responseBodyJson);
    if (!apiResult.success) {
      print('[loadCurrentUser] ' + apiResult.message);
      return null;
    }

    return User.fromJson(apiResult.data);
  }

  Future<void> readLoggedResult() async {
    final secureStorage = FlutterSecureStorage();
    final loginResultString =
        await secureStorage.read(key: loginResultStorageKey);
    if (loginResultString == null) {
      return;
    }
    final loginResultJson = jsonDecode(loginResultString);
    final loginResult = LoginResult.fromJson(loginResultJson);
    user = loginResult.user;
    _token = loginResult.token;
  }

  void logout() {
    user = null;
    _token = null;
  }
}
