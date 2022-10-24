import 'package:flutter/material.dart';
import 'package:quizzler/screens/services/auth.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('home page'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FloatingActionButton(
            onPressed: () async {
              await _authService.signOut();
            },
            child: Text('log out'),
          ),
        ],
      ),
    );
  }
}
