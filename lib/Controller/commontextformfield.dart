import 'package:flutter/material.dart';

class CommonTextFomField extends StatefulWidget {
  final labelText;
  final suffixIcon;
  final controller;
  final validator;
  final keyboardType;
  final textInputAction;
  final focusedBorder;
  final enabledBorder;

  const CommonTextFomField(
      {Key? key,
        this.labelText,
        this.suffixIcon,
        this.controller,
        this.validator,
        this.keyboardType,
        this.textInputAction,
        this.focusedBorder,
        this.enabledBorder})
      : super(key: key);

  @override
  State<CommonTextFomField> createState() => _CommonTextFomFieldState();
}

class _CommonTextFomFieldState extends State<CommonTextFomField> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return TextFormField(
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: widget.suffixIcon,
        labelStyle: TextStyle(color: Colors.black),
        focusedBorder: widget.focusedBorder,
        enabledBorder: widget.enabledBorder,
        contentPadding: EdgeInsets.symmetric(
          horizontal: height * 0.04,
          vertical: height * 0.027,
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
