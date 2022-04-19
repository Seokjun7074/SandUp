import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import 'package:jolzak/camera/bndbox.dart';
import 'package:jolzak/widgets/objects.dart';
import 'package:jolzak/camera/camera.dart' as cam;
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:jolzak/camera/models.dart';
import 'models.dart';
import 'package:jolzak/camera/arcore.dart';

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

    final size = MediaQuery.of(context).size;

    final scale = 1 / (controller.value.aspectRatio * size.aspectRatio);

    return Scaffold(
      body: Stack(
        children: [
          controller.buildPreview(),
          // Transform.scale(
          //   scale: scale,
          //   child: controller.buildPreview(),
          //   // arcore뷰 가져오기.. ml이 작동 안함..
          //   //ObjectGesturesWidget(),
          // ),
          // ObjectGesturesWidget(),
          // AspectRatio(
          //   aspectRatio: 1 / controller.value.aspectRatio,
          //   child: controller.buildPreview(),
          // ),
        ],
      ),
    );
  }
}
