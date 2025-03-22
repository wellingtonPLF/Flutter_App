import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'dart:developer' as developer;

import 'package:my_app/app/config/jwt_connection/custom_dio.dart';
import 'package:my_app/app/shared/mapping/msg_retorno_model.dart';
import 'package:my_app/app/shared/mob_x/auth_controller.dart';
import 'package:my_app/app/shared/services/jwt_service.dart';
import 'package:my_app/app/shared/utils/general.util.dart';

class AuthService {
  AuthController controller = GetIt.I<AuthController>();
  GeneralUtils utils = GeneralUtils();

  Future<dynamic> login(Map<String, dynamic> data) async {
    CustomDio dio = CustomDio(Dio(), true, "");
    MsgRetorno msg;
    JwtService jwtService = JwtService();
    try {
      var response = await dio.client.post("/login", data: data);

      msg = MsgRetorno.fromMap(response.data);

      if (msg.status == "OK") {
        await jwtService.setTokenByAuthentication(msg.jwt);
        await jwtService.setRefresh(msg.refresh);
        controller.setCurrentUser();
      }

      return msg;
    } catch (e) {
      msg = MsgRetorno.fromMap({"status": "Autenticação Falha..."});
      if (e is DioException) {
        if (e.response != null) {
          var errorMessage = e.response?.data['error'] ?? 'Unknown server error';
          developer.log(errorMessage, name: utils.getCurrentFileName(StackTrace.current));
          return msg;
        } else {
          developer.log("${e.message}", name: utils.getCurrentFileName(StackTrace.current));
          return msg;
        }
      } else {
        return msg;
      }
    }
  }

  Future<dynamic> lembrarSenha(Map<String, dynamic> data) async {
    try {
      CustomDio dio = CustomDio(Dio(), true, "");
      MsgRetorno msg;
      var response = await dio.client.post("/resetSenha", data: data);
      msg = MsgRetorno.fromMap(response.data);
      return msg;
    } catch (e) {
      developer.log(e.toString(), error: e, name: utils.getCurrentFileName(StackTrace.current));
      return null;
    }
  }

  Future<dynamic> changeUser(Map<String, dynamic> data) async {
    try {
      CustomDio dio = CustomDio(Dio(), true, "acesso");
      await dio.client.post("/alterarUsuario", data: data);
      controller.setCurrentUser();
      return "OK";
    } catch (e) {
      developer.log(e.toString(), error: e, name: utils.getCurrentFileName(StackTrace.current));
      return;
    }
  }
}
