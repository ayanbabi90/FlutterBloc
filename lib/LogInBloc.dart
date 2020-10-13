
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';


class LogInEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

}


class OnUserNameChange extends LogInEvent {
  final String userName;

  OnUserNameChange({ @required this.userName }) : assert(userName != null);

  @override
  List<Object> get props => [userName];
}

class OnPasswordChange extends LogInEvent {
  final String password;

  OnPasswordChange({ @required this.password }) : assert(password != null);

  @override
  List<Object> get props => [password];
}

class OnLogInValidate extends LogInEvent {

  final String uName;
  final String uPass;

  OnLogInValidate({ @required this.uName, @required this.uPass }) : assert(uName != null && uPass != null);

  @override
  List<Object> get props => [validate()];

  bool validate(){
    if (uName == 'ayan' && uPass == 'chk123'){
      return true;
    }
    return false;
  }
}



class LogInState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class LogedIn extends LogInState {
  final String uName;
  final String uPass;
  final bool isValid;

  LogedIn({ @required this.uName, @required this.uPass , @required this.isValid}) : assert(uName != null && uPass != null);

  @override
  List<Object> get props => [isValid,uName,uPass];


}

class LogedOut extends LogInState {

}

class IsUserNameValide extends LogInState {
  final String uName;

  IsUserNameValide({ @required this.uName }) : assert(uName != null);

  @override
  List<Object> get props => [uName];

  bool isValid(){
    return false;
  }

}

class IsPasswordValide extends LogInState {
  final String pass;

  IsPasswordValide({ @required this.pass }) : assert(pass != null);

  @override
  List<Object> get props => [pass];

  bool isValid(){
    return false;
  }

}


class LoginBloc extends Bloc<LogInEvent, LogInState> {

  LoginBloc(): super(LogedOut());

  void onChangeUserName(String name){
    add(OnUserNameChange(userName: name));
  }

  void onChangePassword(String password){
    add(OnPasswordChange(password: password));
  }

  void logIn(String name, String pssword){
    add(OnLogInValidate(uName: name, uPass: pssword));
  }

  @override
  Stream<LogInState> mapEventToState(LogInEvent event) async*{
    if (event is OnUserNameChange){
      yield IsUserNameValide(uName: event.userName);
    }else if (event is OnPasswordChange){
      yield IsPasswordValide(pass: event.password);
    }else if (event is OnLogInValidate) {
      print('uName ' + event.uName + ' uPass: ' + event.uPass);
      if (event.uName == 'ayan' && event.uPass == 'chk123'){
        yield LogedIn(uName: event.uName, uPass: event.uPass, isValid: true);
      }else{
        yield LogedIn(uName: event.uName, uPass: event.uPass, isValid: false);
      }
    }
  }


  @override
  void onTransition(Transition<LogInEvent, LogInState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
    print(transition);

  }

}