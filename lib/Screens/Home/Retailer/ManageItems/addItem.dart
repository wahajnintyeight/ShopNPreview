import 'dart:ui';

import 'package:shop_n_preview/models/authentication.dart';
import 'package:shop_n_preview/services/dbFuture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_n_preview/Screens/Welcome/welcome.dart';
import 'package:shop_n_preview/Screens/Welcome/Customer/Welcome/welcome.dart';
import 'package:provider/provider.dart';
import 'package:shop_n_preview/models/authentication.dart';
import 'manageItems.dart';
import '../../../../models/earrings.dart';
import 'dart:async';

void main() => runApp(chooseWidget('splashRoute'));

Widget chooseWidget(String route) {
  switch (route) {
    // name of the route defined in the host app
    case 'splashRoute':
      return AddItem();

    default:
      return Center(
        child: Text(
          'Unknown',
          textDirection: TextDirection.ltr,
        ),
      );
  }
}

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
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
  TextEditingController earringName = TextEditingController();
  TextEditingController earringType = TextEditingController();
  TextEditingController price = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  List<String> _earringtypes = ['Diamond', 'Artificial', 'Gold', 'Silver'];
  String _selectedType = "";
  Map<String, String> _authData = {'email': '', 'password': ''};

  Future<void> _submit() async {
    _formKey.currentState?.save();

    Earrings earrings = Earrings(
        name: earringName.text,
        type: _selectedType,
        price: int.parse(price.text),
        outOfStock: false,
        thumbnail: '');
    String status = await DBFuture().addEarrings(earrings);
    if (status == "success") {
      print("SUCCESS");
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
              return ManageItems();
            })),
          ),
          title: Text("Shop Retailer"),
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
                      'Add a new earring model',
                      style: TextStyle(fontSize: 20),
                    )),
                SizedBox(height: size.height * 0.03),
                Container(
                    padding: EdgeInsets.all(10),
                    child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                            child: Column(children: <Widget>[
                          //email

                          TextFormField(
                              decoration: InputDecoration(labelText: 'Name'),
                              keyboardType: TextInputType.text,
                              controller: earringName),
                          SizedBox(height: size.height * 0.05),
                          //password

                          TextFormField(
                              decoration: InputDecoration(labelText: 'Price'),
                              keyboardType: TextInputType.number,
                              controller: price),
                          SizedBox(height: size.height * 0.07),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Select earrings type',
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),
                          Container(
                            width: 400,
                            child: Center(
                                child: DropdownButton(
                                    isExpanded: true,
                                    hint: Text('Select an earring type'),
                                    value: _selectedType,
                                    onChanged: (newVal) {
                                      setState(() {
                                        _selectedType = newVal;
                                      });
                                    },
                                    items: _earringtypes.map((type) {
                                      return DropdownMenuItem(
                                          child: new Text(type), value: type);
                                    }).toList())),
                          ),
                          SizedBox(height: size.height * 0.05),

                          Container(
                            width: 190,
                            height: 50,
                            child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Text('Add'),
                                onPressed: () {
                                  _submit();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Item has been added!"),
                                      duration: Duration(seconds: 4),
                                    ),
                                  );
                                  var duration = Duration(seconds: 5);
                                  Timer(duration, manageItemPage);
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
                          //                 return AddItem();
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
                SizedBox(height: size.height * 0.05),
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

  manageItemPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ManageItems();
    }));
  }
}
