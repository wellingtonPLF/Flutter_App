import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:my_app/app/shared/helpers/router.helper.dart';
import 'dart:developer' as developer;

import 'package:my_app/app/shared/mob_x/auth_controller.dart';
import 'package:my_app/app/shared/services/jwt_service.dart';
import 'package:my_app/app/shared/utils/general.util.dart';
import 'package:my_app/app/widgets/_manage_widget.dart';

class SplashscreenPage extends StatefulWidget {
  final String title;
  const SplashscreenPage({super.key, this.title = "Splashscreen"});

  @override
  SplashscreenPageState createState() => SplashscreenPageState();
}

class SplashscreenPageState extends State<SplashscreenPage> {
  ReactionDisposer? disposer;
  AuthController controller = GetIt.I<AuthController>();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1500)).then((_) {
      JwtService().getTokenByAuthentication().then((value) {
        if (value != null) {
          controller.setTokenUser(value);
        }
      });
      disposer = autorun((_) async {
        JwtService().getUserByToken().then((value) {
          try {
            controller.setCurrentUser();
          } catch (e) {
            developer.log(e.toString(), error: e, name: GeneralUtils().getCurrentFileName(StackTrace.current));
          }
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await MyRouter.pushPageReplacement(
              context,
              const ManageWidget(),
            );
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Scaffold(
      body: Opacity(
        opacity: 0.9,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Hero(
                  tag: "icons",
                  child: Image.asset(
                    "assets/icons/logo_inicial.png",
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                ),
              ),
              const SizedBox(height: 70),
              const Padding(padding: EdgeInsets.only(top: 20.0)),
              const CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 2,
              ),
            ],
          ),
        ),
      ),
    )));
  }

  @override
  void dispose() {
    disposer!();
    super.dispose();
  }
}
