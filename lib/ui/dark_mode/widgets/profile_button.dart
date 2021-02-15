part of 'widgets.dart';

class ProfileButton extends StatelessWidget {
  final String image;
  final String text;
  final Function onTap;
  ProfileButton(this.image, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(top: 10),
        width: size.width,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white24)),
        child: FlatButton(
            onPressed: onTap,
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover))),
              SizedBox(
                width: 10,
              ),
              Text(text,
                  style: dmWhiteTextFont.copyWith(
                    fontSize: 18,
                  ))
            ])));
  }
}
