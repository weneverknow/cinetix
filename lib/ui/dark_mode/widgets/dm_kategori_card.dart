part of 'widgets.dart';

class DmKategoriCard extends StatelessWidget {
  final String genre;
  DmKategoriCard({this.genre});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.1)
                ]).createShader(Rect.fromLTRB(3, 3, 0, 0));
          },
          blendMode: BlendMode.dstIn,
          child: Container(
            width: 50,
            height: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      dmMainColor.withOpacity(0.6),
                      dmRedColor.withOpacity(0.4)
                    ]),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white.withOpacity(0.6))),
          ),
        ),
        Container(
          width: 50,
          height: 70,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Image.asset(
                  'assets/icons/ic_${genre.toLowerCase()}_dm.png',
                  width: 26,
                  height: 36,
                ),
              ),
              Text(
                genre,
                style: dmWhiteTextFont.copyWith(fontSize: 12),
              )
            ],
          ),
        )
      ],
    );
  }
}
