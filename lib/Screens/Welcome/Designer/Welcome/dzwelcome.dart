import 'dart:ui';

import 'package:shop_n_preview/Screens/Welcome/Customer/Register/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_n_preview/Screens/Welcome/Customer/Login/login.dart';
import 'package:shop_n_preview/Screens/Welcome/Designer/Login/dzlogin.dart';
import 'package:shop_n_preview/Screens/Welcome/Designer/Register/dzregister.dart';
import 'package:shop_n_preview/Screens/Welcome/welcome.dart';

void main() => runApp(chooseWidget('splashRoute'));

Widget chooseWidget(String route) {
  switch (route) {
    // name of the route defined in the host app
    case 'splashRoute':
      return DzWelcome();

    default:
      return Center(
        child: Text(
          'Unknown',
          textDirection: TextDirection.ltr,
        ),
      );
  }
}

class DzWelcome extends StatefulWidget {
  @override
  _DzWelcomeState createState() => _DzWelcomeState();
}

class _DzWelcomeState extends State<DzWelcome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                SizedBox(height: size.height * 0.05),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Shop 'N' Preview",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Designer',
                    style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
                SizedBox(height: size.height * 0.10),
                // SizedBox(height: size.height * 0.05),
                Container(
                    height: 90,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Login'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return DesignLogin();
                          }),

                          // print(nameController.text);
                          // print(passwordController.
                          // text
                        );
                        //    print(nameController.text);
                        //  print(passwordController.text);
                      },
                    )),
                SizedBox(height: size.height * 0.05),
                Container(
                    height: 90,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Register'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return DzRegister();
                          }),
                          // print(nameController.text);
                          // print(passwordController.
                          // text
                        );
                        //print(nameController.text);
                        //print(passwordController.text);
                      },
                    )),
                SizedBox(height: size.height * 0.05),
                Container(
                    height: 90,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      elevation: 0,
                      hoverElevation: 0,
                      focusElevation: 0,
                      highlightElevation: 0,
                      textColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: Colors.blue, width: 4),
                      ),
                      color: Colors.white,
                      child: Text(
                        'Back',
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return Welcome(); //Main Welcome Page
                          }),
                          // print(nameController.text);
                          // print(passwordController.text);
                        );
                      },
                    )),
              ],
            )));
  }
}
