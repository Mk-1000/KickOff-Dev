part of 'complete_signup_bloc.dart';

@immutable
abstract class CompleteSignupEvent {}

class changePage extends CompleteSignupEvent {
  final int page;
  changePage(this.page);
}

class retour extends CompleteSignupEvent {
  final int page;
  final BuildContext context; // Ajouter le BuildContext

  retour(this.page, this.context); // Accepter le BuildContext
}
