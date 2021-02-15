part of 'widgets.dart';

class DmComingSoonCard extends StatelessWidget {
  final Function onTap;
  final int index;
  final List<Movie> movies;

  const DmComingSoonCard({Key key, this.onTap, this.index, this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
              margin: EdgeInsets.only(
                  left: index == 0 ? defaultMargin : 20,
                  right: index == movies.length - 1 ? defaultMargin : 0),
              width: 130,
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color(0xFF5F5F5F).withOpacity(0.7), width: 0.8),
                image: DecorationImage(
                    image: NetworkImage(
                        imageBaseURL + 'w780' + movies[index].posterPath),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(8),
              )),
        ),
        Container(
            height: 38,
            width: 130,
            margin: EdgeInsets.only(left: defaultMargin, top: 2),
            child: Text(
              movies[index].title,
              style: dmWhiteTextFont.copyWith(
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.clip,
            ))
      ],
    );
  }
}
