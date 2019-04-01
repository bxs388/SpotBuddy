import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login/prop-config.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:login/src/profile/Controller/updateController.dart';
import 'package:login/analtyicsController.dart';
import 'package:login/userController.dart';

class UpdateProfilePage extends StatefulWidget {

  UpdateProfilePage({
    Key key,
    this.analControl,
    @required this.user
  }) : super(key: key);

  final userController user;
  final analyticsController analControl;

  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends StateMVC<UpdateProfilePage> {
  _UpdateProfilePageState() : super(Controller()){
    _con = Controller.con;
  }
  Controller _con;
  
  @override
  Widget build(BuildContext context) {
    widget.analControl.currentScreen('update_profile', 'updateProfileOver');
    return Scaffold(
      appBar: AppBar(
        title: Text(Prompts.updateYourProfile),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: Form(
            key: _con.formkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    hintText: Userinfo.fullName,
                    labelText: widget.user.name
                  ),
                  maxLength: 32,
                  validator: _con.validateName,
                  onSaved: (input) => _con.set_name = input,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: Userinfo.age,
                    labelText: widget.user.age
                  ),
                  maxLength: 2,
                  validator: _con.validateAge,
                  onSaved: (input) => _con.set_age = input,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio (
                      value: 0,
                      groupValue: _con.genderBtnValue,
                      onChanged: handleGenderValueChange,
                    ),
                    Text(Userinfo.gender0),
                    Radio (
                      value: 1,
                      groupValue: _con.genderBtnValue,
                      onChanged: handleGenderValueChange,
                    ),
                    Text(Userinfo.gender1),
                    Radio (
                      value: 2,
                      groupValue: _con.genderBtnValue,
                      onChanged: handleGenderValueChange,
                    ),
                    Text(Userinfo.gender2),
                  ]
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: Userinfo.occupation,
                    labelText: widget.user.occupation
                  ),
                  maxLength: 32,
                  validator: _con.validateOccupation,
                  onSaved: (input) => _con.set_occupation = input,
                ),
                TextFormField(
                    decoration: InputDecoration(
                      hintText: Userinfo.mobileNumber,
                      labelText: widget.user.mobile
                    ),
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: _con.validateMobile,
                    onSaved: (input) => _con.set_mobile = input,
                ),
                SizedBox(height: 15.0),
                RaisedButton(
                  onPressed: () {
                    widget.analControl.sendAnalytics('profileUpdate');
                    _con.update(widget.user);
                  },
                  child: Text(Userinfo.update),
                )
              ],
            ),
          )
        )
      )
    );
  }
  void handleGenderValueChange(int value) {
    setState(() {
      _con.set_gender = value;
      print(Userinfo.gender + " ${_con.genderBtnValue}");
    });
  }
}