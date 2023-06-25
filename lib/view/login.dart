import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rentbike/controller/auth_controller.dart';
import 'package:rentbike/model/user_model.dart';
import 'package:rentbike/view/homepage.dart';

class Login extends StatelessWidget {
  final formkey = GlobalKey<FormState>();

  final autCtr = AuthController();
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: "Email"),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Password"),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    child: Text('Login'),
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        UserModel? signUser = await autCtr
                            .signWithEmailAndPassword(email!, password!);

                        if (signUser != null) {
                          // Registration successful
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Login Berhasil'),
                                content: const Text('Kamu Berhasil Login'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomePage()));
                                      print(signUser.name);
                                      // Navigate to the next screen or perform any desired action
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    })
              ],
            ),
          )),
    );
  }
}
