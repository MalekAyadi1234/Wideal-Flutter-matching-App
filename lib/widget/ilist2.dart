import 'package:flutter/material.dart';

class IList2 extends StatelessWidget {
  final String imageAsset;
  final String text;
  final TextStyle textStyle;
  final Color imageColor;
  final Widget? child1;
  final Widget? child2;
  IList2({this.imageAsset = "", this.text = "", this.textStyle = const TextStyle(),
    this.imageColor = Colors.red, this.child1, this.child2});

  @override
  Widget build(BuildContext context) {
    Widget _imageAsset = Container();
    if (imageAsset.isNotEmpty)
      _imageAsset = Image.asset(imageAsset,
          fit: BoxFit.contain, color: imageColor,);
    return Row(children: <Widget>[
      UnconstrainedBox(
          child: Container(
              height: 25,
              width: 25,
              child: _imageAsset
          )),
      SizedBox(width: 10,),
      Expanded(
        child: Text(text, style: textStyle,),
      ),
      if (child1 != null)
        child1!,
      SizedBox(width: 10,),
      if (child2 != null)
        child2!,
    ],
    );
  }
}