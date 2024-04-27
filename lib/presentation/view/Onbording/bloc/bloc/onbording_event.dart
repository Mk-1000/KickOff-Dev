part of 'onbording_bloc.dart';

@immutable
abstract class OnbordingEvent {}
 class changePage extends  OnbordingEvent{
  final page;
  changePage(this.page);
}
 class retour extends  OnbordingEvent{
  final page;
  retour(this.page);
}