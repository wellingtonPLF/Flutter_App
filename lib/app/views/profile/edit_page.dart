import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_app/app/config/env/enviorement.util.dart';
import 'package:my_app/app/shared/mob_x/auth_controller.dart';
import 'package:my_app/app/widgets/button_widget.dart';
import 'package:my_app/app/widgets/icon_button_widget.dart';
import 'package:my_app/app/widgets/textfield_widget.dart';
import 'package:oktoast/oktoast.dart';

class EditUser extends StatefulWidget {
  final String title;
  const EditUser({super.key, this.title = "Login"});

  @override
  EditUserState createState() => EditUserState();
}

class EditUserState extends State<EditUser> {
  AuthController authController = GetIt.I<AuthController>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _picker = ImagePicker();
  var maskFormatter = MaskTextInputFormatter(mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {});
    } else {}
  }

  @override
  void initState() {
    super.initState();
    authController.isLoading = false;
    authController.setName(authController.currentUser!.name!);
    authController.setUserName(authController.currentUser!.username!);
    authController.setPhone(authController.currentUser!.phone!);
    authController.setEmail(authController.currentUser!.email!);
    authController.setId(authController.currentUser!.id!);
  }

  @override
  Widget build(BuildContext context) {
    double largura = MediaQuery.of(context).size.width;
    return OKToast(
      child: SafeArea(
          child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            title: const Text("Alteração de Informações"),
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
            backgroundColor: CONS_COR_BOTAO),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 30,
                ),
                Observer(
                  builder: (_) {
                    return CustomTextField(
                      initialValue: authController.currentUser!.name!,
                      hint: 'Seu Nome',
                      prefix: const Icon(Icons.account_circle),
                      onChanged: authController.setName,
                      enabled: !authController.isLoading!,
                    );
                  },
                ),
                Container(
                  height: 20,
                ),
                Observer(
                  builder: (_) {
                    return CustomTextField(
                      initialValue: authController.currentUser!.phone!,
                      hint: 'Telefone',
                      formatoTexto: [maskFormatter],
                      textInputType: TextInputType.phone,
                      prefix: const Icon(Icons.settings_cell),
                      onChanged: authController.setPhone,
                      enabled: !authController.isLoading!,
                    );
                  },
                ),
                Container(
                  height: 20,
                ),
                Container(
                  height: 20,
                ),
                Observer(
                  builder: (_) {
                    return CustomTextField(
                      hint: 'Nova Senha',
                      prefix: const Icon(Icons.lock),
                      obscure: !authController.passwordVisible!,
                      onChanged: authController.setPassword,
                      enabled: !authController.isLoading!,
                      suffix: CustomIconButton(
                        radius: 32,
                        iconData: authController.passwordVisible! ? Icons.visibility_off : Icons.visibility,
                        onTap: authController.togglePasswordVisibility,
                      ),
                    );
                  },
                ),
                Container(
                  height: 20,
                ),
                Observer(
                  builder: (_) {
                    return CustomTextField(
                      hint: 'Confirmação de Nova Senha',
                      prefix: const Icon(Icons.lock),
                      obscure: !authController.passwordVisible!,
                      onChanged: authController.setConfirmPassword,
                      enabled: !authController.isLoading!,
                      suffix: CustomIconButton(
                        radius: 32,
                        iconData: authController.passwordVisible! ? Icons.visibility_off : Icons.visibility,
                        onTap: authController.togglePasswordVisibility,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Observer(
                  builder: (_) {
                    return CustomButton(
                      loading: authController.isLoading,
                      onPress: () => authController.changeUser(context),
                      altura: 50,
                      largura: largura,
                      fonteSize: 18,
                      corBotao: CONS_COR_BOTAO,
                      icone: Icon(
                        MdiIcons.contentSave,
                        size: 25,
                        color: Colors.white,
                      ),
                      texto: "Salvar Informações",
                    );
                  },
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
