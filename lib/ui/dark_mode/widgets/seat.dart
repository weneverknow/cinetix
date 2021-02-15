part of 'widgets.dart';

class Seat extends StatelessWidget {
  final Function onTap;
  final String text;
  final bool isSelected;
  final bool isEnabled;
  Seat(this.text, this.isSelected, this.onTap, this.isEnabled);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 50,
          height: 60,
          child: Stack(
            children: [
              Container(
                  height: 25,
                  decoration: BoxDecoration(
                      border: Border.all(color: dmBgColor, width: 3),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                      color: isEnabled
                          ? (isSelected ? dmMainColor : Colors.white)
                          : Color(0xFF292929)),
                  child: Center(
                      child: Text(text,
                          style: dmWhiteTextFont.copyWith(
                              color: Colors.black,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)))),
              Positioned(
                top: 13,
                left: 0,
                child: Container(
                    height: 30,
                    width: 13,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        color: isEnabled
                            ? (isSelected ? dmMainColor : Colors.white)
                            : Color(0xFF292929),
                        border: Border.all(color: dmBgColor, width: 2))),
              ),
              Positioned(
                top: 13,
                right: 0,
                child: Container(
                    height: 30,
                    width: 13,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                        color: isEnabled
                            ? (isSelected ? dmMainColor : Colors.white)
                            : Color(0xFF292929),
                        border: Border.all(color: dmBgColor, width: 2))),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    height: 24,
                    decoration: BoxDecoration(
                        color: isEnabled
                            ? (isSelected ? dmMainColor : Colors.white)
                            : Color(0xFF292929),
                        border: Border.all(color: dmBgColor, width: 2),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
