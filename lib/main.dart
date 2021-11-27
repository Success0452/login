import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/login.dart';
import 'package:login/register.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SideHustle Group 4',
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context)=>const MyLogin(),
      'register': (context)=> const MyRegister()
    },
  );
  }
}