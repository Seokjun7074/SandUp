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

import 'buttom_drawer.dart';

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
  late AnimationController _controller;

  bool show = false;

  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  void generateSphereObject(Object parent, String name, double radius,
      bool backfaceCulling, String texturePath) async {
    final Mesh mesh =
        await generateSphereMesh(radius: radius, texturePath: texturePath);
    // parent
    //     .add(Object(name: name, mesh: mesh, backfaceCulling: backfaceCulling));
    _scene.updateTexture();
  }

  void _onSceneCreated(Scene scene) {
    _scene = scene;
    // _scene.camera.position.z = 2.5;
    // _scene.camera.position.y = 8;
    _scene.camera.position.z = 1.7;
    _scene.camera.position.y = 4.0;

    // model from https://free3d.com/3d-model/planet-earth-99065.html
    // _earth = Object(name: 'earth', scale: Vector3(10.0, 10.0, 10.0), backfaceCulling: true, fileName: 'assets/earth/earth.obj');

    // create by code
    _level = Object(
        name: 'level',
        scale: Vector3(11.0, 11.0, 11.0),
        rotation: Vector3(0.0, 0.0, 5.0),
        backfaceCulling: false,
        fileName: 'assets/cube/model1.obj');
    generateSphereObject(
        _level!, 'surface', 2.0, true, 'assets/cube/SAA2EF~1.JPG');
    _scene.world.add(_level!);

    // texture from https://www.solarsystemscope.com/textures/
    // _back = Object(name: 'back', scale: Vector3(20.0, 20.0, 20.0));
    // generateSphereObject(
    //     _back, 'surface', 0.5, false, 'assets/images/background.png');
    // _scene.world.add(_back);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 30000), vsync: this)
      ..addListener(() {
        if (_level != null) {
          _level!.rotation.y = _controller.value * 360;
          _level!.updateTransform();
          _scene.update();
        }
      })
      ..repeat();
  }

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

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // body: Cube(onSceneCreated: _onSceneCreated),
      body: _model == ""
          ? Stack(
              children: [
                ModelViewer(
                  backgroundColor: Colors.teal[200],
                  src: 'assets/cube/Pyramid.glb',
                  autoPlay: true,
                  autoRotate: true,
                  cameraControls: true,
                ),
                // Cube(onSceneCreated: _onSceneCreated),
                Positioned(
                  bottom: 30.h,
                  right: 20.w,
                  child: GestureDetector(
                    onTap: () => onSelect(sandup),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.redAccent,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 7,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 1), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(40)),
                      height: 60.h,
                      width: 100.w,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 40.sp,
                          color: Colors.grey[800],
                        ),
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
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
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
                                Icons.home,
                                size: 50.sp,
                                color: Colors.grey[800],
                              ),
                              onTap: () => print('@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'),
                            ),
                            Container(
                              child: Icon(
                                Icons.camera,
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
                Positioned(
                  bottom: 70.h,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return ButtomDrawer();
                        }),
                    child: Container(
                      height: 70.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_upward_rounded,
                        size: 60.sp,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                ),
                // AnimatedPositioned(
                //   duration: Duration(
                //     milliseconds: 200,
                //   ),
                //   bottom: show ? 0 : -height / 2,
                //   child: GestureDetector(
                //     onPanEnd: (details) => {
                //       if (details.velocity.pixelsPerSecond.dy > 100)
                //         {
                //           setState(() {
                //             show = !show;
                //           })
                //         }
                //     },
                //     child: ButtomDrawer(),
                //   ),
                // ),
              ],
            ),
    );
  }
}

Future<Mesh> generateSphereMesh(
    {num radius = 0.5,
    int latSegments = 32,
    int lonSegments = 64,
    required String texturePath}) async {
  int count = (latSegments + 1) * (lonSegments + 1);
  List<Vector3> vertices = List<Vector3>.filled(count, Vector3.zero());
  List<Offset> texcoords = List<Offset>.filled(count, Offset.zero);
  List<Polygon> indices =
      List<Polygon>.filled(latSegments * lonSegments * 2, Polygon(0, 0, 0));

  int i = 0;
  for (int y = 0; y <= latSegments; ++y) {
    final double v = y / latSegments;
    final double sv = math.sin(v * math.pi);
    final double cv = math.cos(v * math.pi);
    for (int x = 0; x <= lonSegments; ++x) {
      final double u = x / lonSegments;
      vertices[i] = Vector3(radius * math.cos(u * math.pi * 2.0) * sv,
          radius * cv, radius * math.sin(u * math.pi * 2.0) * sv);
      texcoords[i] = Offset(1.0 - u, 1.0 - v);
      i++;
    }
  }

  i = 0;
  for (int y = 0; y < latSegments; ++y) {
    final int base1 = (lonSegments + 1) * y;
    final int base2 = (lonSegments + 1) * (y + 1);
    for (int x = 0; x < lonSegments; ++x) {
      indices[i++] = Polygon(base1 + x, base1 + x + 1, base2 + x);
      indices[i++] = Polygon(base1 + x + 1, base2 + x + 1, base2 + x);
    }
  }

  ui.Image texture = await loadImageFromAsset(texturePath);
  final Mesh mesh = Mesh(
      vertices: vertices,
      texcoords: texcoords,
      indices: indices,
      texture: texture,
      texturePath: texturePath);
  return mesh;
}
