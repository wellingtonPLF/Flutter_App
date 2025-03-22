import 'package:flutter/material.dart';
import 'package:my_app/app/config/env/enviorement.util.dart';
import 'package:my_app/app/widgets/default_widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SupportWidget extends StatefulWidget {
  const SupportWidget({super.key});

  @override
  SupportWidgetState createState() => SupportWidgetState();
}

class SupportWidgetState extends State<SupportWidget> {
  String strVersao = "";

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      setState(() {
        strVersao = "${"Versão instalada: ${packageInfo.version}"}-${packageInfo.buildNumber}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sobre meu App"),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: CONS_COR_BOTAO,
      ),
      body: Stack(
        children: <Widget>[
          StandardWidgets().containeDeFundoDrawer,
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(15),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: const TextSpan(
                        style: TextStyle(fontSize: 16.0, height: 1.5, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'O App Flutter',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          TextSpan(
                            text: " é um app basico.",
                          ),
                        ],
                      ),
                    )),
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: Text(
                    strVersao,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
