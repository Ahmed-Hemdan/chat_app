part of 'Cubit.dart';

@immutable
abstract class AppCubitState {}

class AppCubitInitial extends AppCubitState {}

class ChangeCurrentIndexForScreens extends AppCubitState {}

class CreateUserToFirebase extends AppCubitState {}

class CheckEmailVerification extends AppCubitState {}

class RegisterNewUserInOuthentication extends AppCubitState {}

class SignIn extends AppCubitState {}

class GetAllUser extends AppCubitState {}

class GetTheNameOfUser extends AppCubitState {}

class CreatConversationInCollection extends AppCubitState {}

class UploadImageToFirebase extends AppCubitState{}