part of 'widgets.dart';

class CircleButton extends CustomPainter {
  final double progress;
  CircleButton({this.progress = 0});
  @override
  void paint(Canvas canvas, Size size) {
    //draw the circle
    Paint baseCircle = Paint()
      ..strokeWidth = 7
      ..color = Color(0xFFB4B4B4)
      ..style = PaintingStyle.stroke;
    Paint completeArc = Paint()
      ..strokeWidth = 7
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - 7;
    double angle = 2 * pi * (this.progress / 100);
    canvas.drawCircle(center, radius, baseCircle);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
