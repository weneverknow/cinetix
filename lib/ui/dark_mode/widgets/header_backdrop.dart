part of 'widgets.dart';

class HeaderBackdrop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black.withOpacity(0.8), Colors.transparent])
                .createShader(Rect.fromLTRB(0, 0, 90, 90));
          },
          blendMode: BlendMode.dstIn,
          child: ClipPath(
            clipper: HeaderClipper(),
            child: Container(
              width: size.width,
              height: 170,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    dmMainColor.withOpacity(0.9),
                    dmMainColor.withOpacity(0.2),
                    dmMainColor.withOpacity(0.1)
                  ])),
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 90),
          child: Container(
              width: size.width,
              height: 170,
              color: dmBgColor.withOpacity(0.1)),
        ),
      ],
    );
  }
}

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 70);
    path.quadraticBezierTo(
        size.width * 0.4, size.height, size.width * 0.7, size.height - 90);
    path.quadraticBezierTo(
        size.width * 0.86, size.height - 130, size.width, size.height - 150);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
