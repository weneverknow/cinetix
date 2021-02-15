part of 'widgets.dart';

class DmSelectTableBox extends StatelessWidget {
  final bool isSelected; //apakah sedang di select or tak
  final bool isEnabled; //bisa diselect or tak
  final double width;
  final double height;
  final String text;
  final Function onTap;
  final TextStyle textStyle;

  DmSelectTableBox(
      {Key key,
      this.isSelected = false,
      this.isEnabled = true,
      this.width = 144,
      this.height = 60,
      this.text,
      this.onTap,
      this.textStyle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  color: (isSelected)
                      ? Color(0xFFE4E4E4)
                      : (isEnabled)
                          ? Color(0xFFE4E4E4)
                          : Colors.transparent),
              color: (isSelected)
                  ? dmYellowColor
                  : (isEnabled)
                      ? Colors.transparent
                      : Color(0xFF292929)),
          child: Center(
            child: Text(
              text ?? '-',
              style: isSelected
                  ? dmWhiteTextFont.copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )
                  : (textStyle ?? dmWhiteTextFont).copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }
}
