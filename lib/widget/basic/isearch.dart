import 'package:flutter/material.dart';

//
// 02.10.2020 rtl
// 11.10.2020 radius and shadow
//

class ISearch extends StatefulWidget {
  final String hint;
  final IconData? icon;
  final IconData? iconRight;
  final Function()? onPressRightIcon;
  final Function(String)? onChangeText;
  final TextEditingController? controller;
  final TextInputType type;
  final TextDirection direction;
  final Color colorDefaultText;
  final Color colorBackground;
  final double radius;
  final int shadow;

  ISearch({required this.hint, this.icon, this.controller,
    required this.type, this.colorDefaultText = Colors.black, this.colorBackground = Colors.white,
    this.iconRight, this.onPressRightIcon, this.onChangeText, required this.direction,
    required this.radius, required this.shadow,
  });

  @override
  _ISearchState createState() => _ISearchState();
}

class _ISearchState extends State<ISearch> {

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
        border: Border.all(color: Colors.black.withAlpha(100)),
        borderRadius: new BorderRadius.circular(widget.radius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(widget.shadow),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      child:  Directionality(
        textDirection: widget.direction,
      child: TextFormField(
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

      ),
      );
  }
}