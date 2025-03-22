import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:my_app/app/shared/mob_x/auth_controller.dart';
import 'package:my_app/app/shared/services/jwt_service.dart';
import 'dart:developer' as developer;

import 'package:my_app/app/shared/utils/general.util.dart';
import 'package:my_app/app/widgets/_manage_widget.dart';
import 'package:my_app/main.dart';

class CustomIntercetors extends InterceptorsWrapper {
  GeneralUtils utils = GeneralUtils();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var jwt = await JwtService().getTokenByAuthentication();
    if (jwt != null && jwt != "") {
      var condition = Jwt.isExpired(jwt);
      if (condition) {
        try {
          var {"token": token, "refresh": refresh} = await JwtService().refreshToken();
          await JwtService().setTokenByAuthentication(token);
          await JwtService().setRefresh(refresh);
          jwt = token;
        } catch (e) {
          developer.log('Error: Refresh Token Has Expired', error: e, name: utils.getCurrentFileName(StackTrace.current));

          AuthController lCtrl = GetIt.I<AuthController>();
          lCtrl.clearAll();
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => const ManageWidget()),
          );
          return handler.reject(
              DioException(
                requestOptions: options,
                error: 'Authentication error: Token refresh failed.',
                type: DioExceptionType.cancel,
              ),
              true);
        }
      }

      options.headers.addAll({"Authorization": 'Bearer $jwt '});
    }
    handler.next(options);
  }
}
