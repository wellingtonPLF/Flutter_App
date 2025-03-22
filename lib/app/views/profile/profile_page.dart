import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_app/app/config/env/enviorement.util.dart';
import 'package:my_app/app/shared/mob_x/auth_controller.dart';
import 'package:my_app/app/views/profile/edit_page.dart';
import 'package:my_app/app/widgets/button_widget.dart';
import 'package:my_app/app/widgets/default_widgets.dart';
import 'package:oktoast/oktoast.dart';

class ProfilePage extends StatefulWidget {
  final String title;
  const ProfilePage({super.key, this.title = "Login"});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  AuthController lc = GetIt.I<AuthController>();
  AuthController controllerAuth = GetIt.I<AuthController>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    return OKToast(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: const Text("Meu Perfil"),
              iconTheme: const IconThemeData(color: Colors.white),
              centerTitle: true,
              backgroundColor: CONS_COR_BOTAO),
          body: Stack(
            children: <Widget>[
              StandardWidgets().containeDeFundoDrawer,
              Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 15),
                        child: Text(
                          "@ ${controllerAuth.currentUser!.name!}",
                          style: CONS_TEXTO_TITULO_ESCURO_MEDIO,
                        ),
                      ),
                      Container(
                        width: largura * 0.8,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(14.0),
                          boxShadow: const <BoxShadow>[
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 8.0,
                              offset: Offset(3.0, 10.0),
                            ),
                          ],
                        ),
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              width: largura,
                              child: Text(
                                'Apelido: ${controllerAuth.currentUser!.username} ',
                                style: CONS_TEXTO_TITULO_ESCURO_PEQUENO,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              width: largura,
                              child: Text(
                                'E-Mail: ${controllerAuth.currentUser!.email} ',
                                style: CONS_TEXTO_TITULO_ESCURO_PEQUENO,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              width: largura,
                              child: Text(
                                'Telefone: ${controllerAuth.currentUser!.phone} ',
                                style: CONS_TEXTO_TITULO_ESCURO_PEQUENO,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        loading: false,
                        onPress: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditUser()));
                        },
                        altura: 45,
                        largura: largura * 0.7,
                        fonteSize: 16,
                        corBotao: CONS_COR_BOTAO,
                        texto: "Editar Perfil",
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
