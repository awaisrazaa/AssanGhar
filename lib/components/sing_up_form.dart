import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onboard_animation/components/Dashboard.dart';
import 'package:onboard_animation/components/sign_in.dart';

import '../Utils/app_colors.dart';
import '../Utils/toast.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final name = TextEditingController();
  final email = TextEditingController();
   final password = TextEditingController();
  final confirmpassword = TextEditingController();
  // bool isEmailValid(String email) {
  //   String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
  //   RegExp regex = RegExp(pattern);
  //   return regex.hasMatch(email);
  // }

  bool namevalidate = false;
  bool emailvalidate = false;

  bool phonevalidate = false;

  bool passvalidate = false;
  bool confirmpassValid = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: const Text(
                "Create an account",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
                controller: name,
                cursorColor: AppColors.appgreen,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.appgreen),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.appgreen),
                  ),
                  hintText: 'Name',
                  prefixIcon: Icon(Icons.person,color:AppColors.appgreen),
                )),
            SizedBox(height: 16),
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
                  prefixIcon: Icon(Icons.email,color:AppColors.appgreen),
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
                  prefixIcon: Icon(Icons.lock,color:AppColors.appgreen),
                )),
            SizedBox(height: 16),
            TextField(
                controller: confirmpassword,
                cursorColor: AppColors.appgreen,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.appgreen),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.appgreen),
                  ),
                  hintText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock,color:AppColors.appgreen),
                )),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    if (name.text.isEmpty) {
                      setState(() {
                        namevalidate = true;
                      });
                    }

                    else if (email.text.isEmpty) {
                      setState(() {
                        emailvalidate = true;
                      });
                    }
                     else if (password.text.isEmpty) {
                      setState(() {
                        passvalidate = true;
                      });
                    } else if (confirmpassword.text.isEmpty) {
                      setState(() {
                        confirmpassValid = true;
                      });

                    }
                     else {
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email.text,
                          password: password.text,
                        )
                            .then((value) async {
                        });
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          FlutterErrorToast(
                            error: 'The password provided is too weak.',
                          );
                        } else if (e.code == 'email-already-in-use') {
                          FlutterErrorToast(
                              error:
                              "The account already exists for this email.");
                        };
                      }
                      await FirebaseFirestore.instance
                          .collection("Accountinformation")
                          .doc(email.text)
                          .set({
                        "Name": name.text,
                        "Email": email.text,
                        "Password": password.text,
                        "ConfirmPassword": confirmpassword.text,
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Dashboard(email: email.text,
                                // email: email.text,
                              )));
                      Fluttertoast.showToast(
                          msg: 'Account Created Successfully',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: AppColors.appgreen,
                          textColor: Colors.white,
                          fontSize: 10.0);

                    }

                    print("Email is $email");
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
                      'Create Account',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignIn()));
              },
              child: Text(
                "Already have an account? Sign in.",
                style: TextStyle(fontSize: 16, color: AppColors.litegreen),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
