import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_app/app/shared/mob_x/auth_controller.dart';
import 'package:my_app/app/views/profile/profile_page.dart';
import 'package:my_app/app/views/support/support_page.dart';
import 'package:my_app/app/widgets/default_widgets.dart';

class CustomDrawwer extends StatelessWidget {
  final Function(int)? onTap;
  final int? page;
  final bool? logado;
  final bool? connected;
  const CustomDrawwer({super.key, this.page, this.onTap, this.logado, this.connected});

  @override
  Widget build(BuildContext context) {
    AuthController? controller = GetIt.I<AuthController>();

    return Drawer(
      child: Stack(
        children: <Widget>[
          StandardWidgets().colorWidgetDrawer,
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              (controller.islogged!)
                  ? UserAccountsDrawerHeader(
                      accountName: Text("${controller.currentUser?.name}"),
                      accountEmail: Text(controller.currentUser?.email ?? ''),
                      onDetailsPressed: () {
                        (controller.currentUser?.id != 30)
                            ? Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfilePage()))
                            : null;
                      },
                    )
                  : Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 30, right: 50, left: 20),
                      child: Image.asset("assets/icons/logo_inicial.png"),
                    ),
              ListTile(
                leading: Icon(
                  MdiIcons.home,
                  size: 30,
                ),
                selected: page == 0,
                title: const Text(
                  "Início",
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  onTap!(0);
                },
              ),
              (!controller.islogged! && connected!)
                  ? ListTile(
                      leading: Icon(
                        MdiIcons.loginVariant,
                        size: 25,
                      ),
                      selected: page == 1,
                      title: const Text(
                        "Autenticação",
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        onTap!(1);
                      },
                    )
                  : Container(),
              ListTile(
                leading: Icon(
                  MdiIcons.information,
                  size: 30,
                ),
                selected: page == 6,
                title: const Text(
                  "Sobre o Projeto",
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SupportWidget()));
                },
              ),
              (controller.islogged!)
                  ? ListTile(
                      leading: Icon(MdiIcons.login),
                      selected: page == 2,
                      title: const Text("Sair"),
                      onTap: () {
                        controller.logout(context);
                      },
                    )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }
}
