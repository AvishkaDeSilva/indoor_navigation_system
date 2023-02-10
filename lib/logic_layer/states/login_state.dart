import 'package:equatable/equatable.dart';

abstract class LoginState  {
}

class InitialState extends LoginState {
}

class LoginLoadingState extends LoginState{
}

class LoginSuccessState extends LoginState{
}

class LoginFailedState extends LoginState{
}