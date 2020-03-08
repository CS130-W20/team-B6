import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:outlook/managers/firebase_manager.dart';
import 'package:outlook/states/user_state.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

/// The actual form layout for the user to edit their profile info.
class EditProfileForm extends StatefulWidget {
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {

  File _image = null;

  Future uploadFile(UserState userState) async {
    StorageReference storage = FirebaseManager.getInstance().ref().child('propic_${userState.username}.jpg');
    StorageUploadTask uploadTask = storage.putFile(_image);
    await uploadTask.onComplete;
    storage.getDownloadURL().then((fileURL) {
      UserState.setProfilePic(fileURL);
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void saveForm() {
      UserState userState = UserState.getState();
      if (_fbKey.currentState.saveAndValidate()) {
        Navigator.pop(context);
        _fbKey.currentState.value.forEach((key, val) {
          switch(key) {
            case 'firstname':
              if (userState.firstname != val) {
                UserState.setFirstName(val);
              }
              break;
            case 'lastname':
              if (userState.lastname != val) {
                UserState.setLastName(val);
              }
              break;
            case 'email':
              if (userState.email != val) {
                UserState.setEmail(val);
              }
              break;
            case 'description':
              if (userState.description != val) {
                UserState.setDescription(val);
              }
              break;
          }
        });

        if (_image != null) {
          uploadFile(userState);
        }
      } else {
        _fbKey.currentState.reset();
      }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: UserState.getListenable(),
        builder: (context, userBox, child) {
          UserState userState = UserState.getState();
          return Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                  children: <Widget>[
                    FormBuilder(
                        key: _fbKey,
                        autovalidate: true,
                        initialValue: {
                          'firstname': userState.firstname,
                          'lastname': userState.lastname,
                          'email': userState.email,
                          'description': userState.description
                        },
                        child: Column(
                            children: <Widget>[
                              FormBuilderTextField(
                                attribute: 'firstname',
                                validators: [FormBuilderValidators.required()],
                                decoration: InputDecoration(labelText: 'First Name'),
                              ),
                              FormBuilderTextField(
                                attribute: 'lastname',
                                validators: [FormBuilderValidators.required()],
                                decoration: InputDecoration(labelText: 'Last Name'),
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
                              Padding(
                                padding: EdgeInsets.only(top: 30),
                                child: Column(
                                  children: <Widget>[
                                    Text('Add Profile Picture', style: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5))),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10),
                                      child: FloatingActionButton(
                                          onPressed: getImage,
                                          child: Icon(Icons.add_a_photo),
                                        )
                                    )
                                  ]
                                )
                              )
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
                                      onPressed: () => saveForm()
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