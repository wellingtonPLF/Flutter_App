import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:my_app/app/shared/mapping/msg_retorno_model.dart';
import 'package:my_app/app/shared/models/users_model.dart';
import 'package:my_app/app/shared/services/auth_service.dart';
import 'package:my_app/app/shared/services/jwt_service.dart';
import 'package:my_app/app/shared/utils/general.util.dart';
import 'dart:developer' as developer;

import 'package:my_app/app/widgets/default_widgets.dart';

part 'auth_controller.g.dart';

class AuthController = AuthControllerBase with _$AuthController;

abstract class AuthControllerBase with Store {
  StandardWidgets wp = StandardWidgets();
  GeneralUtils utils = GeneralUtils();

  @observable
  bool? isLoading = false;

  @observable
  bool? islogged = false;

  @observable
  String? tokenUser;

  @observable
  UserModel? currentUser;

  @observable
  String? confirmPassword = "";

  @observable
  String? msg = "";

  @observable
  bool? passwordVisible = false;

  @observable
  XFile? imageFile;

  // Actions ********************************************************

  @action
  void setImageFile(XFile? value) => imageFile = value;

  @action
  void setId(int? value) {
    if (currentUser != null) {
      currentUser!.id = value;
    }
  }

  @action
  void setUserName(String? value) {
    if (currentUser != null) {
      currentUser!.username = value;
    }
  }

  @action
  void setName(String? value) {
    if (currentUser != null) {
      currentUser!.name = value;
    }
  }

  @action
  void setPhone(String? value) {
    if (currentUser != null) {
      currentUser!.phone = value;
    }
  }

  @action
  void setPassword(String password) {
    if (currentUser != null) {
      currentUser!.password = password;
    }
  }

  @action
  void setEmail(String email) {
    if (currentUser != null) {
      currentUser!.email = email;
    }
  }

  @action
  Future<bool?> getIsLogged() async {
    return islogged;
  }

  @action
  setIslogged(bool? value) => islogged = value;

  @action
  setIsLoading(bool? value) => isLoading = value;

  @action
  setTokenUser(String? value) => tokenUser = value;

  @action
  setCurrentUser() async {
    var value = await JwtService().getUserByToken();
    if (value == null) {
      currentUser = UserModel();
      setIslogged(false);
    } else {
      currentUser = UserModel();
      currentUser!.id = value["id"];
      currentUser!.email = value["email"];
      currentUser!.phone = value["phone"];
      currentUser!.password = value["password"];
      currentUser!.username = value["username"];
      currentUser!.name = value["fullName"];
      currentUser!.imagem = value["image"];

      var token = await JwtService().getTokenByAuthentication();
      if (token != null) {
        setTokenUser(token);
      }
      setIslogged(true);
    }
  }

  @action
  void setConfirmPassword(String value) => confirmPassword = value;

  @action
  void setMsg(String value) => msg = value;

  @action
  void togglePasswordVisibility() => passwordVisible = passwordVisible;

  @computed
  bool? get isPasswordValid => currentUser!.password!.length >= 6;

  @computed
  bool? get isEmailValid => RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(currentUser!.email!);

  @computed
  Function? get loginPressed => (isEmailValid! && isPasswordValid! && !isLoading!) ? login : null;

  @action
  Future<void> login(BuildContext context) async {
    await clearAll();

    if (currentUser!.email == null || currentUser!.email!.isEmpty) {
      wp.showMessage("Informe seu Email.", Colors.red);
      return;
    }

    if (currentUser!.password == null || currentUser!.password!.isEmpty) {
      wp.showMessage("Informe sua senha.", Colors.red);
      return;
    }

    try {
      isLoading = true;
      AuthService repo = AuthService();
      Map<String, dynamic> dados = {
        "email": currentUser!.email!.trim(),
        "password": currentUser!.password,
      };

      MsgRetorno msg = await repo.login(dados);
      if (msg.status == "OK") {
        currentUser!.email = "";
        currentUser!.password = "";
        islogged = true;
        wp.showMessage("Login Efetuado com Sucesso!", Colors.lightGreen);
        if (context.mounted) {
          await Navigator.pushReplacementNamed(context, '/');
        }
      } else {
        wp.showMessage(msg.message!, Colors.red);
      }

      isLoading = false;
      return;
    } catch (e) {
      wp.showMessage("Falha de conexão!", Colors.red);
      developer.log(e.toString(), error: e, name: utils.getCurrentFileName(StackTrace.current));
      isLoading = false;
      return;
    }
  }

