import 'dart:ui';

import 'package:shop_n_preview/Screens/Welcome/Customer/Welcome/welcome.dart';
import 'package:shop_n_preview/Screens/Welcome/Customer/Register/register.dart';
import 'package:shop_n_preview/models/currentCustomerID.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_n_preview/Screens/Welcome/welcome.dart';
import 'package:flutter/rendering.dart';
// import 'package:shop_n_preview/Screens/Home/mainpage.dart';
// import '../../Screens/Welcome/Customer/Welcome/welcome.dart';
// import '../../services/customerAuth.dart';
// import '../../models/currentCustomerID.dart';
import '../../../../services/dbFuture.dart';

void main() => runApp(chooseWidget('splashRoute'));

Widget chooseWidget(String route) {
  switch (route) {
    // name of the route defined in the host app
    case 'splashRoute':
      return RetailerViewItems();

    default:
      return Center(
        child: Text(
          'Unknown',
          textDirection: TextDirection.ltr,
        ),
      );
  }
}

class RetailerViewItems extends StatefulWidget {
  @override
  _RetailerViewItemsState createState() => _RetailerViewItemsState();
}

class _RetailerViewItemsState extends State<RetailerViewItems> {
//    final currCID customerID;
  Future<List> earrings;

  @override
  void initState() {
    // TODO: implement initState
    // RetailerViewItems();

    super.initState();
    // earring =  DBFuture().returnEarrings();
    // earring = await DBFuture().returnEarrings();
  }

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "assets/images/diamond.png",
      "assets/images/artificial.png",
      "assets/images/gold.png",
      "assets/images/silver.png",
    ];

    // List eID = DBFuture().returnEarrings();
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
                              // widget.customerID.fName,
                              "Retailer",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25.0),
                            )
                          ],
                        ),
                      ),
                    )),
                new Container(
                    child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    ListTile(
                      leading: Icon(Icons.message),
                      title: Text('Profile'),
                    ),
                    SizedBox(height: 20),
                    ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text('Settings'),
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      child: ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Log Out'),
                          onTap: () {
                            // _signOut(context);
                          }),
                    )
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
                          // Expanded(
                          //   child: GridView.builder(
                          //     itemCount: images.length,
                          //     shrinkWrap: true,
                          //     gridDelegate:
                          //         SliverGridDelegateWithFixedCrossAxisCount(
                          //       crossAxisCount: 2,
                          //       crossAxisSpacing: 4.0,
                          //       childAspectRatio: (itemWidth / itemHeight),
                          //       mainAxisSpacing: 5.0,
                          //     ),
                          //     itemBuilder: (BuildContext context, int index) {
                          //       // return Image.asset(images[index]);
                          //       return Container(
                          //         padding: EdgeInsets.all(20.0),
                          //         child: InkResponse(
                          //           onTap: () {
                          //             // print(earring.length);
                          //             earrings =  DBFuture().returnEarrings();
                          //             print(earrings);
                          //           },
                          //           child: Center(
                          //             child: GridTile(
                          //               footer: Text("ss"),
                          //               child: Container(
                          //                 padding:
                          //                     EdgeInsets.fromLTRB(0, 1, 0, 0),
                          //                 margin: EdgeInsets.all(4),
                          //                 child: Column(
                          //                   children: [
                          //                     SizedBox(
                          //                         height: size.height * 0.001),
                          //                     Image.asset(images[index]),
                          //                   ],
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         color: Colors.grey[200],
                          //         margin: EdgeInsets.all(1.0),
                          //       );
                          //     },
                          //   ),
                          // ),


                          //NEWLY ADDED!!!!!!!!!!!
                          Expanded(
                            child: FutureBuilder(
                                future: DBFuture().returnEarrings(),
                                builder: (context, AsyncSnapshot snapshot)
                                {
                                  if (!snapshot.hasData)
                                  {
                                    return Container(width:0.0,height:0.0);
                                  }
                                  else
                                    {
                                  //  return
                                   //   Container(
                                    //    child: ListView.builder(
                                        //    itemCount: snapshot.data.length,
                                           // scrollDirection: Axis.horizontal,
                                         //   itemBuilder: (BuildContext context,int index) {
                                              // return Text(
                                              //     '${snapshot.data[index]["name"]}'
                                              // );
                                              return GridView.builder(
                                                itemCount: snapshot.data.length,
                                                shrinkWrap: true,
                                                gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  crossAxisSpacing: 4.0,
                                                  childAspectRatio: (itemWidth / itemHeight),
                                                  mainAxisSpacing: 5.0,
                                                ),
                                                itemBuilder: (BuildContext context, int index)
                                                {
                                                  // return Image.asset(images[index]);
                                                  return Container(
                                                    padding: EdgeInsets.all(20.0),
                                                    child: InkResponse(
                                                      onTap: () {
                                                        // print(earring.length);
                                                        print(snapshot.data[index]);
                                                      },
                                                      child: Center(
                                                        child: GridTile(
                                                          footer: Text('${snapshot.data[index]["name"]}'),
                                                          child: Container(
                                                            padding:
                                                            EdgeInsets.fromLTRB(0, 1, 0, 0),
                                                            margin: EdgeInsets.all(4),
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                    height: size.height * 0.001),


                                                                Image.network(snapshot.data[index]["thumbnail"]),

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
                                              );
                                            //}
                                            //)
                                    //);
                                  }
                                }),
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
