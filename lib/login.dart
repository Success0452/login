import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:login/home_screen.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/bg.jpg'),
                ),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.45),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 35,
                top: 130,
              ),
              child: const Text(
                'Welcome\nBack',
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5,
                    right: 35,
                    left: 35),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Email";
                        }
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Password";
                        }
                      },
                      onChanged: (value) {
                        password = value;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.white60,
                              fontSize: 27,
                              fontWeight: FontWeight.w700),
                        ),
                        isloading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.teal,
                                child: IconButton(
                                    onPressed: () async {
                                      if (formkey.currentState!.validate()) {
                                        setState(() {
                                          isloading = true;
                                        });
                                        try {
                                          await _auth
                                              .signInWithEmailAndPassword(
                                                  email: email,
                                                  password: password);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child:
                                                    Text('Logged in Success'),
                                              ),
                                              duration: Duration(seconds: 5),
                                            ),
                                          );
                                          await Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (contex) =>
                                                  const HomeScreen(),
                                            ),
                                          );

                                          setState(() {
                                            isloading = false;
                                          });
                                        } on FirebaseAuthException catch (e) {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title: const Text(
                                                  "Ops! Login Failed"),
                                              content: Text('${e.message}'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: const Text('Okay'),
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                        setState(() {
                                          isloading = false;
                                        });
                                      }
                                    },
                                    color: Colors.white,
                                    icon: const Icon(Icons.arrow_forward_ios)))
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'register');
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Colors.white60,
                              ),
                            )),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forget Password',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 18,
                                  color: Color(0xff4c505b)),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}