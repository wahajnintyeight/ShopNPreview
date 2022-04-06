import 'dart:ui';

import 'package:shop_n_preview/Screens/Welcome/Customer/Login/login.dart';
import 'package:shop_n_preview/models/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_n_preview/Screens/Welcome/welcome.dart';
import 'package:shop_n_preview/Screens/Welcome/Customer/Welcome/welcome.dart';
import 'package:provider/provider.dart';
import 'package:shop_n_preview/models/authentication.dart';
import '../../../Home/home.dart';
import '../../../../services/customerAuth.dart';

void main() => runApp(chooseWidget('splashRoute'));

Widget chooseWidget(String route) {
  switch (route) {
    // name of the route defined in the host app
    case 'splashRoute':
      return CusRegister();

    default:
      return Center(
        child: Text(
          'Unknown',
          textDirection: TextDirection.ltr,
        ),
      );
  }
}

class CusRegister extends StatefulWidget {
  @override
  _CusRegisterState createState() => _CusRegisterState();
}

class _CusRegisterState extends State<CusRegister> {
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
  TextEditingController passwordController = new TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {'email': '', 'password': ''};

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    await Provider.of<Authentication>(context, listen: false)
        .signUp(_authData['email'], _authData['password']);
  }

  Future<String> _signUpCustomer(
      String email,
      String password,
      BuildContext context,
      String fullName,
      String userName,
      String phoneNum) async {
    try {
      String _returnString = await customerAuth()
          .signUpCustomer(email, password, fullName, userName, phoneNum);
      if (_returnString == "success") {
        Navigator.pop(context);
        return "SUC";
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
    return "FAIL";
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
                SizedBox(height: size.height * 0.010),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(height: size.height * 0.006),
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
                            controller: EmailController,
                            validator: (value) {
                              if (value.isEmpty || !value.contains('@')) {
                                return 'Invalid Email';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              // _authData['email'] = value;
                              EmailController.text = value;
                            },
                          ),
                          SizedBox(height: size.height * 0.035),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Full Name'),
                            keyboardType: TextInputType.text,
                            controller: FnameController,
                          ),
                          SizedBox(height: size.height * 0.035),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Username'),
                            keyboardType: TextInputType.text,
                            controller: UnameController,
                          ),
                          SizedBox(height: size.height * 0.035),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Phonenumber'),
                            keyboardType: TextInputType.text,
                            controller: phoneNum,
                          ),
                          SizedBox(height: size.height * 0.035),
                          //password
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            controller: passwordController,
                            validator: (value) {
                              if (value.isEmpty || value.length <= 5) {
                                return 'Invalid Password';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _authData['password'] = value;
                              passwordController.text = value;
                            },
                          ),
                          SizedBox(height: size.height * 0.035),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Confirm Password'),
                            obscureText: true,
                            controller: password2Controller,
                            validator: (value) {
                              if (value.isEmpty ||
                                  value != passwordController.text) {
                                return 'Invalid Password';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              password2Controller.text = value;
                            },
                          ),

                          // FlatButton(
                          //   onPressed: () {
                          //     //forgot password screen
                          //   },
                          //   textColor: Colors.blue,
                          //   child: Text('Forgot Password'),
                          // ),
                          SizedBox(height: size.height * 0.035),
                          Container(
                            width: 190,
                            height: 50,
                            child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Text('Register'),
                                onPressed: () async {
                                  print(EmailController.text);
                                  print(passwordController.text);
                                  print(password2Controller.text);
                                  print(UnameController.text);
                                  print(phoneNum.text);
                                  print(FnameController.text);
                                  String returnMsg = await _signUpCustomer(
                                      EmailController.text,
                                      passwordController.text,
                                      context,
                                      FnameController.text,
                                      UnameController.text,
                                      phoneNum.text);
                                  if (returnMsg == "SUC") {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return CusLogin();
                                    }));
                                  } else {
                                    print("FAILURE");
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                color: Colors.blue,
                                textColor: Colors.white),
                          ),
                          // Container(
                          //     child: Row(
                          //       children: <Widget>[
                          //         Text('Does not have account?'),
                          //         FlatButton(
                          //           textColor: Colors.blue,
                          //           child: Text(
                          //             'Sign Up',
                          //             style: TextStyle(fontSize: 20),
                          //           ),
                          //           onPressed: () {
                          //             Navigator.push(
                          //               context,
                          //               MaterialPageRoute(builder: (context) {
                          //                 return CusRegister();
                          //               }),
                          //
                          //               // print(nameController.text);
                          //               // print(passwordController.
                          //               // text
                          //             );
                          //           },
                          //         )
                          //       ],
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //     ))
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
                //     controller: FnameController,
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Full Name',
                //     ),
                //   ),
                // ),
                // Container(
                //   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                //   child: TextField(
                //     controller: UnameController,
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'User Name',
                //     ),
                //   ),
                // ),
                // Container(
                //   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                //   child: TextField(
                //     controller: EmailController,
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Email',
                //     ),
                //   ),
                // ),
                // Container(
                //   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                //   child: TextField(
                //     obscureText: true,
                //     controller: passwordController,
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Password',
                //     ),
                //   ),
                // ),
                // Container(
                //   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                //   child: TextField(
                //     obscureText: true,
                //     controller: password2Controller,
                //     decoration: InputDecoration(
                //       border: OutlineInputBorder(),
                //       labelText: 'Re-type Password',
                //     ),
                //   ),
                // ),
                SizedBox(height: size.height * 0.035),
                // Container(
                //     height: 50,
                //     padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                //     child: RaisedButton(
                //       textColor: Colors.white,
                //       color: Colors.blue,
                //       child: Text('Sign Up'),
                //       onPressed: () {
                //         // print(nameController.text);
                //         // print(passwordController.text);
                //       },
                //     )),
              ],
            )));
  }
}
