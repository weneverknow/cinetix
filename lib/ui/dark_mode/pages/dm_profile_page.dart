part of 'dm_pages.dart';

class DmProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToMainPage());
        return;
      },
      child: Scaffold(
          body: Stack(
        children: [
          Container(color: dmMainColor),
          SafeArea(
            child: Container(color: dmBgColor),
          ),
          SafeArea(
              child: Stack(
            children: [
              HeaderBackdrop(),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: BlocBuilder<UserBloc, UserState>(
                      builder: (context, userState) {
                    if (userState is UserLoaded) {
                      if (imageFileToUpload != null) {
                        uploadImage(imageFileToUpload).then((value) {
                          imageFileToUpload = null;
                          context
                              .read<UserBloc>()
                              .add(UpdateData(profileImage: value));
                        });
                      }
                      Users users = userState.users;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 22),
                          GestureDetector(
                              onTap: () {
                                context.read<PageBloc>().add(GoToMainPage());
                              },
                              child: BackIcon()),
                          headerProfile(size, users),
                          SizedBox(height: 50),
                          ProfileButton('assets/icons/account_circle_dm.png',
                              'UBAH DATA PROFIL', () {
                            context
                                .read<PageBloc>()
                                .add(GoToEditProfilePage(users));
                          }),
                          ProfileButton(
                              'assets/icons/ic_topup_dm.png', 'ISI SALDO', () {
                            context
                                .read<PageBloc>()
                                .add(GoToTopUpPage(GoToProfilePage()));
                          }),
                          ProfileButton(
                              'assets/icons/account_balance_wallet_dm.png',
                              'RIWAYAT TRANSAKSI', () {
                            context
                                .read<PageBloc>()
                                .add(GoToWalletPage(GoToProfilePage()));
                          }),
                          ProfileButton('assets/icons/translate_dm.png',
                              'UBAH BAHASA', () {}),
                          ProfileButton('assets/icons/verified_user_dm.png',
                              'BANTUAN', () {}),
                          ProfileButton('assets/icons/thumb_up_dm.png',
                              'BERI NILAI', () {}),
                          ProfileButton('assets/icons/logout_dm.png', 'KELUAR',
                              () async {
                            await AuthServices.signOut();
                          })
                        ],
                      );
                    } else {
                      return SizedBox();
                    }
                  }))
            ],
          ))
        ],
      )),
    );
  }

  Widget headerProfile(Size size, Users users) {
    return Container(
        margin: EdgeInsets.only(top: 22),
        width: size.width,
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1),
                    image: DecorationImage(
                        image: (users.profilePicture ?? '') == ''
                            ? AssetImage('assets/images/user_pic.png')
                            : NetworkImage(users.profilePicture)))),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 2),
              child: Text(users.name,
                  style: dmWhiteTextFont.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            Text(
              NumberFormat.currency(
                      locale: 'id_ID', decimalDigits: 0, symbol: 'IDR ')
                  .format(users.balance),
              style: dmGreyTextFont.copyWith(
                  fontSize: 10, fontWeight: FontWeight.w300),
            )
          ],
        ));
  }
}
