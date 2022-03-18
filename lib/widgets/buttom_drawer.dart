import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:model_viewer/model_viewer.dart';

class ButtomDrawer extends StatefulWidget {
  const ButtomDrawer({Key? key}) : super(key: key);

  @override
  State<ButtomDrawer> createState() => _ButtomDrawerState();
}

class _ButtomDrawerState extends State<ButtomDrawer> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height / 2,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 7,
            blurRadius: 5,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            left: 0,
            child: Container(
              width: width / 2,
              height: height / 5,
              child: Image.asset('assets/cube/Pyramid.gif'),
              //로딩 문제
              // child: ModelViewer(
              //   backgroundColor: Colors.white,
              //   src: 'assets/cube/Pyramid.glb',
              //   autoPlay: true,
              //   autoRotate: true,
              //   cameraControls: true,
              // ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: height / 4,
              width: width,
              color: Colors.amber,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('미리 준비해주세요'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
