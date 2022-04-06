import 'dart:ui';

import 'package:shop_n_preview/Screens/Welcome/Customer/Welcome/welcome.dart';
import 'package:shop_n_preview/Screens/Welcome/Customer/Register/register.dart';
import 'package:shop_n_preview/models/currentCustomerID.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_n_preview/Screens/Welcome/welcome.dart';
import 'package:flutter/rendering.dart';
import 'package:shop_n_preview/Screens/Home/mainpage.dart';
import '../../Screens/Welcome/Customer/Welcome/welcome.dart';
import '../../services/customerAuth.dart';
import '../../models/currentCustomerID.dart';

void main() => runApp(chooseWidget('splashRoute'));

class JewelryType {
  int jID;
  String jewelryType;

  JewelryType({this.jID, this.jewelryType});

  JewelryType.foo(int ID) {
    this.jID = ID;
  }
}

Widget chooseWidget(String route) {
  switch (route) {
    // name of the route defined in the host app
    case 'splashRoute':
      return CusHome();

    default:
      return Center(
        child: Text(
          'Unknown',
          textDirection: TextDirection.ltr,
        ),
      );
  }
}

class CusHome extends StatefulWidget {
  // final JewelryType jT;
  final currCID customerID;

  CusHome({this.customerID});
  // const CusHome({Key key, this.jT}) : super(key: key);
  // CusHome() {}

  @override
  _CusHomeState createState() => _CusHomeState();
}

void _signOut(BuildContext context) async {
  String _returnString = await customerAuth().signOut();
  if (_returnString == "success") {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => CusWelcome(),
      ),
      (route) => false,
    );
  }
}

class _CusHomeState extends State<CusHome> {
  // _CusHomeState(this.jT);
  // List<JewelryType> jewelryTitle = new JewelryType(10);
// var jewelryTitle = new List<JewelryType>(10);
//   List<JewelryType> jewelryTitle = List<JewelryType>.generate(10, (index) {
//     JewelryType obj = JewelryType(index)
//     obj.jID = index;
//     return obj;
//   });
//    final currCID customerID;
  final jewelryTitle = List<JewelryType>.generate(
    20,
    (i) => JewelryType.foo(i),
  );

  @override
  void initState() {
    // TODO: implement initState
    // CusHome();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "assets/images/diamond.png",
      "assets/images/artificial.png",
      "assets/images/gold.png",
      "assets/images/silver.png",
    ];

