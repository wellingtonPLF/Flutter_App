import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'dart:developer' as developer;

import 'package:my_app/app/config/jwt_connection/custom_dio.dart';
import 'package:my_app/app/shared/mob_x/auth_controller.dart';
import 'package:my_app/app/shared/utils/general.util.dart';

class UserService {
  AuthController controller = GetIt.I<AuthController>();

  Future<dynamic> getUserByToken() async {
    CustomDio myDio = CustomDio(Dio(), true, "");

    try {
      var response = await myDio.client.get("/getUser");
      return response.data;
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          var errorMessage = e.response?.data['error'] ?? 'Unknown server error';
          developer.log("Error at getUserByToken: $errorMessage", name: GeneralUtils().getCurrentFileName(StackTrace.current));
        } else {
          developer.log("Error at getUserByToken: ${e.message}", name: GeneralUtils().getCurrentFileName(StackTrace.current));
        }
      } else {
        developer.log("Unknown error: ${e.toString()}", name: GeneralUtils().getCurrentFileName(StackTrace.current));
      }
      return null;
    }
  }
}
