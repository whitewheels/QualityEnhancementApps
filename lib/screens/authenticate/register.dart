import 'package:flutter/material.dart';
import 'package:quizzler/screens/services/auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.toggleView}) : super(key: key);
  final Function toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _authService = AuthService();
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
        title: Text('Sign Up'),
        actions: <Widget>[
          FloatingActionButton(
            onPressed: () {
              widget.toggleView();
            },
            child: Text('Sign in'),
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
                child: Text('Register'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()){
                    dynamic result = await _authService.registerWithEmailAndPassword(email, password);
                    if (result == null){
                      setState(() {
                        error = 'register error';
                      });
                    }
                  }
                },
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
                child: Text('Cancel'),
                onPressed: () async {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
