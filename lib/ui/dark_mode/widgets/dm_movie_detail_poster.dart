part of 'widgets.dart';

class DmMovieDetailPoster extends StatelessWidget {
  final String picture;
  DmMovieDetailPoster(this.picture);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 160,
        height: 202,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                image: NetworkImage(picture), fit: BoxFit.cover)));
  }
}
