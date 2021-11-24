import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage(''), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 130, ),
              child: const Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.black87, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5,
                right: 35,
                left: 35
                ),
                child: Column(
                  children: [
                    TextField(decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(obscureText: true,
                        decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [Text('Sign In', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700
                    ),
                    )],
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
                            child: const Text('Sign Up', style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                          color: Color(0xff4c505b)
                        ),)),
                        TextButton(
                            onPressed: () {},
                            child: const Text('Forget Password', style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18,
                                color: Color(0xff4c505b)
                            ),))
                      ],
                    ),
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xff4c505b),
                      // child: IconButton( color: Colors.white, icon: Icon(Icons.arrow_forward), onPressed: () {},),
                    )
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
