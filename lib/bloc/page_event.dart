part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToLoginPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToMainPage extends PageEvent {
  final int bottomNavBarIndex;
  final bool isExpired;
  GoToMainPage({this.bottomNavBarIndex = 0, this.isExpired = false});
  @override
  List<Object> get props => [bottomNavBarIndex, isExpired];
}

class GoToRegistrationPage extends PageEvent {
  final RegistrationData registrationData;
  GoToRegistrationPage(this.registrationData);
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GoToAccountConfirmationPage extends PageEvent {
  final RegistrationData registrationData;
  GoToAccountConfirmationPage(this.registrationData);
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GoToPreferencePage extends PageEvent {
  final RegistrationData registrationData;
  GoToPreferencePage(this.registrationData);
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GoToMovieDetailPage extends PageEvent {
  final Movie movie;
  GoToMovieDetailPage(this.movie);

  @override
  // TODO: implement props
  List<Object> get props => [movie];
}

class GoToSelectSchedulePage extends PageEvent {
  final MovieDetail movieDetail;
  GoToSelectSchedulePage(this.movieDetail);
  @override
  // TODO: implement props
  List<Object> get props => [movieDetail];
}

class GoToSelectSeatPage extends PageEvent {
  final Ticket ticket;
  GoToSelectSeatPage(this.ticket);

  @override
  // TODO: implement props
  List<Object> get props => [ticket];
}

class GoToCheckoutPage extends PageEvent {
  final Ticket ticket;
  GoToCheckoutPage(this.ticket);

  @override
  // TODO: implement props
  List<Object> get props => [ticket];
}

class GoToSuccessPage extends PageEvent {
  final Ticket ticket;
  final FlutixTransaction flutixTransaction;
  final PageEvent pageEvent;
  GoToSuccessPage(this.ticket, this.flutixTransaction, {this.pageEvent});

  @override
  // TODO: implement props
  List<Object> get props => [ticket, flutixTransaction];
}

class GoToTicketDetailPage extends PageEvent {
  final Ticket ticket;
  final PageEvent pageEvent;
  GoToTicketDetailPage(this.ticket, {this.pageEvent});

  @override
  // TODO: implement props
  List<Object> get props => [ticket];
}

class GoToProfilePage extends PageEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GoToEditProfilePage extends PageEvent {
  final Users users;
  GoToEditProfilePage(this.users);
  @override
  // TODO: implement props
  List<Object> get props => [users];
}

class GoToTopUpPage extends PageEvent {
  final PageEvent pageEvent;
  GoToTopUpPage(this.pageEvent);

  @override
  // TODO: implement props
  List<Object> get props => [pageEvent];
}

class GoToWalletPage extends PageEvent {
  final PageEvent pageEvent;
  GoToWalletPage(this.pageEvent);
  @override
  // TODO: implement props
  List<Object> get props => [pageEvent];
}

class GoToComingSoonDetailPage extends PageEvent {
  final Movie movie;
  final MovieDetail movieDetail;
  final List<Credit> credits;
  GoToComingSoonDetailPage(this.movie, {this.movieDetail, this.credits});

  @override
  // TODO: implement props
  List<Object> get props => [movie];
}

class GoToTicketToday extends PageEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
