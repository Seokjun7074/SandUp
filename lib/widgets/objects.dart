import 'dart:async';
import 'dart:math';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:jolzak/widgets/random_text.dart';
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
import 'package:flutter_svg/flutter_svg.dart';
import 'buttom_drawer.dart';

class ObjectsArguments {
  final int index;
  final String count;
  final List block;
  final List copy_block;

  ObjectsArguments({
    required this.index,
    required this.count,
    required this.block,
    required this.copy_block,
  });
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

  // GlobalKey<ScaffoldState> _scaffoldKey =
  //     GlobalKey<ScaffoldState>(); //Drawer 커스텀 키

  bool show = false;

  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";
  int random_idx = 0;

  bool selected = false;

  @override
  void initState() {
    // TODO: implement initState
    random_idx = Random().nextInt(3);

    super.initState();
  }

  // @override
  // void dispose() {
  //   // _controller.dispose();
  //   super.dispose();
  // }

  loadModel() async {
    String? res;
    switch (_model) {
      case 'level1':
        res = await Tflite.loadModel(
          model: "assets/model/model.tflite",
          labels: "assets/model/labels.txt",
        );
        break;
      case 'level2':
        res = await Tflite.loadModel(
          model: "assets/model/level2_model.tflite",
          labels: "assets/model/level2_labels.txt",
        );
        break;
      case 'level3':
        res = await Tflite.loadModel(
          model: "assets/model/level2_model.tflite",
          labels: "assets/model/level2_labels.txt",
        );
        break;
    }
    print(res);
  }

  onSelect(model) {
    if (model == 1) model = 'level1';
    if (model == 2) model = 'level2';
    if (model == 3) model = 'level3';
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

  void loadAR() {
    setState(() {
      selected = !selected;
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
  bool _visibility = true;
  bool cam_visibility = false;

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

  //튜토리얼
  int tutorial_num = 1;

  void nextStep() {
    setState(() {
      tutorial_num++;
      if (tutorial_num >= 5) {
        hideWidget();
        cam_visibility = true;
      }
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
    List block = args.block;
    List copy_block = args.copy_block;
    //
    //튜토리얼 사진 사이즈
    String device_width = "n";
    if (width > 710) {
      device_width = 'gt';
    }
    // print('Level of this page:' + level + 'ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ');
    // print(block[1]);
    // 리스트에서 받아온 props
    // setState(() {
    //   copy_block = [...block];
    // });
    // print('블록:" ${block}');
    // print('카피블록:" ${copy_block}');
    Timer(Duration(milliseconds: 1500), () => makeDelay()); //딜레이 만들기

    List guide_text = [
      'Tip: 그림을 눌러보세요! 필요한 블럭을 볼 수 있답니다!',
      'Tip: 모양이 이상하다면? 블럭을 뒤집어 쌓아보세요!',
      'Tip: 빨간색 먼저 쌓아주세요!',
    ];

    return Scaffold(
      backgroundColor: Colors.black,
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
                  child: Container(
                    height: height,
                    child: ModelViewer(
                      backgroundColor: Colors.amber[50],
                      // src: 'assets/cube/sand.glb',
                      src: 'assets/objects/castle${level}.glb',
                      autoPlay: true,
                      autoRotate: true,
                      cameraControls: true,
                      // ar: true,
                    ),
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
                        for (int i = 0; i < count; i++)
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
                                'assets/blocks/SANDUP_block_block${block[i][0]}.png',
                                width: 100,
                                height: 100,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.h,
                  right: 30.w,
                  left: 30.w,
                  child: GestureDetector(
                    onTap: () => onSelect(args.index),
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
          // 카메라부분
          : Stack(
              children: [
                // ObjectGesturesWidget(),

                Visibility(
                  visible: cam_visibility,
                  child: cam.Camera(
                    widget.cameras,
                    _model,
                    setRecognitions,
                  ),
                ),
                BndBox(
                  _recognitions ?? [],
                  level,
                  count,
                  block,
                  copy_block,
                ),
                Positioned(
                  top: 75.h,
                  left: 25.w,
                  right: 25.w,
                  child: Container(
                    width: width * 3 / 4,
                    height: 28.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[800]?.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.privacy_tip_sharp,
                          color: Colors.amber[100],
                        ),
                        Text(
                          '  ${guide_text[random_idx]}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
                Visibility(
                  visible: _visibility,
                  child: Positioned(
                    child: Image.asset(
                        'assets/tutorial/t_${device_width}${tutorial_num}.png'),
                  ),
                ),
                Visibility(
                  visible: _visibility,
                  child: Positioned(
                    bottom: height * 1 / 3,
                    left: width / 3,
                    right: width / 3,
                    child: GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          tutorial_num >= 4 ? 'START' : 'NEXT',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28.sp,
                            letterSpacing: 3,
                            color: Colors.amber[800],
                          ),
                        ),
                        width: width / 3,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onTap: () {
                        nextStep();
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
