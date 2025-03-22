import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function? onPress;
  final bool? loading;
  final Widget? icone;
  final String? texto;
  final double? fonteSize;
  final double? altura;
  final double? largura;
  final Color? corBotao;
  final int? timeDelay;

  const CustomButton(
      {super.key, this.onPress, this.loading, this.icone, this.texto, this.largura, this.fonteSize, this.altura, this.corBotao, this.timeDelay});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: largura,
      height: altura,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(corBotao),
          foregroundColor: WidgetStateProperty.all<Color>(corBotao!),
          overlayColor: WidgetStateProperty.resolveWith<Color?>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.hovered)) return Colors.blue.withOpacity(0.04);
              if (states.contains(WidgetState.focused) || states.contains(WidgetState.pressed)) return Colors.blue.withOpacity(0.12);
              return null;
            },
          ),
        ),
        onPressed: (loading! ? null : () => onPress!()),
        child: SizedBox(
          width: largura! * 0.8,
          height: 40,
          child: (loading!
              ? const SizedBox(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  ))
              : Center(
                  child: Text(
                    texto!,
                    style: TextStyle(color: Colors.white, fontSize: fonteSize, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                )),
        ),
      ),
    );
  }
}
