part of 'Cubit.dart';

@immutable
abstract class AppCubitState {}

class AppCubitInitial extends AppCubitState {}

class ChangeCurrentIndexForScreens extends AppCubitState {}

class CreateUserToFirebase extends AppCubitState {}

class CheckEmailVerification extends AppCubitState {}
