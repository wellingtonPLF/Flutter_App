// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthController on AuthControllerBase, Store {
  Computed<bool?>? _$isPasswordValidComputed;

  @override
  bool? get isPasswordValid => (_$isPasswordValidComputed ??= Computed<bool?>(
          () => super.isPasswordValid,
          name: 'AuthControllerBase.isPasswordValid'))
      .value;
  Computed<bool?>? _$isEmailValidComputed;

  @override
  bool? get isEmailValid =>
      (_$isEmailValidComputed ??= Computed<bool?>(() => super.isEmailValid,
              name: 'AuthControllerBase.isEmailValid'))
          .value;
  Computed<Function?>? _$loginPressedComputed;

  @override
  Function? get loginPressed =>
      (_$loginPressedComputed ??= Computed<Function?>(() => super.loginPressed,
              name: 'AuthControllerBase.loginPressed'))
          .value;

  late final _$isLoadingAtom =
      Atom(name: 'AuthControllerBase.isLoading', context: context);

  @override
  bool? get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool? value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isloggedAtom =
      Atom(name: 'AuthControllerBase.islogged', context: context);

  @override
  bool? get islogged {
    _$isloggedAtom.reportRead();
    return super.islogged;
  }

  @override
  set islogged(bool? value) {
    _$isloggedAtom.reportWrite(value, super.islogged, () {
      super.islogged = value;
    });
  }

  late final _$tokenUserAtom =
      Atom(name: 'AuthControllerBase.tokenUser', context: context);

  @override
  String? get tokenUser {
    _$tokenUserAtom.reportRead();
    return super.tokenUser;
  }

  @override
  set tokenUser(String? value) {
    _$tokenUserAtom.reportWrite(value, super.tokenUser, () {
      super.tokenUser = value;
    });
  }

  late final _$currentUserAtom =
      Atom(name: 'AuthControllerBase.currentUser', context: context);

  @override
  UserModel? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(UserModel? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$confirmPasswordAtom =
      Atom(name: 'AuthControllerBase.confirmPassword', context: context);

  @override
  String? get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String? value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  late final _$msgAtom = Atom(name: 'AuthControllerBase.msg', context: context);

  @override
  String? get msg {
    _$msgAtom.reportRead();
    return super.msg;
  }

  @override
  set msg(String? value) {
    _$msgAtom.reportWrite(value, super.msg, () {
      super.msg = value;
    });
  }

  late final _$passwordVisibleAtom =
      Atom(name: 'AuthControllerBase.passwordVisible', context: context);

  @override
  bool? get passwordVisible {
    _$passwordVisibleAtom.reportRead();
    return super.passwordVisible;
  }

  @override
  set passwordVisible(bool? value) {
    _$passwordVisibleAtom.reportWrite(value, super.passwordVisible, () {
      super.passwordVisible = value;
    });
  }

  late final _$imageFileAtom =
      Atom(name: 'AuthControllerBase.imageFile', context: context);

  @override
  XFile? get imageFile {
    _$imageFileAtom.reportRead();
    return super.imageFile;
  }

  @override
  set imageFile(XFile? value) {
    _$imageFileAtom.reportWrite(value, super.imageFile, () {
      super.imageFile = value;
    });
  }

  late final _$getIsLoggedAsyncAction =
      AsyncAction('AuthControllerBase.getIsLogged', context: context);

  @override
  Future<bool?> getIsLogged() {
    return _$getIsLoggedAsyncAction.run(() => super.getIsLogged());
  }

  late final _$setCurrentUserAsyncAction =
      AsyncAction('AuthControllerBase.setCurrentUser', context: context);

  @override
  Future setCurrentUser() {
    return _$setCurrentUserAsyncAction.run(() => super.setCurrentUser());
  }

  late final _$loginAsyncAction =
      AsyncAction('AuthControllerBase.login', context: context);

  @override
  Future<void> login(BuildContext context) {
    return _$loginAsyncAction.run(() => super.login(context));
  }

  late final _$lembrarSenhaAsyncAction =
      AsyncAction('AuthControllerBase.lembrarSenha', context: context);

  @override
  Future<void> lembrarSenha(BuildContext context) {
    return _$lembrarSenhaAsyncAction.run(() => super.lembrarSenha(context));
  }

  late final _$validaCreateUserAsyncAction =
      AsyncAction('AuthControllerBase.validaCreateUser', context: context);

  @override
  Future<bool> validaCreateUser(BuildContext context) {
    return _$validaCreateUserAsyncAction
        .run(() => super.validaCreateUser(context));
  }

  late final _$validaChangeUserAsyncAction =
      AsyncAction('AuthControllerBase.validaChangeUser', context: context);

  @override
  Future<bool> validaChangeUser(BuildContext context) {
    return _$validaChangeUserAsyncAction
        .run(() => super.validaChangeUser(context));
  }

  late final _$changeUserAsyncAction =
      AsyncAction('AuthControllerBase.changeUser', context: context);

  @override
  Future<void> changeUser(BuildContext context) {
    return _$changeUserAsyncAction.run(() => super.changeUser(context));
  }

  late final _$logoutAsyncAction =
      AsyncAction('AuthControllerBase.logout', context: context);

  @override
  Future<void> logout(BuildContext context) {
    return _$logoutAsyncAction.run(() => super.logout(context));
  }

  late final _$AuthControllerBaseActionController =
      ActionController(name: 'AuthControllerBase', context: context);

  @override
  void setImageFile(XFile? value) {
    final _$actionInfo = _$AuthControllerBaseActionController.startAction(
        name: 'AuthControllerBase.setImageFile');
    try {
      return super.setImageFile(value);
    } finally {
      _$AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setId(int? value) {
    final _$actionInfo = _$AuthControllerBaseActionController.startAction(
        name: 'AuthControllerBase.setId');
    try {
      return super.setId(value);
    } finally {
      _$AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserName(String? value) {
    final _$actionInfo = _$AuthControllerBaseActionController.startAction(
        name: 'AuthControllerBase.setUserName');
    try {
      return super.setUserName(value);
    } finally {
      _$AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String? value) {
    final _$actionInfo = _$AuthControllerBaseActionController.startAction(
        name: 'AuthControllerBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhone(String? value) {
    final _$actionInfo = _$AuthControllerBaseActionController.startAction(
        name: 'AuthControllerBase.setPhone');
    try {
      return super.setPhone(value);
    } finally {
      _$AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String password) {
    final _$actionInfo = _$AuthControllerBaseActionController.startAction(
        name: 'AuthControllerBase.setPassword');
    try {
      return super.setPassword(password);
    } finally {
      _$AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmail(String email) {
    final _$actionInfo = _$AuthControllerBaseActionController.startAction(
        name: 'AuthControllerBase.setEmail');
    try {
      return super.setEmail(email);
    } finally {
      _$AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIslogged(bool? value) {
    final _$actionInfo = _$AuthControllerBaseActionController.startAction(
        name: 'AuthControllerBase.setIslogged');
    try {
      return super.setIslogged(value);
    } finally {
      _$AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsLoading(bool? value) {
    final _$actionInfo = _$AuthControllerBaseActionController.startAction(
        name: 'AuthControllerBase.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTokenUser(String? value) {
    final _$actionInfo = _$AuthControllerBaseActionController.startAction(
        name: 'AuthControllerBase.setTokenUser');
    try {
      return super.setTokenUser(value);
    } finally {
      _$AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$AuthControllerBaseActionController.startAction(
        name: 'AuthControllerBase.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMsg(String value) {
    final _$actionInfo = _$AuthControllerBaseActionController.startAction(
        name: 'AuthControllerBase.setMsg');
    try {
      return super.setMsg(value);
    } finally {
      _$AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void togglePasswordVisibility() {
    final _$actionInfo = _$AuthControllerBaseActionController.startAction(
        name: 'AuthControllerBase.togglePasswordVisibility');
    try {
      return super.togglePasswordVisibility();
    } finally {
      _$AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
islogged: ${islogged},
tokenUser: ${tokenUser},
currentUser: ${currentUser},
confirmPassword: ${confirmPassword},
msg: ${msg},
passwordVisible: ${passwordVisible},
imageFile: ${imageFile},
isPasswordValid: ${isPasswordValid},
isEmailValid: ${isEmailValid},
loginPressed: ${loginPressed}
    ''';
  }
}
