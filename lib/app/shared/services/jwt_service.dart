import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_app/app/config/env/enviorement.util.dart';
import 'package:my_app/app/shared/mob_x/auth_controller.dart';
import 'package:my_app/app/shared/services/user_service.dart';
import 'dart:developer' as developer;

import 'package:my_app/app/shared/utils/general.util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JwtService {
  GeneralUtils utils = GeneralUtils();
  static String strDados = 'jwt_data';

  // AUTHENTICATION ***************************************************************************************************

  Future<Map<String, dynamic>?> getUserByToken() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      UserService userService = UserService();
      String? jwt = prefs.getString(strDados);

      if (jwt != null && jwt != "") {
        var {"user": user} = await userService.getUserByToken();
        return user;
      }
      return null;
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          var errorMessage = e.response?.data['error'] ?? 'Unknown server error';
          developer.log("Error at getUserByToken: $errorMessage", name: utils.getCurrentFileName(StackTrace.current));
        } else {
          developer.log("Error at getUserByToken: ${e.message}", name: utils.getCurrentFileName(StackTrace.current));
        }
      } else {
        developer.log("Unknown error: ${e.toString()}", name: utils.getCurrentFileName(StackTrace.current));
      }
      return null;
    }
  }

  Future<String?> getTokenByAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getString(strDados);
    } catch (e) {
      return null;
    }
  }

  Future<bool> setTokenByAuthentication(String? dados) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.setString(strDados, dados!);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getString("refresh_jwt");
    } catch (e) {
      return null;
    }
  }

  Future<bool> setRefresh(String? dados) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.setString("refresh_jwt", dados!);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      if ((prefs.getString(strDados)) == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> refreshToken() async {
    Dio dio = Dio();

    try {
      var refresh = await getRefreshToken();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      var response = await dio.post("$BASE_URL/refreshJwt", options: Options(headers: headers), data: {"refresh": refresh});

      if (response.statusCode == 201) {
        developer.log("REFRESH DONE!", name: utils.getCurrentFileName(StackTrace.current));
        return response.data;
      } else {
        developer.log('Failed to refresh JWT with status code: ${response.statusCode}', name: utils.getCurrentFileName(StackTrace.current));
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          var errorMessage = e.response?.data['error'] ?? 'Unknown server error';
          developer.log("Error At Refresh Token: $errorMessage", name: utils.getCurrentFileName(StackTrace.current));
        } else {
          developer.log("Error At Refresh Token: ${e.message}", name: utils.getCurrentFileName(StackTrace.current));
        }
      } else {
        developer.log("Unknown error: ${e.toString()}", name: utils.getCurrentFileName(StackTrace.current));
      }
    }
  }

  Future<void> logout() async {
    AuthController authController = GetIt.I<AuthController>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setString(strDados, "");
    prefs.setString("refresh_jwt", "");
    authController.islogged = false;
  }

  Future<int> getIdUsuarioCurrent() async {
    Map<String, dynamic>? user = await getUserByToken();
    return user!["id"];
  }
}
