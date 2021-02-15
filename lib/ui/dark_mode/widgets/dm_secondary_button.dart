part of 'widgets.dart';

class DmSecondaryButton extends StatelessWidget {
  final double width;
  final double height;
  final Function onTap;
  final Widget child;

  const DmSecondaryButton(
      {Key key, this.width, this.height, this.onTap, this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: dmBgColor,
          border: Border.all(color: dmMainColor, width: 1),
          borderRadius: BorderRadius.circular(15)),
      child:
          FlatButton(splashColor: dmMainColor, onPressed: onTap, child: child),
    );
  }
}
