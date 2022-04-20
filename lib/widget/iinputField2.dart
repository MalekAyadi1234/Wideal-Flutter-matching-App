import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IInputField2 extends StatefulWidget {
  final String hint;
  final IconData? icon;
  final IconData? iconRight;
  final Function()? onPressRightIcon;
  final Function(String)? onChangeText;
  final TextEditingController? controller;
  final TextInputType type;
  final Color colorDefaultText;
  final int maxLength;
  final Color colorBackground;
  IInputField2({this.hint = "", this.icon, this.controller, required this.type,
    this.colorDefaultText = Colors.black, this.colorBackground = Colors.white,
    this.iconRight, this.onPressRightIcon, this.onChangeText, this.maxLength = 1000});

  @override
  _IInputField2State createState() => _IInputField2State();
}

class _IInputField2State extends State<IInputField2> {

  @override
  Widget build(BuildContext context) {
    var _sicon = Icon(widget.icon, color: widget.colorDefaultText,);
    var _sicon2;
    if (widget.iconRight != null)
      _sicon2 = InkWell(
      onTap: () {
        if (widget.onPressRightIcon != null)
          widget.onPressRightIcon!();
      }, // needed
      child: Icon(widget.iconRight, color: widget.colorDefaultText,));

    return Container(
      decoration: BoxDecoration(
        color: widget.colorBackground,
        border: Border.all(color: Colors.grey[200]!),
        borderRadius: new BorderRadius.circular(5),
      ),
      child: new TextFormField(
        maxLength: widget.maxLength,
        maxLines: 1,
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
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp("[\"]")),
        ],
        decoration: new InputDecoration(
          prefixIcon: _sicon,
          suffixIcon: _sicon2,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          hintText: widget.hint,
          hintStyle: TextStyle(
              color: widget.colorDefaultText,
              fontSize: 16.0),
        ),
      ),
    );
  }
}