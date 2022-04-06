import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_n_preview/Screens/Welcome/welcome.dart';
import 'package:shop_n_preview/Screens/Welcome/Customer/Welcome/welcome.dart';
import 'package:shop_n_preview/Screens/Welcome/Retailer/Welcome/retailwelcome.dart';
import 'package:shop_n_preview/services/retailerAuth.dart';

void main() => runApp(chooseWidget('splashRoute'));

Widget chooseWidget(String route) {
  switch (route) {
    // name of the route defined in the host app
    case 'splashRoute':
      return retailRegister();

    default:
      return Center(
        child: Text(
          'Unknown',
          textDirection: TextDirection.ltr,
        ),
      );
  }
}

class retailRegister extends StatefulWidget {
  @override
  _retailRegisterState createState() => _retailRegisterState();
}

class _retailRegisterState extends State<retailRegister> {
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
  TextEditingController UnameController = TextEditingController();
  TextEditingController FnameController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController password2Controller = TextEditingController();

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occured'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                )
              ],
            ));
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text("Passwords do not match"),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _signUpUser(String email, String password, BuildContext context,
      String fullName, String userName) async {
    try {
      String _returnString =
          await retailerAuth().signUpUser(email, password, fullName, userName);
      if (_returnString == "success") {
        Navigator.pop(context);
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(_returnString),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RetailWelcome();
            })),
          ),
          title: Text("Shop 'N' Preview"),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                SizedBox(height: size.height * 0.05),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: FnameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: UnameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'User Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: EmailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: password2Controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Re-type Password',
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05),
                Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Builder(
                      builder: (context) => RaisedButton(
                            textColor: Colors.white,
                            color: Colors.blue,
                            child: Text('Sign Up'),
                            onPressed: () {
                              if (passwordController.text ==
                                  password2Controller.text) {
                                print("Here");
                                _signUpUser(
                                    EmailController.text,
                                    passwordController.text,
                                    context,
                                    FnameController.text,
                                    UnameController.text);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return CusWelcome();
                                }));
                              } else {
                                // ignore: deprecated_member_use
                                _displaySnackBar(context);
                                //   _showErrorDialog("Passwords do not match!");
                              }
                            },
                          )),
                ),
              ],
            )));
  }
}
