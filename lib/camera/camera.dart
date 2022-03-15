import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import 'package:jolzak/camera/bndbox.dart';
import 'package:jolzak/widgets/objects.dart';
import 'package:jolzak/camera/camera.dart' as cam;

import 'package:jolzak/camera/models.dart';

import 'models.dart';

typedef Callback = void Function(List<dynamic> list, int h, int w);

class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;
  final String model;

  const Camera(
    this.cameras,
    this.model,
    this.setRecognitions,
  );

  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  late CameraController controller;
  bool isDetecting = false;

  List<dynamic>? _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  @override
  void initState() {
    super.initState();

    if (widget.cameras.isEmpty) {
      print('No camera is found');
    } else {
      controller = CameraController(
        widget.cameras[0],
        ResolutionPreset.veryHigh,
      );
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});

        controller.startImageStream((CameraImage img) {
          if (!isDetecting) {
            isDetecting = true;

            int startTime = DateTime.now().millisecondsSinceEpoch;

            if (widget.model == sandup) {
              Tflite.runModelOnFrame(
                bytesList: img.planes.map((plane) {
                  return plane.bytes;
                }).toList(),
                imageHeight: img.height,
                imageWidth: img.width,
                numResults: 1,
              ).then((recognitions) {
                int endTime = DateTime.now().millisecondsSinceEpoch;
                print("Detection took ${endTime - startTime}");
                widget.setRecognitions(recognitions!, img.height, img.width);
                isDetecting = false;
              });
            }
          }
        });
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    var tmp = MediaQuery.of(context).size;
    var screenH = math.max(tmp.height, tmp.width);
    var screenW = math.min(tmp.height, tmp.width);
    tmp = controller.value.previewSize!;
    var previewH = math.max(tmp.height, tmp.width);
    var previewW = math.min(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    //석준 추가

    Size screen = MediaQuery.of(context).size;
    // switch (status) {
    //   case 0:
    //     return Scaffold(
    //       body: Stack(
    //         children: [
    //           AspectRatio(
    //             aspectRatio: 1 / controller.value.aspectRatio,
    //             child: controller.buildPreview(),
    //           ),

    //           // OverflowBox(
    //           //   maxHeight: screenRatio > previewRatio
    //           //       ? screenH
    //           //       : screenW / previewW * previewH,
    //           //   maxWidth: screenRatio > previewRatio
    //           //       ? screenH / previewH * previewW
    //           //       : screenW,
    //           //   child: CameraPreview(controller),
    //           // ),
    //           // Transform.scale(
    //           //   scale: controller.value.aspectRatio / deviceRatio,
    //           //   child: new AspectRatio(
    //           //     aspectRatio: controller.value.aspectRatio,
    //           //     child: CameraPreview(controller),
    //           //   ),
    //           // ),
    //           Padding(
    //             padding: const EdgeInsets.fromLTRB(0, 200, 0, 0),
    //             child: Image.asset('assets/images/circle.png'),
    //           ),
    //           // BndBox(
    //           //     _recognitions ?? [],
    //           //     math.max(_imageHeight, _imageWidth),
    //           //     math.min(_imageHeight, _imageWidth),
    //           //     screen.height,
    //           //     screen.width,
    //           //     widget.model),
    //         ],
    //       ),
    //     );

    //   case 1:
    //     return AspectRatio(
    //       aspectRatio: controller.value.aspectRatio,
    //       child: Stack(
    //         children: [
    //           controller.buildPreview(),
    //           Center(
    //             child: Image.asset('assets/images/camera_overlay3.png'),
    //           ),
    //         ],
    //       ),
    //     );

    //   case 2:
    //     return AspectRatio(
    //       aspectRatio: controller.value.aspectRatio,
    //       child: Stack(
    //         children: [
    //           controller.buildPreview(),
    //           Center(
    //             child: Image.asset('assets/images/camera_overlay4.png'),
    //           ),
    //         ],
    //       ),
    //     );
    // }
    final scale = 1 /
        (controller.value.aspectRatio *
            MediaQuery.of(context).size.aspectRatio);

    return Scaffold(
      body: Stack(
        children: [
          Transform.scale(
            scale: scale,
            child: controller.buildPreview(),
          ),
          // AspectRatio(
          //   aspectRatio: 1 / controller.value.aspectRatio,
          //   child: controller.buildPreview(),
          // ),
        ],
      ),
    );
  }
}
