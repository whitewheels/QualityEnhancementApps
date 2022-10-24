import 'package:flutter/material.dart';
import 'package:quizzler/models/user_in_app.dart';
import 'package:quizzler/screens/authenticate/authenticate.dart';
import 'package:quizzler/screens/authenticate/register.dart';
import 'package:quizzler/screens/services/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  final Function toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _authenticate = AuthService();
  final _formKey = GlobalKey<FormState>();
  // text field
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to the app'),
        actions: <Widget>[
          FloatingActionButton(
            onPressed: () {
              widget.toggleView();
            },
            child: Text('Sign up'),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              TextFormField(
                validator: (val) => val!.isEmpty? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20,),
              TextFormField(
                validator: (val) => val!.length < 6 ? 'Enter an password more than 6 chars' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                child: Text('sign in with email'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    dynamic result = await _authenticate
                        .signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'incorrect credentials';
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 12,),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
              ElevatedButton(
                child: Text('Sign in anonymous'),
                onPressed: () async {
                  dynamic result = await _authenticate.signInAnon();
                  if (result == null){
                    print('error signing in');
                  } else {
                    print('signed in');
                    UserInApp userInApp = result;
                    print(userInApp.uid);
                  }
                },
              ),
              ElevatedButton(
                  child: Text('sign in with email and no password'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic result = await _authenticate
                          .signInWithEmailAndLink(email);
                      if (result == null) {
                        setState(() {
                          error = 'mail sent';
                        });
                      }
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
