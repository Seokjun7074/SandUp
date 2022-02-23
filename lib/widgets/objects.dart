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

  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  void generateSphereObject(Object parent, String name, double radius,
      bool backfaceCulling, String texturePath) async {
    final Mesh mesh =
        await generateSphereMesh(radius: radius, texturePath: texturePath);
    parent
        .add(Object(name: name, mesh: mesh, backfaceCulling: backfaceCulling));
    _scene.updateTexture();
  }

  void _onSceneCreated(Scene scene) {
    _scene = scene;
    _scene.camera.position.z = 2.5;
    _scene.camera.position.y = 8;

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
        _level!, 'surface', 0.485, true, 'assets/cube/SAA2EF~1.JPG');
    _scene.world.add(_level!);

    // texture from https://www.solarsystemscope.com/textures/
    _back = Object(name: 'back', scale: Vector3(20.0, 20.0, 20.0));
    generateSphereObject(
        _back, 'surface', 0.5, false, 'assets/images/background.png');
    _scene.world.add(_back);
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
    return Scaffold(
      // backgroundColor: const Color(0xFFffead7),
      // appBar: AppBar(
      //   elevation: 0,
      //   centerTitle: true,
      //   backgroundColor: Color(0xFFffead7),
      // ),
      // body: ModelViewer(
      //   backgroundColor: Colors.teal[50],
      //   src: 'assets/cube/model1-2.glb',
      //   autoPlay: true,
      //   autoRotate: true,
      //   cameraControls: true,
      //   ),
      body: Cube(onSceneCreated: _onSceneCreated),
      floatingActionButton: _model == ""
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: FloatingActionButton.extended(
                onPressed: () => onSelect(sandup),
                // Add your onPressed code here!

                // shape: shape,
                label: const Text('가즈아앙',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                icon: const Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                backgroundColor: Colors.amber,
              ),
            )
          : Stack(
              children: [
                cam.Camera(
                  widget.cameras,
                  _model,
                  setRecognitions,
                ),
                BndBox(
                    _recognitions ?? [],
                    math.max(_imageHeight, _imageWidth),
                    math.min(_imageHeight, _imageWidth),
                    screen.height,
                    screen.width,
                    _model),
              ],
            ),

      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      //   child: ElevatedButton(
      //     onPressed: () {
      //       // Add your onPressed code here!
      //     },
      //     child: const Text('카메라 가즈앙아'),
      //   ),
      // ),
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
