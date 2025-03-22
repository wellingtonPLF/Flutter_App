import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/app/config/env/enviorement.util.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.hint,
      this.prefix,
      this.suffix,
      this.obscure = false,
      this.textInputType,
      this.onChanged,
      this.enabled,
      this.controller,
      this.numeroLinhas,
      this.initialValue,
      this.readOnly,
      this.formatoTexto,
      this.focusNode});

  final TextEditingController? controller;
  final String? hint;
  final String? initialValue;
  final int? numeroLinhas;
  final Widget? prefix;
  final Widget? suffix;
  final bool? obscure;
  final TextInputType? textInputType;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final bool? enabled;
  final bool? readOnly;
  final List<TextInputFormatter>? formatoTexto;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: CONS_COR_CANVAS,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: prefix != null ? null : const EdgeInsets.only(left: 16),
      child: TextFormField(
        maxLines: (numeroLinhas == null) ? 1 : numeroLinhas,
        controller: controller,
        obscureText: obscure!,
        keyboardType: textInputType,
        onChanged: onChanged,
        focusNode: focusNode,
        enabled: enabled,
        initialValue: initialValue,
        inputFormatters: formatoTexto,
        autocorrect: false,
        readOnly: (readOnly == null ? false : true),
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          prefixIcon: prefix,
          suffixIcon: suffix,
        ),
        textAlignVertical: TextAlignVertical.center,
      ),
    );
  }
}
