part of 'widgets.dart';

class DmPromoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int discount;
  final Color color;
  DmPromoCard({this.title, this.subtitle, this.discount, this.color});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24),
      child: SizedBox(
        width: 230,
        height: 60,
        child: Stack(
          children: [
            Container(
              width: 230,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: color),
            ),
            ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.white.withOpacity(0.6),
                      color.withOpacity(0.1)
                    ]).createShader(Rect.fromLTRB(0, 0, 170, 90));
              },
              child: Container(
                width: 230,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.white.withOpacity(0.7),
                          Color(0xFF01B075)
                        ])),
              ),
            ),
            Container(
              width: 230,
              height: 60,
              padding: EdgeInsets.only(left: 10, right: 21),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: dmWhiteTextFont.copyWith(fontSize: 14),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        subtitle,
                        style: dmWhiteTextFont.copyWith(
                            fontSize: 8, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Text(
                    '$discount%',
                    style: TextStyle(
                        color: Color(0xFF082F22),
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
