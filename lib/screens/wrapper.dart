import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzler/models/user_in_app.dart';
import 'package:quizzler/screens/authenticate/authenticate.dart';
import 'package:quizzler/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserInApp?>(context);
    //print(user?.uid);

    // return Home or Authenticate widget
    if (user == null){
      return  Authenticate();
    } else {
      return Home();
    }
  }
}

