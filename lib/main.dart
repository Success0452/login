import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/home_screen.dart';
import 'package:login/login.dart';
import 'package:login/register.dart';
import 'package:login/services/auth_services.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context)=>const MyLogin(),
      'register': (context)=> const MyRegister()
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider<AuthService>(
        create: (_) => AuthService(FirebaseAuth.instance),
      ),
      StreamProvider(create: (context) => context.read<AuthService>().authStateChanges,
      ),
    ],
    child: const MaterialApp(
      title: "Login",
      home: AuthWrapper(),
    ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User>();

    if(user != null){
      return const HomeScreen();
    } else{
      return const MyLogin();
    }
  }
}



