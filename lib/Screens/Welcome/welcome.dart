import 'dart:ui';

import 'package:shop_n_preview/Screens/Welcome/Customer/Welcome/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_n_preview/Screens/Welcome/Designer/Welcome/dzwelcome.dart';
import 'package:shop_n_preview/Screens/Welcome/Retailer/Welcome/retailwelcome.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:shop_n_preview/Screens/Welcome/Customer/Welcome/welcome.dart';
import 'package:shop_n_preview/models/authentication.dart';
void main() => runApp(chooseWidget('splashRoute'));

Widget chooseWidget(String route) {
  switch (route) {
    // name of the route defined in the host app
    case 'splashRoute':
      return Welcome();

    default:
      return Center(
        child: Text(
          'Unknown',
          textDirection: TextDirection.ltr,
        ),
      );
  }
}

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
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
                SizedBox(height: size.height * 0.05),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Choose Your Role',
                    style: TextStyle(
                        color: Colors.black45,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Container(
                    height: 90,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Customer'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return CusWelcome();
                          }),

                          // print(nameController.text);
                          // print(passwordController.
                          // text
                        );
                      },
                    )),
                SizedBox(height: size.height * 0.05),
                Container(
                    height: 90,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Designer'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return DzWelcome();
                          }),

                          // print(nameController.text);
                          // print(passwordController.
                          // text
                        );
                      },
                    )),
                SizedBox(height: size.height * 0.05),
                Container(
                    height: 90,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Shop Retailer'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return RetailWelcome();
                          }),

                          // print(nameController.text);
                          // print(passwordController.
                          // text
                        );
                      },
                    )),
              ],
            )));
  }
}
