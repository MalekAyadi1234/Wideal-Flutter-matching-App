import 'package:flutter/material.dart';

class InputFieldArea3 extends StatefulWidget {
  final String hint;
  final Color colorGrey;
  final TextEditingController? controller;
  final TextInputType type;
  final Color colorDefaultText;
  final Color colorActivy;
  final Function()? callback;
  InputFieldArea3({this.hint = "", this.controller, required this.type,
    this.colorGrey = const Color.fromARGB(255, 209, 210, 205), this.colorDefaultText = Colors.black, this.colorActivy = Colors.red,
    this.callback });

  @override
  _InputFieldArea3State createState() => _InputFieldArea3State();
}

class _InputFieldArea3State extends State<InputFieldArea3> {

  @override
  Widget build(BuildContext context) {
    var _sicon = IconButton(
      iconSize: 20,
      icon: Image.asset("assets/send.png",
          fit: BoxFit.contain
      ),
      onPressed: () {
        setState(() {
          if (widget.callback != null)
            widget.callback!();
        });
      },
    );

    return (new Container(
      decoration: new BoxDecoration(
        border: new Border(
          bottom: new BorderSide(
            width: 0.5,
            color: Colors.transparent,
          ),
        ),
      ),
      child: new TextFormField(
        keyboardType: widget.type,
        controller: widget.controller,
        onChanged: (String value) async {

        },
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          color: widget.colorDefaultText,
        ),
        decoration: new InputDecoration(
          suffixIcon: _sicon,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.colorGrey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: widget.colorActivy),
          ),
          //border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: TextStyle(
              color: widget.colorDefaultText,
              fontSize: 13.0),
          contentPadding: const EdgeInsets.only(
              top: 0.0, right: 30.0, bottom: 0.0, left: 5.0),
        ),
      ),
    ));
  }
}