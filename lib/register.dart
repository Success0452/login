import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String name = '';
  String email = '';
  String password = '';
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      // backgroundColor: Colors.transparent,
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
                  image: AssetImage('assets/bg1.jpg'),
                ),
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withOpacity(0.45),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 35,
                top: 175,
              ),
              child: const Text(
                'Create\nAccount',
                style: TextStyle(color: Colors.white70, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.40,
                    right: 35,
                    left: 35),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your name";
                        }
                      },
                      onChanged: (value) {
                        name = value;
                      },
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        email = value.toString().trim();
                      },
                      validator: (value) =>
                          (value!.isEmpty) ? ' Please enter email' : null,
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
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter Password";
                        }
                      },
                      onChanged: (value) {
                        password = value;
                      },
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
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 27,
                              fontWeight: FontWeight.w700),
                        ),
                        isloading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.teal,
                                ),
                              )
                            : CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.teal,
                                child: IconButton(
                                  color: Colors.white,
                                  icon: const Icon(Icons.arrow_forward),
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      setState(() {
                                        isloading = true;
                                      });
                                      try {
                                        await _auth
                                            .createUserWithEmailAndPassword(
                                                email: email,
                                                password: password);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                  'Successfully Registered, You can Sign in Now'),
                                            ),
                                            duration: Duration(seconds: 5),
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                        setState(() {
                                          isloading = false;
                                        });
                                      } on FirebaseAuthException catch (e) {
                                        showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                                  title: const Text(
                                                      'Ops! Registration Failed'),
                                                  content: Text('${e.message}'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child: const Text('Okay'),
                                                    )
                                                  ],
                                                ));
                                        setState(() {
                                          isloading = false;
                                        });
                                      }
                                    }
                                  },
                                ),
                              )
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
                              Navigator.pushNamed(context, 'login');
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Colors.white70,
                              ),
                            )),
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

class FireAuth {
  // For registering a new user
  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return user;
  }
}
