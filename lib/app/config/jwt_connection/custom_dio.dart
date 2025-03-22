import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_app/app/config/env/enviorement.util.dart';
import 'package:my_app/app/shared/mob_x/auth_controller.dart';
import 'package:my_app/app/shared/utils/general.util.dart';
import 'custom_interceptores.dart';
import 'dart:developer' as developer;

class CustomDio {
  Dio client;

  CustomDio(this.client, bool? apiVelha, String? strAutenticacao) {
    try {
      client.interceptors.add(CustomIntercetors());
      client.options.connectTimeout = const Duration(seconds: 10);
      client.options.receiveTimeout = const Duration(seconds: 50);

      if (strAutenticacao == "acesso") {
        AuthController controllerAcesso = GetIt.I<AuthController>();
        strAutenticacao = controllerAcesso.tokenUser!;
      }

      client.options = BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        method: "post",
        contentType: 'application/json',
      );
    } catch (e) {
      developer.log(e.toString(), error: e, name: GeneralUtils().getCurrentFileName(StackTrace.current));
    }
  }
}
