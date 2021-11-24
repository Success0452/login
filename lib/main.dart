import 'dart:js';

import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:login/register.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context)=>const MyLogin(),
      'register': (context)=> const MyRegister()
    },
  ));
}

