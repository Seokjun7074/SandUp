import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:model_viewer/model_viewer.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({
    Key? key,
    required this.Cam,
    required this.ProgressBar,
  }) : super(key: key);
  final Widget Cam;
  final Widget ProgressBar;

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.Cam,
          // widget.ProgressBar,
          // Cube(
          //   onSceneCreated: (Scene scene) {
          //     scene.world.add(
          //       Object(
          //         position: Vector3(0, 0, 20),
          //         scale: Vector3(31.0, 31.0, 31.0),
          //         rotation: Vector3(0, 0, 0),
          //         backfaceCulling: false,
          //         fileName: 'assets/cube/model1.obj',
          //       ),
          //     );
          //   },
          // ),

          // Positioned(

          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20),
          //       border: Border.all(style: BorderStyle.solid),
          //     ),
          //     height: 100,
          //     width: 100,
          //     // child: ModelViewer(
          //     //   // backgroundColor: Colors.white70,
          //     //   src: "assets/cube/Astronaut.glb",
          //     //   // ar: true,
          //     //   autoPlay: true,
          //     //   autoRotate: true,
          //     //   cameraControls: true,
          //     //   autoRotateDelay: 0,
          //     // ),

          //   ),
          // ),

          Positioned(
            top: MediaQuery.of(context).size.height - 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.amberAccent,
                      ),
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.greenAccent,
                      ),
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueAccent,
                      ),
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.redAccent,
                      ),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
