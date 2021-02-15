part of 'widgets.dart';

class DmKonfirmasiTiketDetail extends StatelessWidget {
  final double width;
  final double margin;
  final String label;
  final String text;
  final Color labelColor;
  final TextStyle textStyle;

  const DmKonfirmasiTiketDetail(
      {Key key,
      this.width,
      this.margin = 20,
      this.label,
      this.text,
      this.labelColor,
      this.textStyle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: dmGreyTextFont.copyWith(
                    color: labelColor ?? Color(0xFFADADAD),
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
            Text(text,
                style: textStyle ??
                    dmWhiteTextFont.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.clip)
          ],
        ));
  }
}
