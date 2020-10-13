
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/LogInBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInView extends StatefulWidget {
  LogInView({Key key}): super (key: key);

  @override
  LogInBody createState() => LogInBody();

}

class LogInBody extends State<LogInView> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNameController.addListener(() {
      //BlocProvider.of<LoginBloc>(context).add(OnUserNameChange(userName: uname.trim()));

    });

    passwordController.addListener(() {
      //BlocProvider.of<LoginBloc>(context).add(OnUserNameChange(userName: uname.trim()));

    });
  }

  logInBT(bool isSuccess){
    print('isSuccess '+ isSuccess.toString());
    return Container(
      height: 45,
      decoration: BoxDecoration(
          color: isSuccess ? Colors.green:Colors.blue,
          borderRadius: BorderRadius.circular(60)
      ),
      child: FlatButton(
          onPressed: () {
            context.bloc<LoginBloc>().logIn(userNameController.text.trim(), passwordController.text.trim());
           // BlocProvider.of<LoginBloc>(context).add(OnLogInValidate(uName: userNameController.text.trim(), uPass: passwordController.text.trim()));
          },
          child: Container(
            child: Text( isSuccess ? 'Success':'Login',
              style: TextStyle(
              fontSize: 18,
              color: Colors.white,),),
          )
      ),
    );
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
      backgroundColor: Colors.white,
    body: ListView(

      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide: BorderSide(color: Colors.blue)
                ),
                hintText: 'User Name'
            ),
            onChanged: (uname){
              context.bloc<LoginBloc>().onChangeUserName(uname.trim());
            },
            controller: userNameController,
          ),
        ),
        Container(
          padding: EdgeInsets.all(20),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide: BorderSide(color: Colors.blue)
                ),
                hintText: 'Password'
            ),
            onChanged: (pass){
              context.bloc<LoginBloc>().add(OnUserNameChange(userName: pass.trim()));
            },
            controller:  passwordController,
          ),
        ),
        BlocBuilder<LoginBloc, LogInState>(builder: (context, state){

          if ( state is LogedIn){
            print(state.isValid);
            return Container(child: logInBT(state.isValid),padding: EdgeInsets.all(20),);
          }

          return Container(child: logInBT(false),padding: EdgeInsets.all(20),);
        }),
        BlocBuilder<LoginBloc, LogInState>(builder: (context, state){
          if ( state is IsUserNameValide){
            return Container(
              padding: EdgeInsets.all(20),
              child: Text('user name: ' + state.uName),
            );
          }

          if ( state is IsPasswordValide){
            return Container(
              padding: EdgeInsets.all(20),
              child: Text('password: ' + state.pass),
            );
          }

          return Container();
        }),

      ],
    ),
  );




}



}
