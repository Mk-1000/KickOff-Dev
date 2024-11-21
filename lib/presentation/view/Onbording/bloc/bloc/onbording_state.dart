part of 'onbording_bloc.dart';

@immutable
abstract class OnbordingState {}

 class OnbordingInitial extends OnbordingState {
  final int page  ; 
  final String img ; 
  final String title ; 
  final String text ; 
  OnbordingInitial(this.page, this.img, this.title, this.text);
 }
