import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:phuc_61cntt1/firebase/cloud_firestore/page_home_firebase_app.dart';
import 'package:phuc_61cntt1/firebase/cloud_firestore/register_page.dart';
import 'package:phuc_61cntt1/firebase/cloud_firestore/sign_in_with_firebase_authentication.dart';
import 'package:phuc_61cntt1/helper/dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Form(
          key: formState,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                    controller: txtEmail,
                    validator: (value) => validateEmail(value),
                    decoration: const InputDecoration(
                      labelText: "Email:",
                    )),
                TextFormField(
                    controller: txtPassword,
                    obscureText: true,
                    validator: (value) => validateString(value),
                    decoration: const InputDecoration(
                      labelText: "Password:",
                    )),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    if (txtEmail.text != "" && txtPassword.text != "") {
                      error = "";
                      showSnackBar(context, "Signing in.....", 300);
                      signWithEmailPassword(
                              email: txtEmail.text, password: txtPassword.text)
                          .then((value) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const PageSinhViens()),
                            (route) => false);
                        showSnackBar(
                            context,
                            "Hello ${FirebaseAuth.instance.currentUser?.email ?? ""}",
                            5);
                      }).catchError((error) {
                        setState(() {
                          this.error = error;
                        });
                        showSnackBar(context, "Sign in not successfully", 3);
                      });
                    }
                  },
                  child: Container(
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.mail,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Sign in with Email",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: const Color.fromARGB(255, 35, 114, 178),
                    ),
                    height: 40,
                    width: 250,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account"),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SignInButton(
                  Buttons.Google,
                  text: "Sign in with Google",
                  onPressed: () async {
                    showSnackBar(context, "Signing in..... ", 300);
                    var user = await signWithGoogle();
                    if (user != null) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const PageSinhViens()),
                          (route) => false);
                      showSnackBar(
                          context,
                          "Hello ${FirebaseAuth.instance.currentUser?.email ?? ""}",
                          5);
                    } else {
                      setState(() {
                        error = "Login fails";
                      });
                      showSnackBar(context, "Sign in not successfully", 3);
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                error != "" ? Text(error) : const Text("")
              ],
            ),
          ),
        )),
      ),
    );
  }

  validateString(String? value) {
    return value == null || value.isEmpty ? "Bạn chưa nhập Password" : null;
  }

  validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Bạn chưa nhập email";
    } else if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Bạn đã nhập sai định dạng";
    } else {
      return null;
    }
  }
}
