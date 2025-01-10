import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String labelText;
  final TextInputType keyboardType;
  final int? inputLimit;
  final Function? validate;
  final Function? onSave;
  final Function(String)? onChange;
  final InputFormatter? formatter;
  final TextAlign textAlign;
  final FocusNode? node;
  final AutovalidateMode? autovalidateMode;
  final Color? iconColor;
  final String hintText;

  const PasswordTextField(
      {super.key,
      this.iconColor,
      this.hintText = "",
      this.controller,
      this.labelText = "Enter password",
      required this.keyboardType,
      this.inputLimit,
      this.validate,
      this.onSave,
      this.onChange,
      this.formatter,
      this.textAlign = TextAlign.start,
      // this.icon = AppAssets.passwordTextFdIcon,
      this.node,
      this.autovalidateMode = AutovalidateMode.disabled});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Colors.black),

      readOnly: false,
      // textAlignVertical: TextAlignVertical.top,
      // style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      controller: widget.controller,

      focusNode: widget.node,
      autovalidateMode: widget.autovalidateMode,
      decoration: InputDecoration(
        // errorMaxLines: 5,
        // errorStyle: const TextStyle(),

        prefixIcon: Transform.scale(scale: 0.4, child: const Icon(Icons.lock)

            //  ImageIcon(
            //   AssetImage(widget.icon),
            //   size: 10,
            // ),
            ),
        filled: true,
        // fillColor: Colors.white,
        // contentPadding: EdgeInsets.zero,
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Colors.grey),

        // hintText: widget.hintText,
        prefixText: "|     ",
        prefixStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xffEBE8E8),
        ),
        suffixIcon: GestureDetector(
          child: Transform.flip(
            //angle: 3.142 * 2,'
            flipX: true,
            child: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
              weight: 0.000006,
              size: 18,
            ),
          ),
          onTap: () => obscureText(!_passwordVisible),
        ),
      ),
      inputFormatters: [
        LengthLimitingTextInputFormatter(widget.inputLimit),
        if (widget.formatter == InputFormatter.digitOnly) FilteringTextInputFormatter.allow(RegExp("[0-9]"))
      ],
      keyboardType: widget.keyboardType,
      obscureText: !_passwordVisible,

      //obscuringCharacter: "⚫",

      validator: (value) => widget.validate != null ? widget.validate!(value) : null,
      onSaved: (value) => widget.onSave != null ? widget.onSave!(value) : null,
      onChanged: (value) => widget.onChange != null ? widget.onChange!(value) : null,
    );
  }

  void obscureText(bool value) {
    setState(() {
      _passwordVisible = value;
    });
  }
}

enum InputFormatter { stringOnly, digitOnly, alphaNumericOnly }
