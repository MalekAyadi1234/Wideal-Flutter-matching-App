import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
const kHomeImage =
    '';
class ImageAnimation extends StatefulWidget {
  const ImageAnimation({Key? key}) : super(key: key);

  @override
  _ImageAnimationState createState() => _ImageAnimationState();
}

class _ImageAnimationState extends State<ImageAnimation> with SingleTickerProviderStateMixin{
  late final AnimationController _controller=AnimationController(vsync: this,
  duration:const Duration(seconds: 2))..forward();
  late Animation<Offset> _animation= Tween(
    begin: Offset(0,2),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final width= MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SlideTransition(position: _animation,
    child: SizedBox(
      width: width,
      height: height * 0.99,
      child: CachedNetworkImage(
        imageUrl:"https://cloud.genfty.com/ipfs/QmaDPmMsGnC9mFgFB1YGSDYkQkJPa3bzNAzwPWTrM2zVWH/3.png",
        fit: BoxFit.contain,
    //    placeholder:(context, url) =>kTransparentImage,
      ),
    ),);
  }
}
