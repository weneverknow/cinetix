part of 'widgets.dart';

class DmDefaultButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Function onTap;
  final Widget child;

  const DmDefaultButton(
      {Key key, this.width, this.height, this.color, this.onTap, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
      child: FlatButton(splashColor: dmBgColor, onPressed: onTap, child: child),
    );
  }
}
