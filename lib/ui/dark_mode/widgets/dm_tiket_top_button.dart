part of 'widgets.dart';

class DmTiketTopButton extends StatelessWidget {
  final Function onTap;
  final double width;
  final Color color;
  final String text;
  final bool isExpired;

  const DmTiketTopButton(
      {Key key,
      this.onTap,
      this.width,
      this.color,
      this.text,
      this.isExpired = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: width,
          height: 35,
          decoration: BoxDecoration(
              color: color,
              borderRadius: isExpired
                  ? BorderRadius.only(topLeft: Radius.circular(10))
                  : BorderRadius.only(topRight: Radius.circular(10))),
          child: Center(
              child: Text(text,
                  style: dmWhiteTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w700)))),
    );
  }
}
