part of 'widgets.dart';

class CircleButtonCard extends StatefulWidget {
  //CircleButtonCard({this.child, this.animation});
  @override
  _CircleButtonCardState createState() => _CircleButtonCardState();
}

class _CircleButtonCardState extends State<CircleButtonCard> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: CircleButton(),
      child: Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        child: Icon(
          Icons.arrow_forward_ios,
          color: Color(0xFFB4B4B4),
          size: 40,
        ),
      ),
    );
  }
}
