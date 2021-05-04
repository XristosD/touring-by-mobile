import 'package:flutter/material.dart';
import 'package:touring_by/ui/shared/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final Function validator;
  final Function onSaved;

  CustomTextFormField({this.controller, this.labelText, this.obscureText, this.validator, this.onSaved});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

  FocusNode _focusNode;
  Color _color;


  @override
  void initState() {
    super.initState();
    _color = Colors.black26;
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _color = _focusNode.hasFocus ? primaryColor : Colors.black26;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _requestFocus(){
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.widget.controller,
      onSaved: this.widget.onSaved!=null ? (value) => this.widget.onSaved(value) : null,
      validator: (value) => this.widget.validator(value),
      focusNode: _focusNode,
      onTap: _requestFocus,
      decoration: InputDecoration(
        labelText: this.widget.labelText,
        labelStyle: TextStyle(
          color: _color,
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryColor,
              width: 1.5,
            )
        ),
        focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: primaryColor,
              width: 1.5,
            )
        ),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black26,
              width: 1,
            )
        ),
        border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black26,
              width: 1,
            )
        ),
      ),
      cursorColor: Colors.black26,
      obscureText: this.widget.obscureText,
    );
  }
}
