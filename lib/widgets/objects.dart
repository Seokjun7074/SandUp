import 'dart:async';

import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:lottie/lottie.dart';
import 'package:tflite/tflite.dart';
import 'package:jolzak/camera/models.dart';
import 'package:jolzak/camera/camera.dart' as cam;
import 'package:jolzak/camera/bndbox.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:model_viewer/model_viewer.dart';
import 'package:jolzak/camera/arcore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audioplayers/audioplayers.dart';

import 'buttom_drawer.dart';

class ObjectsArguments {
  final int index;
  final String count;

  ObjectsArguments({required this.index, required this.count});
}

class Objects extends StatefulWidget {
  final List<dynamic> cameras;
  Objects(this.cameras);

  @override
  _ObjectsState createState() => _ObjectsState();
}

class _ObjectsState extends State<Objects> with SingleTickerProviderStateMixin {
  late Scene _scene;
  Object? _level;
  late Object _back;
  // late AnimationController _controller;

  bool show = false;

  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  loadModel() async {
    String? res;
    switch (_model) {
      case sandup:
        res = await Tflite.loadModel(
          model: "assets/model/model.tflite",
          labels: "assets/model/labels.txt",
        );
    }
    print(res);
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  //딜레이
  bool delay = true;

  void makeDelay() {
    if (this.mounted) {
      setState(() {
        delay = false;
      });
    }
  }

  //이미지 토글
  bool _visibility = false;

  void showWidget() {
    setState(() {
      _visibility = true;
    });
  }

  void hideWidget() {
    setState(() {
      _visibility = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final args = ModalRoute.of(context)!.settings.arguments as ObjectsArguments;
    String level = args.index.toString();
    int count = int.parse(args.count.toString());
    print('Level of this page:' + level + 'ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ');
    // 리스트에서 받아온 인덱스(레벨)

    Timer(Duration(milliseconds: 1500), () => makeDelay());
    return Scaffold(
      appBar: _model == ""
          ? AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.amber[50],
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Text(
                  'Level ${level}',
                  style: TextStyle(
                    fontSize: 35.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber[600],
                  ),
                ),
              ),
              centerTitle: true,
            )
          : null,
      body: _model == ""
          ? Stack(
              children: [
                Positioned(
                  child: ModelViewer(
                    backgroundColor: Colors.amber[50],
                    // src: 'assets/cube/sand.glb',
                    src: 'assets/test/model_01.glb',
                    autoPlay: true,
                    autoRotate: true,
                    cameraControls: true,
                    // ar: true,
                  ),
                ),
                Positioned(
                  top: 10,
                  child: Container(
                    width: width,
                    height: height / 7,
                    // color: Colors.black38,
                    child: Row(
                      mainAxisAlignment: count < 6
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 1; i <= count; i++)
                          Padding(
                            padding: count < 6
                                ? const EdgeInsets.fromLTRB(5.0, 0, 10, 40)
                                : const EdgeInsets.fromLTRB(0, 0, 0, 40),
                            child: Container(
                              width: width / 7,
                              height: width / 7,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.amber, width: 2),
                                color: Colors.amber[50],
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 1.0,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(
                                'assets/images/piece_1.png',
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ),
                      ],
                    ),
                    // child: ListView.builder(
                    //   // padding: const EdgeInsets.all(8),
                    //   scrollDirection: Axis.horizontal,
                    //   itemCount: count + 2,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Container(
                    //         color: Colors.amber,
                    //         width: 100,
                    //       ),
                    //     );
                    //   },
                    // ),
                  ),
                ),
                Positioned(
                  bottom: 20.h,
                  right: 30.w,
                  left: 30.w,
                  child: GestureDetector(
                    onTap: () => onSelect(sandup),
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5.0,
                            offset: Offset(0, 10), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: 55.h,
                      width: 90.w,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '만들어 볼까요?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.amber[100],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: delay,
                  child: Container(
                    height: height,
                    color: Colors.amber[50],
                    child: Lottie.asset('assets/effects/loading.json'),
                  ),
                ),
              ],
            )
          : Stack(
              children: [
                // ObjectGesturesWidget(),
                cam.Camera(
                  widget.cameras,
                  _model,
                  setRecognitions,
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                //   child: Image.asset('assets/images/circle.png'),
                // ),
                BndBox(
                    _recognitions ?? [],
                    math.max(_imageHeight, _imageWidth),
                    math.min(_imageHeight, _imageWidth),
                    screen.height,
                    screen.width,
                    _model),
                Visibility(
                  visible: _visibility,
                  child: Positioned(
                    right: 0,
                    left: 0,
                    // bottom: 100.h,
                    child: Container(
                      width: width / 2,
                      height: height,
                      // child: Image.asset('assets/cube/Pyramid.gif'),
                      child: ModelViewer(
                        backgroundColor: Colors.amber[50],
                        // src: 'assets/cube/sand.glb',
                        src: 'assets/test/model_01.glb',
                        autoPlay: true,
                        autoRotate: true,
                        cameraControls: true,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    color: Color.fromRGBO(0, 0, 0, 0.7),
                    height: 110.h,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              child: Icon(
                                Icons.lightbulb_outline,
                                size: 50.sp,
                                color: Colors.amber[300],
                              ),
                              onTap: () => showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ButtomDrawer();
                                  }),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  {_visibility ? hideWidget() : showWidget()},
                              child: Container(
                                child: Icon(Icons.view_in_ar_outlined,
                                    size: 50.sp,
                                    // color: Colors.amber[300],
                                    color: !_visibility
                                        ? Colors.amber[300]
                                        : Colors.amber[800]),
                              ),
                            ),
                            Container(
                              child: Icon(
                                Icons.camera,
                                size: 50.sp,
                                color: Colors.amber[300],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
