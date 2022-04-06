import 'dart:io';

import 'package:camera_deep_ar/camera_deep_ar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'config.dart';

//https://github.com/daptee/question-color-deepAr-modified.git
//https://github.com/mtellect/CameraDeepAR.git

// void main() {
//   runApp(LivePreview());
// }

class LivePreview extends StatefulWidget {
  final int itemNum;

  const LivePreview({Key key, this.itemNum}) : super(key: key);

  @override
  _LivePreviewState createState() => _LivePreviewState();
}

class _LivePreviewState extends State<LivePreview> {
  // CameraDeepArControllerX cameraDeepArController;
  // Effects currentEffect = Effects.none;
  // Filters currentFilter = Filters.none;
  // Masks currentMask = Masks.empty;

  final deepArController = CameraDeepArController(config);
  String _platformVersion = 'Unknown';
  bool isRecording = false;
  CameraMode cameraMode = config.cameraMode;
  DisplayMode displayMode = config.displayMode;
  int currentEffect = 0;

  int item_num = 0;

  List get effectList {
    switch (cameraMode) {
      case CameraMode.mask:
        return masks;
        break;
      case CameraMode.effect:
        return effects;
        break;

      case CameraMode.filter:
        return filters;
        break;
      default:
        return masks;
    }
  }

  List masks = [
    "none",
    "assets/aviators",
    "assets/bigmouth",
    "assets/lion",
    "assets/dalmatian",
    "assets/bcgseg",
    "assets/look2",
    "assets/fatify",
    "assets/flowers",
    "assets/grumpycat",
    "assets/koala",
    "assets/mudmask",
    "assets/obama",
    "assets/pug",
    "assets/slash",
    "assets/sleepingmask",
    "assets/smallface",
    "assets/teddycigar",
    "assets/tripleface",
    "assets/twistedface",
  ];
  List effects = [
    "none",
    "assets/fire",
    "assets/heart",
    "assets/blizzard",
    "assets/rain",
  ];
  List filters = [
    "none",
    "assets/drawingmanga",
    "assets/sepia",
    "assets/bleachbypass",
    "assets/realvhs",
    "assets/filmcolorperfection"
  ];

  @override
  void initState() {
    super.initState();
    CameraDeepArController.checkPermissions();
    setState(() {
      item_num = widget.itemNum;
    });
    deepArController.setEventHandler(DeepArEventHandler(onCameraReady: (v) {
      _platformVersion = "onCameraReady $v";
      setState(() {});
    }, onSnapPhotoCompleted: (v) {
      _platformVersion = "onSnapPhotoCompleted $v";
      setState(() {});
    }, onVideoRecordingComplete: (v) {
      _platformVersion = "onVideoRecordingComplete $v";
      setState(() {});
    }, onSwitchEffect: (v) {
      _platformVersion = "onSwitchEffect $v";
      setState(() {});
    }));
  }

  @override
  void dispose() {
    deepArController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () =>
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return CusHome();
                  // })),
                  Navigator.pop(context)),
          title: Text('DeepAR Camera Example $item_num'),
        ),
        body: Stack(
          children: [
            DeepArPreview(deepArController),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(20),
                //height: 250,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        children: [
                          if (displayMode == DisplayMode.image)
                            Expanded(
                              child: FlatButton(
                                onPressed: () async {
                                  String path = "assets/testImage.png";
                                  final file = await deepArController
                                      .createFileFromAsset(path, "test");

                                  // final file = await ImagePicker()
                                  //     .pickImage(source: ImageSource.gallery);
                                  await Future.delayed(Duration(seconds: 1));

                                  deepArController.changeImage(file.path);
                                  print("DAMON - Calling Change Image Flutter");
                                },
                                child: Icon(Icons.image),
                                color: Colors.orange,
                                padding: EdgeInsets.all(15),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.all(15),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(effectList.length, (p) {
                          bool active = currentEffect == p;
                          String imgPath = effectList[p];
                          print("IMG PATH $imgPath");
                          return GestureDetector(
                            onTap: () async {
                              if (!deepArController.value.isInitialized) return;
                              currentEffect = p;
                              deepArController.switchEffect(
                                  cameraMode, imgPath);
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.all(6),
                              width: active ? 70 : 55,
                              height: active ? 70 : 55,
                              alignment: Alignment.center,
                              child: Text(
                                "$p",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: active ? FontWeight.bold : null,
                                    fontSize: active ? 16 : 14,
                                    color:
                                        active ? Colors.white : Colors.black),
                              ),
                              decoration: BoxDecoration(
                                  color: active ? Colors.orange : Colors.white,
                                  border: Border.all(
                                      color:
                                          active ? Colors.orange : Colors.white,
                                      width: active ? 2 : 0),
                                  shape: BoxShape.circle),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: List.generate(CameraMode.values.length, (p) {
                        CameraMode mode = CameraMode.values[p];
                        bool active = cameraMode == mode;

                        return Expanded(
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.all(2),
                            child: TextButton(
                              onPressed: () async {
                                cameraMode = mode;
                                setState(() {});
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.black,
                                primary: Colors.black,
                                // shape: CircleBorder(
                                //     side: BorderSide(
                                //         color: Colors.white, width: 3))
                              ),
                              child: Text(
                                describeEnum(mode),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: active ? FontWeight.bold : null,
                                    fontSize: active ? 16 : 14,
                                    color: Colors.white
                                        .withOpacity(active ? 1 : 0.6)),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: List.generate(DisplayMode.values.length, (p) {
                        DisplayMode mode = DisplayMode.values[p];
                        bool active = displayMode == mode;
                        print('MODE>> $mode');
                        return Expanded(
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.all(2),
                            child: TextButton(
                              onPressed: () async {
                                displayMode = mode;
                                await deepArController.setDisplayMode(
                                    mode: mode);
                                setState(() {});
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.orange,
                                primary: Colors.black,
                                // shape: CircleBorder(
                                //     side: BorderSide(
                                //         color: Colors.white, width: 3))
                              ),
                              child: Text(
                                describeEnum(mode),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: active ? FontWeight.bold : null,
                                    fontSize: active ? 16 : 14,
                                    color: Colors.white
                                        .withOpacity(active ? 1 : 0.6)),
                              ),
                            ),
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  static Future<File> _loadFile(String path, String name) async {
    final ByteData data = await rootBundle.load(path);
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/$name');
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    return tempFile;
  }
}
