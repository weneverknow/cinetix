part of 'widgets.dart';

class DmMovieDetailCast extends StatelessWidget {
  final List<Credit> credits;
  final Credit credit;
  DmMovieDetailCast({this.credits, this.credit});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: 70,
            height: 80,
            margin: EdgeInsets.only(left: (credit == credits.first) ? 0 : 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: NetworkImage(
                        imageBaseURL + 'w780' + credit.profilePath),
                    fit: BoxFit.cover))),
        SizedBox(height: 2),
        Padding(
          padding: EdgeInsets.only(left: (credit == credits.first) ? 0 : 15),
          child: Text(
            credit.name,
            style: dmWhiteTextFont.copyWith(fontSize: 10),
            maxLines: 2,
            overflow: TextOverflow.clip,
          ),
        )
      ],
    );
  }
}
