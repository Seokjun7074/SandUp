import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'models.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

int status = 0;

class BndBox extends StatefulWidget {
  static const platform = MethodChannel('ondeviceML');

  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;

  BndBox(this.results, this.previewH, this.previewW, this.screenH, this.screenW,
      this.model);

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
    List<Widget> _renderBoxes() {
      return widget.results.map((re) {
        var _x = re["rect"]["x"];
        var _w = re["rect"]["w"];
        var _y = re["rect"]["y"];
        var _h = re["rect"]["h"];
        var scaleW, scaleH, x, y, w, h;

        if (widget.screenH / widget.screenW >
            widget.previewH / widget.previewW) {
          scaleW = widget.screenH / widget.previewH * widget.previewW;
          scaleH = widget.screenH;
          var difW = (scaleW - widget.screenW) / scaleW;
          x = (_x - difW / 2) * scaleW;
          w = _w * scaleW;
          if (_x < difW / 2) w -= (difW / 2 - _x) * scaleW;
          y = _y * scaleH;
          h = _h * scaleH;
        } else {
          scaleH = widget.screenW / widget.previewW * widget.previewH;
          scaleW = widget.screenW;
          var difH = (scaleH - widget.screenH) / scaleH;
          x = _x * scaleW;
          w = _w * scaleW;
          y = (_y - difH / 2) * scaleH;
          h = _h * scaleH;
          if (_y < difH / 2) h -= (difH / 2 - _y) * scaleH;
        }

        return Positioned(
          left: math.max(0, x),
          top: math.max(0, y),
          width: w,
          height: h,
          child: Container(
            padding: EdgeInsets.only(top: 5.0, left: 5.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(37, 213, 253, 1.0),
                width: 3.0,
              ),
            ),
            child: Text(
              "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
              style: TextStyle(
                color: Color.fromRGBO(37, 213, 253, 1.0),
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList();
    }

    List<Widget> _renderStrings() {
      var lists = <Widget>[];

      return widget.results.map((re) {
        if (re["label"] == "step1" && re["confidence"] > 0.95) {
          status = 1;
        }
        if (status == 1 && re["label"] == "step2" && re["confidence"] > 0.95) {
          status = 2;
        }
        if (status == 2 && re["label"] == "step3" && re["confidence"] > 0.95) {
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

    List<Widget> _renderKeypoints() {
      var lists = <Widget>[];
      widget.results.forEach((re) {
        var list = re["keypoints"].values.map<Widget>((k) {
          var _x = k["x"];
          var _y = k["y"];
          var scaleW, scaleH, x, y;

          if (widget.screenH / widget.screenW >
              widget.previewH / widget.previewW) {
            scaleW = widget.screenH / widget.previewH * widget.previewW;
            scaleH = widget.screenH;
            var difW = (scaleW - widget.screenW) / scaleW;
            x = (_x - difW / 2) * scaleW;
            y = _y * scaleH;
          } else {
            scaleH = widget.screenW / widget.previewW * widget.previewH;
            scaleW = widget.screenW;
            var difH = (scaleH - widget.screenH) / scaleH;
            x = _x * scaleW;
            y = (_y - difH / 2) * scaleH;
          }
          return Positioned(
            left: x - 6,
            top: y - 6,
            width: 100,
            height: 12,
            child: Container(
              child: Text(
                "● ${k["part"]}",
                style: TextStyle(
                  color: Color.fromRGBO(37, 213, 253, 1.0),
                  fontSize: 12.0,
                ),
              ),
            ),
          );
        }).toList();

        _getPrediction(_inputArr.cast<double>().toList());
        _inputArr.clear();

        lists..addAll(list);
      });

      return lists;
    }

    return Stack(children: <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(32.0, 0, 32.0, 16.0),
            child: Text(
              _label.toString(),
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 25.0),
            child: LinearPercentIndicator(
              animation: true,
              lineHeight: 20.0,
              animationDuration: 500,
              animateFromLastPercent: true,
              percent: _counter,
              center: Text("${(_counter * 100).toStringAsFixed(1)} %"),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.green,
            ),
          ),
        ],
      ),
      Stack(
        children: _renderStrings(),
      ),
    ]);
  }

  Future<void> _getPrediction(List<double> steps) async {
    try {
      final double result = await BndBox.platform.invokeMethod('predictData', {
        "model": widget.model,
        "arg": steps,
      }); // passing arguments
      if (result <= 1) {
        _percent = 0;
        _percent = result;
      }
      _label =
          result < 0.5 ? "Wrong step" : (result * 100).toStringAsFixed(0) + "%";
      updateCounter(_percent);

      print("Final Label: " + result.toString());
    } on PlatformException catch (e) {}
  }

  void updateCounter(percent) {
    if (percent > 0.5) {
      (_counter += percent / 100) >= 1
          ? _counter = 1.0
          : _counter += percent / 100;
    }
    print("Counter: " + _counter.toString());
  }
}
