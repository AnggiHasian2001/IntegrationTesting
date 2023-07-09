import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rentbike/controller/auth_controller.dart';
import 'package:rentbike/model/user_model.dart';
import 'package:rentbike/view/homepage.dart';
import 'package:rentbike/view/login.dart';

class Register extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  final autCtr = AuthController();

  String? name;
  String? email;
  String? jeniskelamin;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Register',
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber),
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://media.istockphoto.com/id/1152337760/id/vektor/logo-untuk-penyewaan-sepeda-ilustrasi-vektor-pada-latar-belakang-putih.jpg?s=2048x2048&w=is&k=20&c=QiMj2hoiSSEpmESU2_weiEpMP4G4o-xkGMnuOPpoFTc="),
                    backgroundColor: Colors.black,
                    radius: 90,
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap masukan nama';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Name",
                    labelText: "Name",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap masukan email';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Email",
                    labelText: "Email",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap masukan jenis kelamin';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Jenis Kelamin",
                    labelText: "Jenis Kelamin",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                  onChanged: (value) {
                    jeniskelamin = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password butuh setidaknya panjang 6 data';
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                    labelText: "Password",
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                  ),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () async {
                    if (formkey.currentState!.validate()) {
                      UserModel? registeredUser =
                          await autCtr.registerWithEmailAndPassword(
                              email!, jeniskelamin!, password!, name!);

                      if (registeredUser != null) {
                        // Registration successful
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Registrasi Berhasil'),
                              content:
                                  const Text('Kamu telah berhasil registrasi'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                    print(registeredUser.name);
                                    // Navigate to the next screen or perform any desired action
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Registration failed
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Registrasi Gagal'),
                              content: const Text(
                                  'Terdapat error ketika registrasi'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()));
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  child: Container(
                    width: 500,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: Text(
                        'Registrasi',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Have an Account?",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
