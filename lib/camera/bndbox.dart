import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'models.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:jolzak/camera/arcore.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:progress_stepper/progress_stepper.dart';
import 'package:lottie/lottie.dart';


int status = 0;
int eff_timer = 0;


class BndBox extends StatefulWidget {
  static const platform = MethodChannel('ondeviceML');

  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;

  BndBox(
    this.results,
    this.previewH,
    this.previewW,
    this.screenH,
    this.screenW,
    this.model,
  );

  @override
  _BndBoxState createState() => _BndBoxState();
}

class _BndBoxState extends State<BndBox> {

  AudioCache audioCache = AudioCache();


  @override
  void initState() {
    super.initState();
  }

  void resetCounter() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderStrings() {
      var lists = <Widget>[];
      final now = DateTime.now();
      final later = now.add(const Duration(seconds: 5));

      return widget.results.map((re) {
        if ( status == 0 && re["label"] == "step1" && re["confidence"] > 0.5) {
          audioCache.play('audio/sound.mp3');
          status = 1;
          eff_timer = 1;
          Future.delayed(Duration(seconds: 4)).then((value) => eff_timer=0);

        }
        if (status == 1 && re["label"] == "step2" && re["confidence"] > 0.8) {
          audioCache.play('audio/sound.mp3');
          status = 2;
          eff_timer = 1;
          Future.delayed(Duration(seconds: 4)).then((value) => eff_timer=0);
        }
        if (status == 2 && re["label"] == "step3" && re["confidence"] > 0.8) {
          audioCache.play('audio/sound.mp3');
          status = 3;
        }


        return Positioned(
          left: 30,
          top: 30,
          child: Text(
            "${re["label"]} ${(re["confidence"] * 100).toStringAsFixed(0)}% ${status}",
            style: TextStyle(
              color: Color.fromRGBO(37, 213, 253, 1.0),
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList();
    }



    return Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[

          //하단 메뉴를 위해 주석처리
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(32.0, 0, 32.0, 16.0),
          //   child: Text(
          //     _label.toString(),
          //     style: TextStyle(
          //       fontSize: 15,
          //       fontWeight: FontWeight.bold,
          //       color: Colors.green,
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.fromLTRB(25.0, 60.0, 25.0, 25.0),
            child: ProgressStepper(
              width: 330,
              height: 20,
              stepCount: 3,
              color: Colors.white,
              progressColor: Colors.amber,
              currentStep: status,
            )
          ),

          if (eff_timer == 1)
            Container(
              child: Lottie.asset('assets/effects/fireworks.json'),
            ),



          // Container(
          //     child: Lottie.asset('assets/effects/fireworks.json')
          // ),
        ],

      ),
      Stack(
        children: _renderStrings(),
      ),
    ],

    );
  }
}
