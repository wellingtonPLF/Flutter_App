import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:my_app/app/shared/mob_x/auth_controller.dart';

import 'dart:developer' as developer;

import 'package:my_app/app/shared/utils/general.util.dart';
import 'package:my_app/app/views/authentication/login_page.dart';
import 'package:my_app/app/views/home/home_page.dart';
import 'package:my_app/app/widgets/drawer_widget.dart';

class ManageWidget extends StatefulWidget {
  const ManageWidget({super.key});

  @override
  State<ManageWidget> createState() => _ManageWidgetState();
}

class _ManageWidgetState extends State<ManageWidget> {
  // ******************************************************************************
  bool connected = true;
  int page = 0;
  bool logado = false;
  // ******************************************************************************
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  // ******************************************************************************
  GeneralUtils utils = GeneralUtils();
  AuthController? controllerAuth = GetIt.I<AuthController>();
  // ******************************************************************************

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e, name: utils.getCurrentFileName(StackTrace.current));
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    if (result[0] == ConnectivityResult.none) {
      setState(() {
        connected = false;
      });
    } else {
      setState(() {
        connected = true;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (controllerAuth!.islogged!) {
      logado = controllerAuth!.islogged!;
    }

    if (controllerAuth != null && controllerAuth!.islogged != null) {
      if (controllerAuth!.islogged!) {
        logado = controllerAuth!.islogged!;
      }
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: CustomDrawwer(
        logado: logado,
        page: page,
        connected: connected,
        onTap: (int value) {
          setState(() {
            page = value;
          });
          Navigator.pop(context);
        },
      ),
      body: IndexedStack(
        index: page,
        children: <Widget>[HomeWidget(internet: connected), const LoginWidget()],
      ),
    ));
  }
}
