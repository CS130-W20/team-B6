import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:outlook/managers/data_manager.dart';
import 'package:http/http.dart';
import './signup.dart';
import 'package:outlook/main.dart';
import 'dart:convert';
import 'package:outlook/states/auth_state.dart';
import 'package:outlook/states/user_state.dart';

final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

class LogInPage extends StatefulWidget {

  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogInPage> {

  bool submitted = false;
  Response response;

  void logIn() async {
    if (_fbKey.currentState.saveAndValidate()) {
      setState(() => submitted = true);
      var credentials = _fbKey.currentState.value;
      Response logInResponse = await DataManager.login(credentials['username'], credentials['password']);
      if (logInResponse != null && logInResponse.statusCode == 200) {
        var responseBody = jsonDecode(logInResponse.body);
        UserState.setUserName(credentials['username']);
        AuthState.setPassword(credentials['password']);
        UserState.setId(responseBody['id']);
        AuthState.setToken(responseBody['token']);
        // move to main content
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Outlook()));
      }
      setState(() {
        response = logInResponse;
        submitted = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget logInButtonContent = Text('Log In',
        style: TextStyle(
            color: Colors.white,
            fontSize: 16
        )
    );
    Color logInButtonColor = Colors.blue;
    if (submitted) {
      logInButtonContent = CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
      );
    } else if (response != null && response.statusCode == 200) {
      logInButtonContent = Icon(Icons.check, color: Colors.white);
      logInButtonColor = Colors.green;
    }

    return Scaffold(
        body: FormBuilder(
            key: _fbKey,
            autovalidate: true,
            child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Outlook', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900)),
                      FormBuilderTextField(
                          attribute: 'username',
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: 'Username'),
                          maxLines: 1
                      ),
                      FormBuilderTextField(
                          attribute: 'password',
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: 'Password'),
                          maxLines: 1,
                          obscureText: true
                      ),
                      Padding(
                          padding: EdgeInsets.all(15),
                          child: RaisedButton(
                            color: logInButtonColor,
                            child: Padding(
                                padding: EdgeInsets.all(12),
                                child: logInButtonContent
                            ),
                            onPressed: logIn,
                          )
                      ),
                      FlatButton(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text("Don't have an account? Sign up"),
                        ),
                        onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage()))
                      ),
                      Text(response == null || response.statusCode == 200 ?
                      '' : response.statusCode.toString() + ': ' + response.body.toString(),
                          style: TextStyle(color: Colors.red)
                      )
                    ]
                )
            )
        )
    );
  }
}