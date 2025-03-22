import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:my_app/app/shared/mob_x/auth_controller.dart';
import 'package:my_app/app/shared/utils/general.util.dart';
import 'package:my_app/app/widgets/default_widgets.dart';

class HomeWidget extends StatefulWidget {
  final bool internet;
  const HomeWidget({super.key, required this.internet});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  GeneralUtils utils = GeneralUtils();
  AuthController controllerUser = GetIt.I<AuthController>();

  bool mostrarBotao = false;
  var loadingState = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 55,
            child: StandardWidgets().scrolTop(),
          ),
          Expanded(
              child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Observer(
                  builder: (_) {
                    return Expanded(
                        child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(right: 30, left: 30, bottom: 200),
                      child: Image.asset("assets/icons/logo_inicial.png"),
                    ));
                  },
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
