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
import 'package:rflutter_alert/rflutter_alert.dart';


int eff_timer = 0;
int status = 0;

class BndBox extends StatefulWidget {
  static const platform = MethodChannel('ondeviceML');

  final List<dynamic> results;

  BndBox(
    this.results,
  );

  @override
  _BndBoxState createState() => _BndBoxState();
}

class _BndBoxState extends State<BndBox> {

  AudioCache audioCache = AudioCache();
  bool _visible = false;
  bool _repeat = true;


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
        if ( status == 0 && re["label"] == "step1" && re["confidence"] > 0.1) {
          audioCache.play('audio/sound.mp3');
          status = 1;
          eff_timer = 1;
          Future.delayed(Duration(seconds: 4)).then((value) => eff_timer=0);

        }
        if (status == 1 && re["label"] == "step2" && re["confidence"] > 0.1) {
          audioCache.play('audio/sound.mp3');
          status = 2;
          eff_timer = 1;
          Future.delayed(Duration(seconds: 4)).then((value) => eff_timer=0);
        }
        if (status == 2 && re["label"] == "step3" && re["confidence"] > 0.1) {
          audioCache.play('audio/complete.mp3');
          Future.delayed(Duration(seconds: 1)).then((value) => status=3);
          Future.delayed(Duration(seconds: 4)).then((value) => _repeat = false);
          Future.delayed(Duration(seconds: 4)).then((value) => _visible = true);
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

      //뒷배경
        if (status == 3)(
            Container(
              color: Colors.black.withOpacity(0.8),
            )
        ),

        if (status==3)
          //라이팅 효과
          Lottie.asset('assets/effects/complete.json',
          animate: true,
          repeat: _repeat),


            //팝업페이지..
            Padding(padding: EdgeInsets.fromLTRB(41.0, 280.0, 25.0, 25.0),
              child:  AnimatedOpacity(
                // If the widget is visible, animate to 0.0 (invisible).
                // If the widget is hidden, animate to 1.0 (fully visible).
                opacity: _visible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                // The green box must be a child of the AnimatedOpacity widget.
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber[200],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    width: 310.0,
                    height: 300.0,
                    child: Padding( padding:EdgeInsets.all(0),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            Text('정말 멋진 모래성이네요!',
                            style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,)),

                            Lottie.asset('assets/effects/castle.json',
                            repeat: true),
                            // Image.asset('assets/images/level1.png',
                            //   height: 100,
                            //   width: 1500,
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                RaisedButton(onPressed: ()=>status = 0,
                                color: Colors.white,),
                                RaisedButton(onPressed: ()=>status = 0,
                                color: Colors.grey,),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                ),
              ),
            ),

    ],
    );
  }
}
