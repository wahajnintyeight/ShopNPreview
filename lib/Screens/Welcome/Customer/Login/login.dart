import 'dart:ui';

import 'package:shop_n_preview/Screens/Home/mainpage.dart';
import 'package:shop_n_preview/Screens/Welcome/Customer/Welcome/welcome.dart';
import 'package:shop_n_preview/Screens/Welcome/Customer/Register/register.dart';
import 'package:shop_n_preview/models/customer.dart';
import 'package:shop_n_preview/services/customerAuth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_n_preview/Screens/Welcome/welcome.dart';
import 'package:shop_n_preview/Screens/Home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shop_n_preview/models/authentication.dart';
import '../../../../models/currentCustomerID.dart';

void main() => runApp(chooseWidget('splashRoute'));

Widget chooseWidget(String route) {
  switch (route) {
    // name of the route defined in the host app
    case 'splashRoute':
      return CusLogin();

    default:
      return Center(
        child: Text(
          'Unknown',
          textDirection: TextDirection.ltr,
        ),
      );
  }
}

class CusLogin extends StatefulWidget {
  @override
  _CusLoginState createState() => _CusLoginState();
}

class _CusLoginState extends State<CusLogin> {
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

  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {'email': '', 'password': ''};

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

  Future<void> _submit() async {
    String _returnString;
    String cusID;
    Customer customerInfo;
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    try {
      // await Provider.of<Authentication>(context, listen: false)
      //     .signIn(_authData['email'], _authData['password']);

      _returnString = await customerAuth()
          .loginUserWithEmail(_authData['email'], _authData['password']);
      customerInfo = await customerAuth()
          .returnCustomerID(_authData['email'], _authData['password']);
      //current customer class
      final currCIDs = currCID(cID: customerInfo.cID,fName: customerInfo.fName); //CURRENT CUSTOMER ID
      if (_returnString == "success") {
        print(cusID);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return CusHome(customerID: currCIDs);
          }),
        );
      }
    } catch (error) {
      var errorMessage = 'Authentication Failed. Please try again later.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    Invocation invocation;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () =>
                Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CusWelcome();
            })),
          ),
          title: Text("Shop 'N' Preview"),
          centerTitle: true,
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                SizedBox(height: size.height * 0.10),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                    padding: EdgeInsets.all(10),
                    child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                            child: Column(children: <Widget>[
                          //email
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Email'),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return 'Invalid Email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['email'] = value;
                            },
                          ),
                          //password
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty || value.length <= 5) {
                                return 'Invalid Password';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['password'] = value;
                            },
                          ),
                          FlatButton(
                            onPressed: () {
                              //forgot password screen
                            },
                            textColor: Colors.blue,
                            child: Text('Forgot Password'),
                          ),
                          Container(
                            width: 190,
                            height: 50,
                            child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Text('Login'),
                                onPressed: () {
                                  _submit();
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                color: Colors.blue,
                                textColor: Colors.white),
                          ),
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
                                      return CusRegister();
                                    }),

                                    // print(nameController.text);
                                    // print(passwordController.
                                    // text
                                  );
                                },
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          ))
                        ])))

                    // child: TextField(
                    //   controller: nameController,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     labelText: 'Email',
                    //   ),
                    // ),
                    ),
                // Container(
                //   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                //   child: TextField(
                //     obscureText: true,
                //     onChanged: (val){
                //
                //     },
                //     controller: passwordController,
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Password',
                //     ),
                //   ),
                // ),

                // Container(
                //     height: 50,
                //     padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                //     child: ElevatedButton(
                //       // textColor: Colors.white,
                //       // color: Colors.blue,
                //       child: Text('Login'),
                //       onPressed: () async {
                //         // Navigator.push(
                //         //   context,
                //         //   MaterialPageRoute(builder: (context) {
                //         //     return CusHome();
                //         //   }),
                //         //
                //         //   // print(nameController.text);
                //         //   // print(passwordController.
                //         //   // text
                //         // );
                //       },
                //     )),
              ],
            )));
  }
}
