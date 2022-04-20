import 'package:flutter/material.dart';

class IInputField2PasswordA extends StatefulWidget {
  final String hint;
  final IconData? icon;
  final Function(String)? onChangeText;
  final TextEditingController? controller;
  final TextInputType type;
  final Color colorDefaultText;
  IInputField2PasswordA({this.hint = "", this.icon, this.controller, required this.type,
    this.colorDefaultText = Colors.black,
    this.onChangeText});

  @override
  _IInputField2PasswordAState createState() => _IInputField2PasswordAState();
}

class _IInputField2PasswordAState extends State<IInputField2PasswordA> {

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {

    var _sicon = Icon(widget.icon, color: widget.colorDefaultText,);
    var _icon = Icons.visibility_off;
    if (!_obscureText)
      _icon = Icons.visibility;

    var _sicon2 = IconButton(
      iconSize: 20,
      icon: Icon(
        _icon, //_icon,
        color: widget.colorDefaultText,
      ),
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );

    return Container(
      child: new TextFormField(
        obscureText: _obscureText,
        cursorColor: widget.colorDefaultText,
        keyboardType: widget.type,
        controller: widget.controller,
        onChanged: (String value) async {
          if (widget.onChangeText != null)
            widget.onChangeText!(value);
        },
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          color: widget.colorDefaultText,
        ),
        decoration: new InputDecoration(
          prefixIcon: _sicon,
          suffixIcon: _sicon2,
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: TextStyle(
              color: widget.colorDefaultText,
              fontSize: 16.0),
        ),
      ),
    );
  }
}