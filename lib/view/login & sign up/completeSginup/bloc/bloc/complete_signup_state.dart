part of 'complete_signup_bloc.dart';

@immutable
abstract class CompleteSignupState {}

 class CompleteSignupInitial extends CompleteSignupState {
  final int page ;
  CompleteSignupInitial(this.page); 
 }
