import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/app/config/env/enviorement.util.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class StandardWidgets {
  StandardWidgets();

  Container colorWidgetDrawer = Container(
    decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
      Colors.white,
      CONS_COR_BACKGROUND,
      CONS_COR_BACKGROUND,
      CONS_COR_CANVAS,
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
  );

  Widget? showDialogSimples(String textoCurto, Widget iconData, String textoLongo, Function onPress, BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.gps_fixed,
                size: 60.0,
                color: Colors.deepOrangeAccent,
              ),
              const Divider(),
              Text(textoCurto,
                  textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black87)),
              const Divider(),
              Text(
                textoLongo,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0, color: Colors.black87),
              ),
              const Divider(),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.only(left: 70, right: 70),
                backgroundColor: Colors.green[600],
                disabledBackgroundColor: Colors.green.withAlpha(120),
                textStyle: const TextStyle(color: Colors.white, fontSize: 20),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
              ),
              child: const Text(
                "OK",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                onPress();
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
    return null;
  }

  CustomScrollView scrolTop({String? titulo}) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          floating: true,
          snap: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              (titulo ?? ""),
              style: const TextStyle(
                color: Colors.green,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ],
    );
  }

  Container containeDeFundoDrawer = Container(
    decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
      Colors.white,
      CONS_COR_BACKGROUND,
      CONS_COR_BACKGROUND,
      CONS_COR_CANVAS,
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
  );

  void showMessage(String message, Color cor) {
    Fluttertoast.showToast(
      gravity: ToastGravity.BOTTOM,
      msg: message,
    );
  }

  void mostrarAlerta(String texto, String subTexto, BuildContext context, AlertType icone) {
    Alert(
      context: context,
      type: icone,
      title: texto,
      desc: subTexto,
      buttons: [
        DialogButton(
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "Fechar",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }
}