  @action
  Future<void> lembrarSenha(BuildContext context) async {
    if (currentUser!.email == null || currentUser!.email!.isEmpty) {
      wp.showMessage("Informe seu Email.", Colors.red);
      return;
    }

    try {
      isLoading = true;
      AuthService repo = AuthService();
      Map<String, dynamic> dados = {
        "email": currentUser!.email!.trim(),
      };
      MsgRetorno msg = await repo.lembrarSenha(dados);
      if (msg.status == "OK") {
        currentUser!.password = "";
        islogged = false;
        wp.showMessage(msg.message!, Colors.lightGreen);
      } else {
        wp.showMessage(msg.message!, Colors.red);
      }
      isLoading = false;
      return;
    } catch (e) {
      wp.showMessage(e.toString(), Colors.red);
      developer.log(e.toString(), error: e, name: utils.getCurrentFileName(StackTrace.current));
      isLoading = false;
      return;
    }
  }

  @action
  Future<bool> validaCreateUser(BuildContext context) async {
    if (currentUser!.name == null || currentUser!.name!.isEmpty) {
      wp.showMessage("Informe seu Nome.", Colors.red);
      return false;
    }

    if (currentUser!.phone == null || currentUser!.phone!.isEmpty) {
      wp.showMessage("Informe seu phone.", Colors.red);
      return false;
    }
    if (currentUser!.username == null || currentUser!.username!.isEmpty) {
      wp.showMessage("Informe seu Apelido.", Colors.red);
      return false;
    }
    if (currentUser!.email == null || currentUser!.email!.isEmpty) {
      wp.showMessage("Informe seu Email.", Colors.red);
      return false;
    }

    if (!RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(currentUser!.email!.toLowerCase().trim())) {
      wp.showMessage("Informe um email válido.", Colors.red);
      return false;
    }

    if (currentUser!.password == null || currentUser!.password!.isEmpty) {
      wp.showMessage("Informe sua senha.", Colors.red);
      return false;
    }

    if (currentUser!.password != confirmPassword) {
      wp.showMessage("Senha e Confirmação de senha não conferem.", Colors.red);
      return false;
    }

    return true;
  }

  @action
  Future<bool> validaChangeUser(BuildContext context) async {
    if (currentUser!.name == null || currentUser!.name!.isEmpty) {
      wp.showMessage("Informe seu Nome.", Colors.red);
      return false;
    }
    if (currentUser!.phone == null || currentUser!.phone!.isEmpty) {
      wp.showMessage("Informe seu phone.", Colors.red);
      return false;
    }
    if (currentUser!.username == null || currentUser!.username!.isEmpty) {
      wp.showMessage("Informe seu Apelido.", Colors.red);
      return false;
    }

    if (currentUser!.password != confirmPassword) {
      wp.showMessage("Senha e Confirmação de senha não conferem.", Colors.red);
      return false;
    }

    return true;
  }

  @action
  Future<void> changeUser(BuildContext context) async {
    isLoading = true;
    confirmPassword = (confirmPassword != "") ? confirmPassword : null;
    currentUser!.password = (currentUser!.password != "") ? currentUser!.password : null;
    AuthService repo = AuthService();
    Map<String, dynamic> dados = {
      "id": currentUser!.id,
      "name": currentUser!.name,
      "nome": currentUser!.name,
      "phone": currentUser!.phone,
      "password": currentUser!.password,
    };

    if (currentUser!.name == "" || currentUser!.name!.length < 3) {
      wp.showMessage("Nome do usuário inválido.", Colors.red);
      isLoading = false;
    } else if (currentUser!.phone!.length != 15) {
      wp.showMessage("phone do usuário inválido.", Colors.red);
      isLoading = false;
    } else if (confirmPassword != currentUser!.password) {
      wp.showMessage("Senha incorreta...tente novamente.", Colors.red);
      isLoading = false;
    } else if (currentUser!.password != null) {
      if (currentUser!.password!.length < 5) {
        wp.showMessage("Senha muito curta.", Colors.red);
        isLoading = false;
      }
    } else {
      var status = await repo.changeUser(dados);
      if (status == "OK") {
        wp.showMessage("Informações Alteradas com Sucesso!", Colors.lightGreen);
        if (context.mounted) {
          await Navigator.pushReplacementNamed(context, '/');
        }
        return;
      } else {
        wp.showMessage("Ocorreu um Erro a Tentar Salvar  Usuário", Colors.red);
      }
      isLoading = false;
      currentUser!.email = "";
      currentUser!.password = "";
    }
  }

  @action
  Future<void> logout(BuildContext context) async {
    await sairDaSessao(context);
  }

  Future<void> sairDaSessao(BuildContext context) async {
    await clearAll();
    wp.showMessage("Sessão Fechada.", Colors.lightGreen);
    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  Future<void> clearAll() async {
    AuthController authController = GetIt.I<AuthController>();
    authController.setIslogged(false);
    await JwtService().logout();
  }
}
