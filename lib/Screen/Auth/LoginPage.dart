import 'package:flutter/material.dart';
import 'package:petandur/Screen/Auth/RegisterPage.dart';
import 'package:petandur/constants.dart';
import 'package:petandur/Services/Auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Wrapper.dart';

class LoginPage extends StatefulWidget {
  // final Function toggleView;
  // LoginPage({this.toggleView});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool ingat = false;
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  void setIntoSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("ingatP", ingat);
    await prefs.setString("emailP", emailController.text);
    await prefs.setString("passP", passwordController.text);
  }

  // Method ini berfungsi untuk mengambil data Email dan Password dari SharedPreferences
  // kemudian dimasukkan ke variable email dan password
  void getFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      ingat = prefs.getBool("ingatP") ?? false;
      emailController.text = prefs.getString("emailP") ?? "";
      passwordController.text = prefs.getString("passP") ?? "";
      if (ingat == false) {
        emailController.text = "";
        passwordController.text = "";
      }
    });
  }

  void initState() {
    getFromSharedPreferences();
    super.initState();
  }


  bool isValid = false;
  String error = '';
  bool absorb = false;
  @override
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: backgroundColor),
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.03),
                  Image.asset(
                    "assets/img/p2.png",
                    height: size.height * 0.21,
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    "Selamat Datang di",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Text(
                    "Petandur.id",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15, top: 5),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: emailController,
                      // onChanged: (value) {},
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: kPrimaryColor,
                        ),
                        hintText: "Email",
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  /*  RoundedInputField(
                    hintText: "Your Emailmu",
                    onChanged: (value) {},
                  ), */

                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 12),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      // onChanged: (value) {},
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        hintText: "Password",
                        icon: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    padding:
                        new EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: CheckboxListTile(
                            value: ingat,
                            contentPadding: EdgeInsets.all(0),
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              "Ingat Password",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                ingat = newValue;
                              });
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            /*   Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SignUpScreen();
                            })); */
                          },
                          child: Text(
                            "Lupa Password?",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),

                  /* RoundedPasswordField(
                    onChanged: (value) {},
                  ), */
                  SizedBox(height: size.height * 0.01),
                  AbsorbPointer(
                    absorbing: absorb,
                    child: ButtonTheme(
                      minWidth: size.width * 0.9,
                      height: 10.0,
                      child: RaisedButton(
                          child: Text(
                            "Masuk",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          color: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          onPressed: () async {
                            isValid =
                                EmailValidator.validate(emailController.text);
                            setState(() {
                              absorb = true;
                            });
                            if (emailController.text == "") {
                              setState(() {
                                absorb = false;
                                error = 'Email tidak boleh kosong';
                              });
                            } else if (passwordController.text == "") {
                              setState(() {
                                absorb = false;
                                error = 'Password tidak boleh kosong';
                              });
                            } else if (isValid == false) {
                              setState(() {
                                absorb = false;
                                error = 'Format Email salah';
                              });
                            } else if (passwordController.text.length < 6) {
                              setState(() {
                                absorb = false;
                                error = 'Password setidaknya harus 6 karakter';
                              });
                            } else {
                              

                              dynamic result =
                                  await Auth.signInWithEmailAndPassword(
                                      emailController.text,
                                      passwordController.text);

                              if (result == null) {
                                setState(() {
                                  absorb = false;
                                  error = 'Email atau Password salah';
                                });
                              }else{
                                setIntoSharedPreferences();
                                Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return Wrapper();
                              }));
                              }
                            }
                          }),
                    ),
                  ),

                  /* RoundedButton(
                    text: "LOGIN",
                    press: () {},
                  ), */
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Belum punya akun? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return RegisterPage();
                          }));
                        },
                        child: Text(
                          "Daftar Sekarang",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
