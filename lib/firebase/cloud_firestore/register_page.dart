import 'package:flutter/material.dart';
import 'package:phuc_61cntt1/firebase/cloud_firestore/sign_in_with_firebase_authentication.dart';
import 'package:phuc_61cntt1/helper/dialog.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtRetypePassword = TextEditingController();

  bool _isObscure = true;
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
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
                  obscureText: _isObscure,
                  validator: (value) => validateString(value),
                  decoration: InputDecoration(
                      labelText: "Your Password:",
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      )),
                ),
                _isObscure
                    ? TextFormField(
                        controller: txtRetypePassword,
                        obscureText: _isObscure,
                        validator: (value) => validateRetypePassword(value),
                        decoration: const InputDecoration(
                          labelText: "Retype your password:",
                        ))
                    : const SizedBox(
                        height: 1,
                      ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      bool? validate = formState.currentState?.validate();
                      if (validate == true) {
                        error = "";
                        showSnackBar(context, "Registering.....", 600);
                        registerEmailPassword(
                                email: txtEmail.text,
                                password: txtPassword.text)
                            .then((value) {
                          setState(() {
                            error = "Registered successfully!";
                          });
                          showSnackBar(context, "Registered successfully!", 3);
                        }).catchError((error) {
                          setState(() {
                            this.error = error;
                          });
                          showSnackBar(
                              context, "Registered not successfully!", 3);
                        });
                      }
                    },
                    icon: const Icon(Icons.key),
                    label: const Text("Register"),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
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

  validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Bạn chưa nhập email";
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return "Bạn đã nhập sai định dạng";
    } else {
      return null;
    }
  }

  validateString(String? value) {
    return value == null || value.isEmpty ? "Bạn chưa nhập Password" : null;
  }

  validateRetypePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Bạn chưa nhập email";
    } else {
      return txtPassword.text != txtRetypePassword.text
          ? "Password không trùng khớp"
          : null;
    }
  }
}
