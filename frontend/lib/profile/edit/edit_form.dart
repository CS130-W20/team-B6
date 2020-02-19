import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:outlook/user_state.dart';
import 'package:provider/provider.dart';

final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

class EditProfileForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(
      builder: (context, userState, child) {
        return Padding(
          padding: EdgeInsets.all(15),
          child: Column(
              children: <Widget>[
                FormBuilder(
                    key: _fbKey,
                    autovalidate: true,
                    initialValue: {
                      'name': userState.name,
                      'email': userState.email,
                      'description': userState.description
                    },
                    child: Column(
                        children: <Widget>[
                          FormBuilderTextField(
                            attribute: 'name',
                            validators: [FormBuilderValidators.required()],
                            decoration: InputDecoration(labelText: 'Name'),
                          ),
                          FormBuilderTextField(
                            attribute: 'email',
                            validators: [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.email()
                            ],
                            decoration: InputDecoration(labelText: 'Email'),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          FormBuilderTextField(
                            attribute: 'description',
                            validators: [],
                            decoration: InputDecoration(labelText: 'About Me'),
                          ),
                        ]
                    )
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: FlatButton(
                                  child: Padding(
                                      padding: EdgeInsets.all(7),
                                      child: Text('Cancel', style: TextStyle(fontSize: 16))
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              RaisedButton(
                                  color: Colors.blue,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text('Save', style: TextStyle(color: Colors.white, fontSize: 16))
                                  ),
                                  onPressed: () {
                                    if (_fbKey.currentState.saveAndValidate()) {
                                      Navigator.pop(context);
                                      _fbKey.currentState.value.forEach((key, val) {
                                        switch(key) {
                                          case 'name':
                                            if (userState.name != val) {
                                              userState.setName(val);
                                            }
                                            break;
                                          case 'email':
                                            if (userState.email != val) {
                                              userState.setEmail(val);
                                            }
                                            break;
                                          case 'description':
                                            if (userState.description != val) {
                                              userState.setDescription(val);
                                            }
                                            break;
                                        }
                                      });
                                    } else {
                                      _fbKey.currentState.reset();
                                    }
                                  }
                              )
                            ]
                        )
                    )
                )
              ]
          )
        );
      }
    );
  }
}