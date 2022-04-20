import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ICard28FileCaching extends StatelessWidget {
  final String id;
  final Color color;
  final String title;
  final Color colorProgressBar;
  final TextStyle titleStyle;
  final String text;
  final TextStyle textStyle;
  final String userAvatar;

  final Color balloonColor;
  final String balloonText;
  final TextStyle balloonStyle;
  final Color balloonColor2;
  final String balloonText2;
  final TextStyle balloonStyle2;

  final bool enable;
  final Function(String) callback;

  ICard28FileCaching({required this.id, this.color = Colors.grey, this.text = "", required this.textStyle, this.title = "",
    required this.titleStyle,  this.colorProgressBar = Colors.black,
    required this.balloonColor2, required this.balloonStyle2, this.balloonText2 = "",
    required this.userAvatar, this.balloonColor = Colors.transparent, this.balloonText = "", required this.balloonStyle, this.enable = true,
    required this.callback
  });

  @override
  Widget build(BuildContext context) {
    var _avatar = Container();
    try {
      _avatar = Container(
        width: 40,
        height: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            child: CachedNetworkImage(
              placeholder: (context, url) =>
                  CircularProgressIndicator(backgroundColor: colorProgressBar,),
              imageUrl: userAvatar,
              imageBuilder: (context, imageProvider) =>
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ),
        ),
      );
    } catch(_){

    }

    return Stack(
      children: [
        Opacity(
          opacity: (enable) ? 1.0 : 0.2,
        child: Container(
            margin: EdgeInsets.only(bottom: 10),
            color: color,
            child: Container(
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _avatar,
                      SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(title, style: titleStyle,),
                            SizedBox(height: 10,),
                            Row(
                              children: <Widget>[
                                // Icon(Icons.phone, size: 15, color: Colors.black.withOpacity(0.3),),
                                // SizedBox(width: 10,),
                                Text(text, style: textStyle, textAlign: TextAlign.left,),
                              ],
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ))),

        if (!enable)
        Positioned.fill(
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          color: Colors.black.withAlpha(80),
        )),

        Positioned.fill(
            child: Container(
              alignment: Alignment.topRight,
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  Container(
                      decoration: BoxDecoration(
                        color: balloonColor,
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.only(right: 10, top: 10),
                      padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                      child: Text(balloonText, style: balloonStyle,)),
                    Container(
                        decoration: BoxDecoration(
                          color: balloonColor2,
                          borderRadius: new BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.only(right: 10, top: 10),
                        padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                        child: Text(balloonText2, style: balloonStyle2,)),
                  ],
                  ),
              ),
            ),

        if (enable)
        Positioned.fill(
          child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.grey[400],
                onTap: (){
                  callback(id);
                }, // needed
              )),
        )
      ],
    );
  }
}