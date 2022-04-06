import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:shop_n_preview/Screens/Home/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:shop_n_preview/Screens/Home/previewitem.dart';

class ProductDetailPage extends StatefulWidget {
  //final String id;
  final String name;
  //final String code;
  final String img;
  final int price;
  //final String promotionPrice;
  // final List size;
  final String type;

  const ProductDetailPage(
      {Key key,
      // this.id,
      this.name,
      // this.code,
      this.img,
      this.price,
      //   this.promotionPrice,
      //  this.size,
      this.type})
      : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int activeSize = 0;
  int activeColor = 0;
  String activeImg = '';
  int modelPrice;
  int qty = 1;

  static const platform = const MethodChannel('going.native.for.userdata');
  String _username = 'Data received: No data';
  String _userId = '1111';

  Future<void> _getDataFromAdnroid() async {
    String username;
    try {
      final result = await platform.invokeMethod('launchApp2');
      username = 'Data received: $result';
    } on PlatformException catch (e) {
      username = 'Data received: No data';
    }

    setState(() {
      _username = username;
    });
  }

  @override
  void initState() {
    // = price;
    // TODO: implement initState
    super.initState();
    setState(() {
      activeImg = widget.img;
      modelPrice = widget.price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomSheet: getBottom(),
    );
  }

  void multiplyPrice(int qty) {
    modelPrice = qty * widget.price;
  }

  Widget getBottom() {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 80,
      width: size.width,
      child: SingleChildScrollView(
        child: Row(
          children: [
            FlatButton(
                color: primary,
                height: 100,
                minWidth: 168,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Item has been added to Cart!"),
                      duration: Duration(seconds: 3),
                    ),
                  );
                  // your add cart here
                },
                child: Row(
                  children: [
                    Text(
                      "ADD TO CART",
                      style: TextStyle(fontSize: 18, color: white),
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            FlatButton(
                height: 100,
                minWidth: 192,
                color: primary,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                     return LivePreview(
                       itemNum: modelPrice,
                     );
                    }),
                    // print(nameController.text);
                    // print(passwordController.
                    // text
                  );
                },
                child: Row(
                  children: [
                    Text(
                      "LIVE PREVIEW",
                      style: TextStyle(fontSize: 18, color: white),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget getBody() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(Icons.arrow_back_ios)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 2,
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.img), fit: BoxFit.cover)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Name :",
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Text(
                      widget.name,
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, right: 20),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Text(
            //         "Code :",
            //         style: TextStyle(fontSize: 16, height: 1.5),
            //       ),
            //       SizedBox(
            //         width: 20,
            //       ),
            //       Flexible(
            //         child: Text(
            //           widget.code,
            //           style: TextStyle(fontSize: 16, height: 1.5),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Price :",
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                      child: Row(
                    children: <Widget>[
                      // Text(
                      //   widget.price + " PKR",
                      //   style: TextStyle(fontSize: 16, height: 1.5),
                      // ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        modelPrice.toString() + " pkr",
                        style: TextStyle(
                            fontSize: 20,
                            height: 1.5,
                            color: primary,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, right: 20),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Text(
            //         "Size :",
            //         style: TextStyle(fontSize: 16, height: 1.5),
            //       ),
            //       SizedBox(
            //         width: 20,
            //       ),
            //       Flexible(
            //           child: Wrap(
            //               children: List.generate(widget.size.length, (index) {
            //         return Padding(
            //           padding: const EdgeInsets.only(right: 20),
            //           child: InkWell(
            //             onTap: () {
            //               setState(() {
            //                 activeSize = widget.size[index]['id'];
            //               });
            //             },
            //             child: Container(
            //               decoration: BoxDecoration(
            //                   border: Border.all(
            //                     width: 2,
            //                     color: activeSize == widget.size[index]['id']
            //                         ? primary
            //                         : Colors.transparent,
            //                   ),
            //                   borderRadius: BorderRadius.circular(5)),
            //               child: Padding(
            //                 padding: const EdgeInsets.only(
            //                     top: 12, bottom: 12, right: 15, left: 15),
            //                 child: Text(
            //                   widget.size[index]['value'],
            //                   style: TextStyle(fontSize: 16, height: 1.5),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         );
            //       }))),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20, right: 20),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: <Widget>[
            //       Text(
            //         "Color :",
            //         style: TextStyle(fontSize: 16, height: 1.5),
            //       ),
            //       SizedBox(
            //         width: 20,
            //       ),
            //       Flexible(
            //           child: Wrap(
            //               children: List.generate(widget.type.length, (index) {
            //         return Padding(
            //           padding: const EdgeInsets.only(right: 20),
            //           child: InkWell(
            //             onTap: () {
            //               setState(() {
            //              //   activeColor = widget.color[index]['id'];
            //                // activeImg = widget.color[index]['value'];
            //               });
            //             },
            //             child: Container(
            //               width: 50,
            //               height: 50,
            //               decoration: BoxDecoration(
            //                   image: DecorationImage(
            //                       image: AssetImage(
            //                         ' ' // widget.color[index]['value']
            //                       ),
            //                       fit: BoxFit.cover),
            //                   border: Border.all(
            //                     width: 2,
            //                     color: primary
            //                         //: Colors.transparent,
            //                   ),
            //                   borderRadius: BorderRadius.circular(5)),
            //             ),
            //           ),
            //         );
            //       }))),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Qty :",
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                      child: Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          if (qty > 1) {
                            setState(() {
                              qty = --qty;
                              multiplyPrice(qty);
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: black.withOpacity(0.5))),
                          width: 35,
                          height: 35,
                          child: Icon(
                            LineIcons.minus,
                            color: black.withOpacity(0.5),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Text(
                        qty.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            qty = ++qty;
                            multiplyPrice(qty);
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: black.withOpacity(0.5))),
                          width: 35,
                          height: 35,
                          child: Icon(
                            LineIcons.plus,
                            color: black.withOpacity(0.5),
                          ),
                        ),
                      )
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
