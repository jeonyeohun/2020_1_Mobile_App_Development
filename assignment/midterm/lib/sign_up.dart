import 'package:flutter/material.dart';
import 'app.dart';

class signUpPage extends StatefulWidget {
  @override
  _signUpPageState createState() => _signUpPageState();
}

class _signUpPageState extends State<signUpPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SignUpForm(),
    );
  }
}

class SignUpForm extends StatefulWidget{
  SignUpFormState createState(){
    return SignUpFormState();
  }
}

class SignUpFormState extends State<SignUpForm>{
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context){
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        children: <Widget>[
          SizedBox(height: 90),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Username';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Username',
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Password';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            obscureText: true,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Confirm Password';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Confirm Password',
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter Address';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Email Address',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ButtonBar(
              children: <Widget>[
                RaisedButton(
                  padding: const EdgeInsets.all(16.0),
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  child: Text('SIGN UP'),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
