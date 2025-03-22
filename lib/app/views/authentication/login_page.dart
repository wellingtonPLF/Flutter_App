import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:my_app/app/config/env/enviorement.util.dart';
import 'package:my_app/app/shared/mob_x/auth_controller.dart';
import 'package:my_app/app/widgets/default_widgets.dart';
import 'package:oktoast/oktoast.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  AuthController authController = GetIt.I<AuthController>();
  late ReactionDisposer disposer;
  final StandardWidgets standard = StandardWidgets();

  @override
  Widget build(BuildContext context) {
    double altura = MediaQuery.of(context).size.height;
    double largura = MediaQuery.of(context).size.width;
    return OKToast(
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            standard.containeDeFundoDrawer,
            standard.scrolTop(),
            Container(
              margin: const EdgeInsets.only(top: 35),
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB((largura / 15), 0, (largura / 20), 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(
                        "assets/icons/logo_inicial.png",
                        width: largura * 0.45,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        height: (altura / 15),
                      ),
                      Observer(
                        builder: (_) {
                          return Container(
                              color: Colors.amber,
                              padding: const EdgeInsets.all(4),
                              child: TextField(
                                onChanged: authController.setEmail,
                                enabled: !authController.isLoading!,
                                decoration: const InputDecoration(
                                  labelText: 'E-mail',
                                  labelStyle: TextStyle(color: Colors.black),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Observer(
                        builder: (_) {
                          return Container(
                              color: Colors.amber,
                              padding: const EdgeInsets.all(4),
                              child: TextField(
                                onChanged: authController.setPassword,
                                obscureText: true,
                                enabled: !authController.isLoading!,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color: Colors.black),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ));
                        },
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(),
                          TextButton(
                            child: const Text("Esqueci a Senha", style: CONS_TEXTO_LINK),
                            onPressed: () {
                              authController.lembrarSenha(context);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //Botão de Login

                      Observer(
                        builder: (_) {
                          return TextButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all(CONS_COR_BOTAO),
                              foregroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4), // Set the border-radius
                                ),
                              ),
                              overlayColor: WidgetStateProperty.resolveWith<Color?>(
                                (Set<WidgetState> states) {
                                  if (states.contains(WidgetState.hovered)) return Colors.blue.withOpacity(0.04);
                                  if (states.contains(WidgetState.focused) || states.contains(WidgetState.pressed)) {
                                    return Colors.blue.withOpacity(0.12);
                                  }
                                  return null;
                                },
                              ),
                            ),
                            onPressed: (authController.isLoading! ? null : () => authController.login(context)),
                            child: SizedBox(
                              width: largura * 0.3,
                              height: 30,
                              child: (authController.isLoading!
                                  ? const SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      ))
                                  : const Center(
                                      child: Text(
                                        "Entrar",
                                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
