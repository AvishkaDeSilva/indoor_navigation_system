import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data_layer/models/user.dart';
import '../../data_layer/repositories/user_repositiory.dart';
import '../states/login_state.dart';

class LoginCubit extends Cubit<LoginState>{
  final DatabaseRepository databaseRepository;
  LoginCubit({required this.databaseRepository}): super(InitialState());
  
  void onLogin(String username) async{
    emit(LoginLoadingState());
    bool isUserExist = await databaseRepository.retrieveUserData(username);
    if(isUserExist){
      emit(LoginFailedState());
    }
    else{
      try{
        await databaseRepository.saveUserData(UserModel(username: username));
      }
      catch(e){
        emit(LoginFailedState());
      }
      emit(LoginSuccessState());
    }
  }
}