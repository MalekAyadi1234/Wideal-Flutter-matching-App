import 'package:flutter/material.dart';
import 'package:wideal/widget/iinkwell.dart';

class IButtonCount extends StatefulWidget {
  @required
  final Function(int)? pressButton;
  final Color color;
  final TextStyle textStyle;
  final int count;
  IButtonCount(
      {this.pressButton,
      this.color = Colors.black,
      this.textStyle = const TextStyle(),
      this.count = 0});
  @override
  _IButtonCountState createState() => _IButtonCountState();
}

class _IButtonCountState extends State<IButtonCount> {
  int _count = 0;
  Color _colorMinus = Colors.red;
  Color _color = Colors.grey;
  // var _textStyle = TextStyle(fontSize: 16);

  _onMinusClick() {
    print("User click minus button");
    setState(() {
      if (_count > 1) _count--;
      if (_count == 1) _colorMinus = Colors.grey;
    });
    if (widget.pressButton != null) widget.pressButton!(_count);
  }

  _onPlusClick() {
    print("User click plus button");
    setState(() {
      _count++;
      _colorMinus = _color;
    });
    if (widget.pressButton != null) widget.pressButton!(_count);
  }

  @override
  void initState() {
    _count = widget.count;

    _color = widget.color;
    _colorMinus = _color;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IInkWell(
          child: Icon(
            Icons.remove_circle_outline,
            color: _colorMinus,
            size: 25,
          ),
          onPress: _onMinusClick,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          _count.toString(),
          style: widget.textStyle,
        ),
        SizedBox(
          width: 10,
        ),
        IInkWell(
          child: Icon(
            Icons.add_circle_outline,
            color: _color,
            size: 25,
          ),
          onPress: _onPlusClick,
        ),
      ],
    ));
  }
}
