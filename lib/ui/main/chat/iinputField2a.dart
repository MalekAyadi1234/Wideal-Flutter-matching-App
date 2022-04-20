import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//
// ver 2.0 - 29/09/2020
//

class IInputField2 extends StatefulWidget {
  final String hint;
  final IconData? icon;
  final IconData? iconRight;
  final Function()? onPressRightIcon;
  final Function(String)? onChangeText;
  final TextEditingController? controller;
  final TextInputType type;
  final int maxLenght;
  final Color colorDefaultText;
  final Color colorBackground;
  IInputField2({required this.hint, this.icon, this.controller, required this.type,
    required this.colorDefaultText, required this.colorBackground,
    this.iconRight, this.onPressRightIcon, required this.onChangeText, required this.maxLenght});

  @override
  _IInputField2State createState() => _IInputField2State();
}

class _IInputField2State extends State<IInputField2> {

  @override
  Widget build(BuildContext context) {

    Widget? _sicon = Icon(widget.icon, color: widget.colorDefaultText,);
      if (widget.icon == null)
        _sicon = null;

    var _sicon2;
    if (widget.iconRight != null)
      _sicon2 = InkWell(
      onTap: () {
        if (widget.onPressRightIcon != null)
          widget.onPressRightIcon!();
      }, // needed
      child: Icon(widget.iconRight, color: widget.colorDefaultText,));

    return Container(
      child: new TextFormField(
          keyboardType: widget.type,
        cursorColor: widget.colorDefaultText,
        controller: widget.controller,
        onChanged: (String value) async {
          if (widget.onChangeText != null)
            widget.onChangeText!(value);
        },
        textAlignVertical: TextAlignVertical.center,
        maxLines: 1,
        maxLength: widget.maxLenght,
        style: TextStyle(
          color: widget.colorDefaultText,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp("[\"]")),
        ],
        decoration: new InputDecoration(
          prefixIcon: _sicon,
          suffixIcon: _sicon2,
          counterText: "",
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