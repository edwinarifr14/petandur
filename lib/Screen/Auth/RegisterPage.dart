import 'package:flutter/material.dart';
import 'package:petandur/Screen/Auth/LoginPage.dart';
import 'package:petandur/Screen/Wrapper.dart';
import 'package:petandur/constants.dart';
import 'package:petandur/Services/Auth.dart';
import 'package:email_validator/email_validator.dart';

class RegisterPage extends StatefulWidget {
  // final Function toggleView;
  // RegisterPage({this.toggleView});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController ulangipasswordController =
      TextEditingController(text: "");

  bool isValid = false;
  String error = '';
  var ingatPass = false;
  bool absorb = false;

  // String email = '';
  // String password = '';

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
                  Image.asset("assets/img/register.png",
                      height: size.height * 0.23),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    "Mari Bergabung dengan",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  Text(
                    "Komunitas Kami",
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
                    margin: EdgeInsets.only(top: 10, bottom: 12),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: ulangipasswordController,
                      obscureText: true,
                      // onChanged: (value) {},
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        hintText: "Ulangi Password",
                        icon: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        border: InputBorder.none,
                      ),
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
                  SizedBox(height: size.height * 0.03),
                  AbsorbPointer(
                    absorbing: absorb,
                    child: ButtonTheme(
                      minWidth: size.width * 0.9,
                      height: 10.0,
                      child: RaisedButton(
                        child: Text(
                          "Daftar",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        color: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
                          } else if (passwordController.text.length < 6 ) {
                            setState(() {
                              absorb = false;
                              error = 'Password setidaknya harus 6 karakter';
                            });
                          } else if (passwordController.text !=
                              ulangipasswordController.text) {
                            setState(() {
                              absorb = false;
                              error = 'Password dan Ulangi Password harus sama';
                            });
                          } else {
                            dynamic result = await Auth.registerWithEmail(
                                emailController.text, passwordController.text);
                            if (result == null) {
                              setState(() {
                                absorb = false;
                                error = 'Email sudah digunakan';
                              });
                            } else {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return Wrapper();
                              }));
                              
                            }
                          }
                        },
                      ),
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
                        "Sudah punya akun? ",
                        style: TextStyle(color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return LoginPage();
                          }));
                        },
                        child: Text(
                          "Masuk Sekarang",
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
