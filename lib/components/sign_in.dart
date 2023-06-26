import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onboard_animation/components/Dashboard.dart';
import 'package:onboard_animation/components/sign_in.dart';

import '../Utils/app_colors.dart';
import '../Utils/toast.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmpassword = TextEditingController();

  bool namevalidate = false;
  bool emailvalidate = false;

  bool phonevalidate = false;

  bool passvalidate = false;
  bool confirmpassValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.litegreen,
        body: Padding(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
             Text(
              "Login Your Account",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            TextField(
                controller: email,
                cursorColor: AppColors.appgreen,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.appgreen),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.appgreen),
                  ),
                  hintText: 'Email address',
                  prefixIcon: Icon(Icons.email, color: AppColors.appgreen),
                )),
            SizedBox(height: 16),
            TextField(
                controller: password,
                cursorColor: AppColors.appgreen,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.appgreen),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.appgreen),
                  ),
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: AppColors.appgreen),
                )),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    setState(() {
                      if (email.text.isEmpty) {
                        emailvalidate = true;
                      } else if (password.text.isEmpty) {
                        passvalidate = true;
                      } else {
                        emailvalidate = false;
                        passvalidate = false;
                      }
                    });
                    if (email.text.isNotEmpty && password.text.isNotEmpty) {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        );
                        Fluttertoast.showToast(
                            msg: 'Login Successfully',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: AppColors.appgreen,
                            textColor: Colors.white,
                            fontSize: 10.0);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard(
                                      email: email.text,
                                      // email: email.text,
                                    )));
                      } on FirebaseAuthException catch (e) {
                        print(e.code);
                        if (e.code == 'user-not-found') {
                          FlutterErrorToast(error: "Invalid Email");
                        } else if (e.code == 'wrong-password') {
                          FlutterErrorToast(error: "Invalid Password");
                        }

                        setState(() {
                          emailvalidate = false;
                          passvalidate = false;
                          // email.text = "";
                          // password.text = "";
                        });
                      }
                    }
                  },

                  // onTap: () async {
                  //   final emailtext = email.text.toString();
                  //   final passwordtext = password.text.toString();
                  //   try {
                  //     await FirebaseAuth.instance
                  //         .createUserWithEmailAndPassword(
                  //             email: emailtext, password: passwordtext)
                  //         .then((value) => debugPrint('addded')
                  //     );
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => Dashboard(
                  //               email: emailtext.toString(),
                  //             )));
                  //   } on FirebaseAuthException catch (e) {
                  //     showDialog(
                  //       context: context,
                  //       builder: (context) {
                  //         return AlertDialog(
                  //           title: Text('Authentication Error'),
                  //           content: Text(e.message.toString()),
                  //           actions: [
                  //             TextButton(
                  //               child: Text('OK'),
                  //               onPressed: () {
                  //                 Navigator.of(context).pop();
                  //                 email.clear();
                  //                 password.clear();
                  //               },
                  //             ),
                  //           ],
                  //         );
                  //       },
                  //     );
                  //   }
                  // },

                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.appgreen,
                        borderRadius: BorderRadius.circular(21)),
                    height: 50,
                    width: 150,
                    child: Center(
                        child: Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
