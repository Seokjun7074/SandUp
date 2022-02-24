import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
          widget.ProgressBar,
        ],
      ),
    );
  }
}
