import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:model_viewer/model_viewer.dart';

class Objects extends StatefulWidget {
  const Objects({ Key? key }) : super(key: key);

  @override
  _ObjectsState createState() => _ObjectsState();
}

class _ObjectsState extends State<Objects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFffead7),
      appBar: AppBar(
        title: const Text(
          "모래를 쌓아부러",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      // body: ModelViewer(
      //   backgroundColor: Colors.teal[50],
      //   src: 'assets/cube/model1-2.glb',
      //   autoPlay: true,
      //   autoRotate: true,
      //   cameraControls: true,
      //   ),
      body: Cube(
            onSceneCreated:(Scene scene) {
              scene.world.add(Object(
                fileName: 'assets/cube/model1-2.obj', 
                scale: Vector3(15.0,15.0,15.0), 
                position: Vector3(0.0, -4.5, 0.0)
                ),
              );
            },
          ),
      
      
    );
  }
}