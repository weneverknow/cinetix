part of 'widgets.dart';

class DmLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        height: 45,
        alignment: Alignment.center,
        child: RichText(
          text: TextSpan(children: <TextSpan>[
            TextSpan(
                text: 'Cine',
                style: TextStyle(
                    color: dmMainColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 24)),
            TextSpan(
                text: 'Tix',
                style: TextStyle(
                    color: dmRedColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 30))
          ]),
        ));
  }
}
