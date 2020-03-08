import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:outlook/login/login.dart';
import 'package:outlook/managers/data_manager.dart';
import 'dart:convert';
import 'package:http/http.dart';
import './login.dart';

final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

class SignUpPage extends StatefulWidget {

  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {

  bool submitted = false;
  bool submittedSuccess = false;
  Response response;

  void signUp(BuildContext context) async {
    if (_fbKey.currentState.saveAndValidate()) {
      setState(() => submitted = true);
      Response signUpResponse = await DataManager.signup(jsonEncode(_fbKey.currentState.value));
      if (signUpResponse != null && signUpResponse.statusCode == 200) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LogInPage()));
      }
      setState(() {
        response = signUpResponse;
        submitted = false;
        submittedSuccess = response != null && response.statusCode == 200;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget signUpButtonContent = Text('Sign Up',
        style: TextStyle(
            color: Colors.white,
            fontSize: 16
        )
    );
    Color signUpButtonColor = Colors.black;
    if (submitted) {
      signUpButtonContent = CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
      );
    } else if (submittedSuccess) {
      signUpButtonContent = Icon(Icons.check, color: Colors.white);
      signUpButtonColor = Colors.green;
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
                          attribute: 'firstname',
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: 'First Name'),
                          maxLines: 1
                      ),
                      FormBuilderTextField(
                          attribute: 'lastname',
                          validators: [FormBuilderValidators.required()],
                          decoration: InputDecoration(labelText: 'Last Name'),
                          maxLines: 1
                      ),
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

                            color: signUpButtonColor,
                            child: Padding(
                                padding: EdgeInsets.all(12),
                                child: signUpButtonContent
                            ),
                            onPressed: () => submittedSuccess ? null : signUp(context),
                          )
                      ),
                      FlatButton(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text('Have an account? Log in'),
                          ),
                          onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogInPage()))
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