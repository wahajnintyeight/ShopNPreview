import 'dart:ui';

import 'package:shop_n_preview/Screens/Home/home.dart';
import 'package:shop_n_preview/Screens/Home/home.dart';
import 'package:shop_n_preview/Screens/Welcome/Customer/Welcome/welcome.dart';
import 'package:shop_n_preview/services/dbFuture.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_n_preview/Screens/Welcome/Designer/Welcome/dzwelcome.dart';
import 'package:shop_n_preview/Screens/Welcome/Retailer/Welcome/retailwelcome.dart';
import 'package:shop_n_preview/Screens/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:shop_n_preview/Screens/Welcome/Customer/Welcome/welcome.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shop_n_preview/Screens/Home/constant/data_json.dart';
import 'home.dart';
import 'package:shop_n_preview/Screens/Home/theme/colors.dart';
import 'home.dart';
import 'package:shop_n_preview/Screens/Home/productdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPageCus(),
    ));
final String Jewelrytype = "";
final int jID = 0;

class MainPageCus extends StatefulWidget {
  final JewelryType jT;

  const MainPageCus({Key key, this.jT}) : super(key: key);

  @override
  _MainPageCusState createState() => _MainPageCusState();
}

class _MainPageCusState extends State<MainPageCus> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  List<JewelryType> JT;

  @override
  void initState() {
    // TODO: implement initState
    // JT.add(widget.jT);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int activeMenu = 0;
    String jName = widget.jT.jewelryType;
    String ID = widget.jT.jID.toString();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () =>
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return CusHome();
                  // })),
                  Navigator.pop(context)),
          title: Text("Shop 'N' Preview"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Viewing $jName Earrings",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(LineIcons.search),
                        SizedBox(
                          width: 15,
                        ),
                        Icon(LineIcons.shoppingCart)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  // child: Row(
                  //     children: List.generate(menuItems.length, (index) {
                  //   return Padding(
                  //     padding: const EdgeInsets.only(right: 20),
                  //     child: InkWell(
                  //       onTap: () {
                  //         setState(() {
                  //           activeMenu = index;
                  //         });
                  //       },
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //             border: Border(
                  //                 bottom: BorderSide(
                  //                     color: activeMenu == index
                  //                         ? primary
                  //                         : Colors.transparent,
                  //                     width: 2))),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(8.0),
                  //           child: Text(
                  //             menuItems[index],
                  //             style: TextStyle(fontSize: 17),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   );
                  // })),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  child: Container(
                      child: FutureBuilder(
                future: DBFuture().returnEarrings(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return Container(width: 50.0, height: 50.0);
                  } else {
                    print(snapshot.data.length);
                    return Container(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            print(snapshot.data);
                            if (snapshot.data[index]["type"] == jName) {
                              print(snapshot.data[index]["name"]);
                              // return Text(snapshot.data[index]["name"]);
                              return InkWell(
                                onTap: () {
                                  print(snapshot.data[index]['thumbnail']);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ProductDetailPage(
                                                name: snapshot.data[index]["name"],//  dataItems[index]['name'],
                                                img: snapshot.data[index]['thumbnail'],
                                                price: snapshot.data[index]["price"],// dataItems[index]['price'].toString(),
                                                type: snapshot.data[index]['type'],
                                              )));
                                },
                                child: Card(
                                    elevation: 2,
                                    child: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Hero(
                                          tag: snapshot.data[index]["name"]
                                              .toString(),
                                          child: Container(
                                            width: (size.width - 16) / 2,
                                            height: (size.width - 16) / 2,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        snapshot.data[index]
                                                            ["thumbnail"]),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                            snapshot.data[index]["name"],
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                            "Rs. " +
                                                snapshot.data[index]["price"]
                                                    .toString() +
                                                "/.",
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )),
                              );
                            } else {
                              print("THIS WORKS!!!");
                              return Container(width: 0.0, height: 0.0);
                            }
                          }),
                    );
                  }
                  //    );
                },
              ))
                  //List.generate(dataItems.length, (index)
                  //{

                  //   }
                  //    ),
                  )
            ],
          ),
        ));
  }
}
