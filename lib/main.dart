import 'package:flutter/material.dart';
import 'package:ksloginpage/login.dart';
import 'package:ksloginpage/register.dart';
import 'package:ksloginpage/userProfile.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login' : (context) => const MyLogin(),
      'register' : (context) => const MyRegister(),
      'profile' : (context) => UserProfile(userId: null)
    },
  ));
}

