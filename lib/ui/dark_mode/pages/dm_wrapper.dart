part of 'dm_pages.dart';

class DmWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User firebaseUser = Provider.of<User>(context);

    if (firebaseUser == null) {
      getPref().then((value) {
        if (value) {
          if (!(prevPageEvent is GoToLoginPage)) {
            prevPageEvent = GoToLoginPage();
            context.bloc<PageBloc>().add(GoToLoginPage());
          }
        } else {
          if (!(prevPageEvent is GoToSplashPage)) {
            prevPageEvent = GoToSplashPage();
            context.bloc<PageBloc>().add(GoToSplashPage());
          }
        }
      });
    } else {
      if (!(prevPageEvent is GoToMainPage)) {
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
        context.bloc<TicketBloc>().add(GetTickets(firebaseUser.uid));
        prevPageEvent = GoToMainPage();
        //context.bloc<PageBloc>().add(GoToMainPage());
        context.bloc<PageBloc>().add(GoToMainPage());
      }
    }

    return BlocBuilder<PageBloc, PageState>(
        builder: (_, pageState) => (pageState is OnSplashPage)
            ? DmSplashPage()
            : (pageState is OnLoginPage)
                ? DmSignInPage()
                : (pageState is OnRegistrationPage)
                    ? DmSignUpPage(registrationData: pageState.registrationData)
                    : (pageState is OnPreferencePage)
                        ? DmPreferencePage(
                            registrationData: pageState.registrationData)
                        : (pageState is OnAccountConfirmationPage)
                            ? DmAccountConfirmationPage(
                                registrationData: pageState.registrationData)
                            : (pageState is OnMovieDetailPage)
                                ? DmMovieDetailPage(pageState
                                    .movie) //MovieDetailPage(pageState.movie)
                                : (pageState is OnSelectSchedulePage)
                                    ? DmSelectSchedulePage(pageState
                                        .movieDetail) //SelectSchedulePage(pageState.movieDetail)
                                    : (pageState is OnSelectSeatPage)
                                        ? DmSelectSeatPage(pageState.ticket)
                                        : (pageState is OnCheckoutPage)
                                            ? DmCheckoutPage(pageState.ticket)
                                            : (pageState is OnSuccessPage)
                                                ? DmSuccessPage(
                                                    pageState.ticket,
                                                    pageState.flutixTransaction,
                                                    pageEvent:
                                                        pageState.pageEvent,
                                                  )
                                                : (pageState
                                                        is OnTicketDetailPage)
                                                    ? DmTicketDetailPage(
                                                        pageState.ticket,
                                                        pageEvent:
                                                            pageState.pageEvent)
                                                    : (pageState
                                                            is OnProfilePage)
                                                        ? DmProfilePage()
                                                        : (pageState
                                                                is OnEditProfilePage)
                                                            ? DmEditProfilePage(
                                                                pageState.users)
                                                            : (pageState
                                                                    is OnTopUpPage)
                                                                ? DmTopUpPage(
                                                                    pageState
                                                                        .pageEvent)
                                                                : (pageState
                                                                        is OnWalletPage)
                                                                    ? DmMyWalletPage(
                                                                        pageState
                                                                            .pageEvent)
                                                                    : (pageState
                                                                            is OnComingSoonDetailPage)
                                                                        ? DmComingSoonDetailPage(
                                                                            pageState
                                                                                .movie,
                                                                            movieDetail: pageState
                                                                                .movieDetail,
                                                                            credits: pageState
                                                                                .credits)
                                                                        : (pageState
                                                                                is OnTicketToday)
                                                                            ? DmTicketToday()
                                                                            : DmMainPage(
                                                                                bottomNavBarIndex: (pageState as OnMainPage).bottomNavBarIndex,
                                                                                isExpired: (pageState as OnMainPage).isExpired));
  }
}
