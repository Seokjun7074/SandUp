import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
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

  ObjectsArguments({required this.index});
}

class Objects extends StatefulWidget {
  final List<CameraDescription> cameras;
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

  //이미지 토글
  bool _visibility = true;

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
    print('Level of this page:' +
        args.index.toString() +
        'ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ');
    // 리스트에서 받아온 인덱스(레벨)
    return Scaffold(
      // body: Cube(onSceneCreated: _onSceneCreated),
      body: _model == ""
          ? Stack(
              children: [
                ModelViewer(
                  backgroundColor: Colors.amber[50],
                  // src: 'assets/cube/sand.glb',
                  src: 'assets/test/sjsj.glb',
                  autoPlay: true,
                  autoRotate: true,
                  cameraControls: true,
                ),
                Positioned(
                  bottom: 30.h,
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
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 7,
                            blurRadius: 10,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: 60.h,
                      width: 100.w,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '만들어 볼까요?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.amber[100],
                          ),
                        ),
                        // child: Icon(
                        //   Icons.arrow_forward_ios_rounded,
                        //   size: 40.sp,
                        //   color: Colors.grey[800],
                        // ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Stack(
              children: [
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
                    top: height / 2,
                    child: Container(
                      width: width / 2,
                      height: height / 5,
                      child: Image.asset('assets/cube/Pyramid.gif'),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.amber[600],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    height: 100.h,
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
                                Icons.info_outline_rounded,
                                size: 50.sp,
                                color: Colors.grey[800],
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
                                child: Icon(
                                  Icons.gif_rounded,
                                  size: 50.sp,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                final player = AudioCache();
                                player.play('audio/sound.mp3');
                              },
                              child: Icon(
                                Icons.play_arrow,
                                size: 50.sp,
                                color: Colors.grey[800],
                              ),
                            ),
                            Container(
                              child: Icon(
                                Icons.camera,
                                size: 50.sp,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Positioned(
                //   bottom: 70.h,
                //   left: 0,
                //   right: 0,
                //   child: GestureDetector(
                //     onTap: () => showModalBottomSheet(
                //         backgroundColor: Colors.transparent,
                //         context: context,
                //         builder: (BuildContext context) {
                //           return ButtomDrawer();
                //         }),
                //     child: Container(
                //       height: 70.h,
                //       width: 70.w,
                //       decoration: BoxDecoration(
                //         boxShadow: [
                //           BoxShadow(
                //             color: Colors.grey.withOpacity(0.2),
                //             spreadRadius: 1,
                //             blurRadius: 5,
                //             offset: Offset(0, 1), // changes position of shadow
                //           ),
                //         ],
                //         color: Colors.white,
                //         shape: BoxShape.circle,
                //       ),
                //       child: Icon(
                //         Icons.arrow_upward_rounded,
                //         size: 60.sp,
                //         color: Colors.grey[800],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
    );
  }
}
