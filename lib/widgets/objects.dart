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
        
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xFFffead7),
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
                fileName: 'assets/cube/model1.obj',
                scale: Vector3(15.0,15.0,15.0),
                position: Vector3(0.0, -4.5, 0.0),
                backfaceCulling : false,//간격 벌어지는거
                // rotation: Vector3(10,4,10),
                lighting: true,

                ),
              );
            },
          ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          // shape: shape,
          label: const Text('가즈아앙',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          icon: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 30,),
          backgroundColor: Colors.amber,
        ),
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