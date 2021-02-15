part of 'widgets.dart';

class DmDefaultCircleButton extends StatelessWidget {
  final double width;
  final double height;
  final Color boxColor;
  final Color borderColor;
  final IconData icon;
  final double iconSize;
  final Color iconColor;

  const DmDefaultCircleButton({Key key, this.width=50, this.height=50, this.boxColor, this.borderColor, this.icon=Icons.arrow_forward_ios_outlined, this.iconSize=16, this.iconColor}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: borderColor),
            color: boxColor),
        child: Center(
            child: Icon(
          icon,
          size: iconSize,
          color: iconColor,
        )));
  }
}
