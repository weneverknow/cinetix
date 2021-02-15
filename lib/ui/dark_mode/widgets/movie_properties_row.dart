part of 'widgets.dart';

class MoviePropertiesRow extends StatelessWidget {
  final String title;
  final String desc;
  final TextStyle titleTextStyle;
  final TextStyle descTextStyle;
  MoviePropertiesRow(
      {this.title, this.desc, this.titleTextStyle, this.descTextStyle});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title ?? '',
            style: titleTextStyle != null
                ? titleTextStyle
                : dmGreyTextFont.copyWith(
                    fontSize: 10, fontWeight: FontWeight.w700)),
        Container(
          height: 26,
          width: 85,
          child: Text(desc ?? '-',
              style: descTextStyle != null
                  ? descTextStyle
                  : dmWhiteTextFont.copyWith(
                      fontSize: 10, fontWeight: FontWeight.w700),
              maxLines: 2,
              overflow: TextOverflow.clip),
        )
      ],
    );
  }
}
