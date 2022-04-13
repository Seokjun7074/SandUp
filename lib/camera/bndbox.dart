import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'models.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:jolzak/camera/arcore.dart';

int status = 0;

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
  List<dynamic> _inputArr = [];
  String _label = 'progress_bar';
  double _percent = 0;
  double _counter = 0;

  @override
  void initState() {
    super.initState();
    _counter = 0;
  }

  void resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderStrings() {
      var lists = <Widget>[];

      return widget.results.map((re) {
        if (re["label"] == "step1" && re["confidence"] > 0.9) {
          status = 1;
        }
        if (status == 1 && re["label"] == "step2" && re["confidence"] > 0.9) {
          status = 2;
        }
        if (status == 2 && re["label"] == "step3" && re["confidence"] > 0.9) {
          status = 3;
        }

        return Positioned(
          left: 30,
          top: 30,
          width: widget.screenW,
          height: widget.screenH,
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
            child: LinearPercentIndicator(
              animation: true,
              lineHeight: 20.0,
              animationDuration: 2500,
              animateFromLastPercent: true,
              percent: status * 0.33,
              center: Text("${(status * 33.3).toStringAsFixed(1)} %"),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.purpleAccent,
            ),
          ),
        ],
      ),
      Stack(
        children: _renderStrings(),
      ),
      // Container(
      //     margin: EdgeInsets.fromLTRB(350, 50, 0, 0), //margin here
      //     child: FloatingActionButton(
      //       elevation: 2,
      //       onPressed: () {
      //         Navigator.pushNamed(context, "/arcore");
      //       },
      //     ),
      // ),
    ],
    );
  }

  // Future<void> _getPrediction(List<double> steps) async {
  //   try {
  //     final double result = await BndBox.platform.invokeMethod('predictData', {
  //       "model": widget.model,
  //       "arg": steps,
  //     }); // passing arguments
  //     if (result <= 1) {
  //       _percent = 0;
  //       _percent = result;
  //     }
  //     _label =
  //         result < 0.5 ? "Wrong step" : (result * 100).toStringAsFixed(0) + "%";
  //     updateCounter(_percent);
  //
  //     print("Final Label: " + result.toString());
  //   } on PlatformException catch (e) {}
  // }
  //
  // void updateCounter(percent) {
  //   if (percent > 0.5) {
  //     (_counter += percent / 100) >= 1
  //         ? _counter = 1.0
  //         : _counter += percent / 100;
  //   }
  //   print("Counter: " + _counter.toString());
  // }
}
