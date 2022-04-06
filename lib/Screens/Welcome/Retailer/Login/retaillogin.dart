import 'dart:ui';

import 'package:shop_n_preview/Screens/Welcome/Customer/Welcome/welcome.dart';
import 'package:shop_n_preview/Screens/Welcome/Customer/Register/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_n_preview/Screens/Welcome/Designer/Welcome/dzwelcome.dart';
import 'package:flutter/material.dart';
import 'package:shop_n_preview/Screens/Welcome/welcome.dart';
import 'package:shop_n_preview/Screens/Welcome/Retailer/Welcome/retailwelcome.dart';
import 'package:shop_n_preview/Screens/Welcome/Retailer/Register/retailregister.dart';
import 'package:shop_n_preview/services/retailerAuth.dart';
import '../../../Home/Retailer/home.dart';
void main() => runApp(chooseWidget('splashRoute'));
enum LoginType {
  email,
  google,
}
Widget chooseWidget(String route) {
  switch (route) {
    // name of the route defined in the host app
    case 'splashRoute':
      return retailLogin();

    default:
      return Center(
        child: Text(
          'Unknown',
          textDirection: TextDirection.ltr,
        ),
      );
  }
}

class retailLogin extends StatefulWidget {
  @override
  _retailLoginState createState() => _retailLoginState();
}

class _retailLoginState extends State<retailLogin> {
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

  void _loginUser({
    @required LoginType type,
    String email,
    String password,
    BuildContext context,
  }) async {
    try {
      String _returnString;

      switch (type) {
        case LoginType.email:
          _returnString = await retailerAuth().loginUserWithEmail(email, password);
          break;
        default:
      }

      if (_returnString == "success") {

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => RetailHome(),
          ),
              (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
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
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'E-mail',
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
                FlatButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  textColor: Colors.blue,
                  child: Text('Forgot Password'),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Login'),
                      onPressed: () {
                        _loginUser(
                            type: LoginType.email,
                            email: nameController.text,
                            password: passwordController.text,
                            context: context);
                      },
                    )),
                Container(
                    child: Row(
                  children: <Widget>[
                    Text('Does not have account?'),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return retailRegister();
                          }),

                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ))
              ],
            )));
  }
}
