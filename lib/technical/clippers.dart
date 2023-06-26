import 'package:flutter/cupertino.dart';

class clippers extends CustomClipper<Path>{
  @override
  getClip(Size size) {
    Path path=Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width/4, size.height
        - 40, size.width/2, size.height-20);
    path.quadraticBezierTo(3/4*size.width, size.height,
        size.width, size.height-30);
    path.lineTo(size.width, 0);
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {

    return true;
  }

}