    jewelryTitle[0].jewelryType = "Diamond";
    jewelryTitle[1].jewelryType = "Artificial";
    jewelryTitle[2].jewelryType = "Gold";
    jewelryTitle[3].jewelryType = "Silver";
    for (int i = 0; i < jewelryTitle.length; i++) {
      jewelryTitle[i].jID = i;
    }
    Size size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 35) / 3;
    final double itemWidth = size.width / 2.1;
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text("Shop 'n' Preview"),
            centerTitle: true,
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                new Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [Colors.blue, Colors.indigoAccent])),
                    child: new DrawerHeader(
                      child: new Container(
                        child: Column(
                          children: <Widget>[
                            Material(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                              elevation: 10,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Image.asset("assets/images/icon.png",
                                    height: 90, width: 90),
                              ),
                            ),
                            Text(
                              widget.customerID.fName,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25.0),
                            )
                          ],
                        ),
                      ),
                    )),
                new Container(
                    color: Colors.white70,
                    child: Column(
                      children: <Widget>[
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.green,
                            primary: Colors.green,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.message),
                            title: Text('Profile'),
                            onTap: () {},
                          ),
                        ),
                        // SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.green,
                            primary: Colors.green,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                          ),
                          child: ListTile(
                              leading: Icon(Icons.account_circle),
                              title: Text('Settings'),
                              onTap: () {
                                // _signOut(context);
                              }),
                        ),
                        // SizedBox(height: 20),
                        ElevatedButton(
                          child: ListTile(
                              leading: Icon(Icons.shopping_cart),
                              title: Text('My Cart'),
                              onTap: () {
                                _signOut(context);
                              }),
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.green,
                            primary: Colors.green,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                          ),
                        ),
                        // SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                          ),
                          child: ListTile(
                              leading: Icon(Icons.settings),
                              title: Text('Log Out'),
                              onTap: () {
                                _signOut(context);
                              }),
                        ),
                      ],
                    )),
              ],
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Text(
                      "Jewelry Selection",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Container(
                      // color: Colors.lightBlue,
                      padding: EdgeInsets.all(10),
                      height: size.height * 0.60,
                      decoration: BoxDecoration(
                          color: Color(0xffebebeb),
                          borderRadius: BorderRadius.all(Radius.circular(20))),

                      child: Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              itemCount: images.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 4.0,
                                childAspectRatio: (itemWidth / itemHeight),
                                mainAxisSpacing: 5.0,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                // return Image.asset(images[index]);
                                return Container(
                                  padding: EdgeInsets.all(20.0),
                                  child: InkResponse(
                                    onTap: () {
                                      print(jewelryTitle[index]);

                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => MainPageCus(
                                                  jT: jewelryTitle[index])));
                                    },
                                    child: Center(
                                      child: GridTile(
                                        footer: Text(
                                          // 'SubItem $index',
                                          jewelryTitle[index].jewelryType,
                                          textAlign: TextAlign.center,
                                        ),
                                        child: Container(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 1, 0, 0),
                                          margin: EdgeInsets.all(4),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                  height: size.height * 0.001),
                                              Image.asset(images[index]),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  color: Colors.grey[200],
                                  margin: EdgeInsets.all(1.0),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

//     //   return Scaffold(
//     //     appBar: AppBar(
//     //       title: Text("Shop 'n' Preview"),
//     //       centerTitle: true,
//     //     ),
//     //     drawer: Drawer(
//     //       child: ListView(
//     //         padding: EdgeInsets.zero,
//     //         children: <Widget>[
//     //           new Container(
//     //               decoration: BoxDecoration(
//     //                   gradient: LinearGradient(
//     //                       begin: Alignment.topRight,
//     //                       end: Alignment.bottomLeft,
//     //                       colors: [Colors.blue, Colors.indigoAccent])),
//     //               child: new DrawerHeader(
//     //                 child: new Container(
//     //                   child: Column(
//     //                     children: <Widget>[
//     //                       Material(
//     //                         borderRadius: BorderRadius.all(Radius.circular(50.0)),
//     //                         elevation: 10,
//     //                         child: Padding(
//     //                           padding: EdgeInsets.all(8.0),
//     //                           child: Image.asset("assets/images/icon.png",
//     //                               height: 90, width: 90),
//     //                         ),
//     //                       ),
//     //                       Text(
//     //                         'Customer',
//     //                         style: TextStyle(color: Colors.white, fontSize: 25.0),
//     //                       )
//     //                     ],
//     //                   ),
//     //                 ),
//     //               )),
//     //           new Container(
//     //               child: Column(
//     //             children: <Widget>[
//     //               SizedBox(height: 20),
//     //               ListTile(
//     //                 leading: Icon(Icons.message),
//     //                 title: Text('Profile'),
//     //               ),
//     //               SizedBox(height: 20),
//     //               ListTile(
//     //                 leading: Icon(Icons.account_circle),
//     //                 title: Text('Settings'),
//     //               ),
//     //               SizedBox(height: 20),
//     //               ListTile(
//     //                 leading: Icon(Icons.settings),
//     //                 title: Text('Log Out'),
//     //               )
//     //             ],
//     //           )),
//     //         ],
//     //       ),
//     //     ),
//     //     body: Center(
//     //       child: Container(
//     //         padding: EdgeInsets.all(15),
//     //         child: Column(
//     //           children: <Widget>[
//     //             SizedBox(
//     //               height: size.height * 0.05,
//     //             ),
//     //             Text(
//     //               "Jewelry Selection",
//     //               style: TextStyle(fontSize: 20),
//     //             ),
//     //             SizedBox(
//     //               height: size.height * 0.05,
//     //             ),
//     //             Container(
//     //               // color: Colors.lightBlue,
//     //               padding: EdgeInsets.all(10),
//     //               height: size.height * 0.60,
//     //               decoration: BoxDecoration(
//     //                   color: Color(0xffebebeb),
//     //                   borderRadius: BorderRadius.all(Radius.circular(20))),
//     //
//     //               child: Column(
//     //                 children: [
//     //                   Expanded(
//     //                     child: GridView.builder(
//     //                       itemCount: images.length,
//     //                       shrinkWrap: true,
//     //                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//     //                         crossAxisCount: 2,
//     //                         crossAxisSpacing: 4.0,
//     //                         childAspectRatio: (itemWidth / itemHeight),
//     //                         mainAxisSpacing: 5.0,
//     //                       ),
//     //                       itemBuilder: (BuildContext context, int index) {
//     //                         // return Image.asset(images[index]);
//     //                         return Container(
//     //                           padding: EdgeInsets.all(20.0),
//     //                           child: InkResponse(
//     //                             onTap: () {
//     //                               print(jewelryTitle[index]);
//     //                               // JT.jewelryType = jewelryTitle[index];
//     //                               // JT.jID = index;
//     //                               Navigator.push(
//     //                                 context,
//     //                                 MaterialPageRoute(
//     //                                     builder: (context) => SplashScreen(JT : jewelryTitle[index])),
//     //                               );
//     //                             },
//     //                             child: Center(
//     //                               child: GridTile(
//     //                                 footer: Text(
//     //                                   // 'SubItem $index',
//     //                                   jewelryTitle[index].jewelryType,
//     //                                   textAlign: TextAlign.center,
//     //                                 ),
//     //                                 child: Container(
//     //                                   padding: EdgeInsets.fromLTRB(0, 1, 0, 0),
//     //                                   margin: EdgeInsets.all(4),
//     //                                   child: Column(
//     //                                     children: [
//     //                                       SizedBox(height: size.height * 0.001),
//     //                                       Image.asset(images[index]),
//     //                                     ],
//     //                                   ),
//     //                                 ),
//     //                               ),
//     //                             ),
//     //                           ),
//     //                           color: Colors.grey[200],
//     //                           margin: EdgeInsets.all(1.0),
//     //                         );
//     //                       },
//     //                     ),
//     //                   ),
//     //                 ],
//     //               ),
//     //             )
//     //           ],
//     //         ),
//     //       ),
//     //     ),
//     //   );
//   }
// }
