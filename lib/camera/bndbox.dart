import 'dart:io';
import 'dart:math';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jolzak/widgets/buttom_drawer.dart';
import 'dart:math' as math;
import 'models.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:jolzak/camera/arcore.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:progress_stepper/progress_stepper.dart';
import 'package:lottie/lottie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../widgets/objects.dart';

class BndBox extends StatefulWidget {
  static const platform = MethodChannel('ondeviceML');

  final List<dynamic> results;
  final String level;
  final int count;
  final List block;
  final List copy_block;

  BndBox(
    this.results,
    this.level,
    this.count,
    this.block,
    this.copy_block,
  );

  @override
  _BndBoxState createState() => _BndBoxState();
}

class _BndBoxState extends State<BndBox> {
  AudioCache audioCache = AudioCache();
  bool _visible = false;
  bool _repeat = true;

  int eff_timer = 0;
  int status = 100;

  int total_step = 3;
  bool completed = true;
  // final List comment_candidates = ["힌트에서 블럭 모양을 확인해보세요!","가운데 버튼을 누르면 모래성이 나타나요!",
  //                       "뒤집어진 블럭도 있으니 잘 봐야해요.","모양이 잘 안 나올 땐 따라해봐요. 엄마!",];
  // var bottom_comment_temp = "";
  // var bottom_comment = "";

  @override
  void initState() {
    super.initState();
  }

  void resetCounter() {
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void complete() {
    setState(() {
      completed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    List block = widget.block;
    List copy_block = widget.copy_block;
    String level = widget.level;
    bool selected = false;

    if (widget.level == "2" || widget.level == "3") total_step = 5;

    List<Widget> _renderStrings() {
      var lists = <Widget>[];

      //랜덤 소리 재생을 위한 랜덤함수
      final _random = new Random();

      return widget.results.map((re) {
        //레벨1 반응형
        if (widget.level == "1") {
          if (status == 1 && re["label"] == "step1" && re["confidence"] > 0.8) {
            List step1_1 = ['audio/audio_1.mp3', 'audio/audio_0.mp3'];
            audioCache.play(step1_1[_random.nextInt(step1_1.length)]);
            // audioCache.play('audio/sound.mp3');
            status = 2;
            eff_timer = 1;
            Future.delayed(Duration(seconds: 4)).then((value) => eff_timer = 0);
          }
          if (status == 2 && re["label"] == "step2" && re["confidence"] > 0.8) {
            List step1_2 = [
              'audio/audio_2.mp3',
              'audio/audio_3.mp3',
              'audio/audio_5.mp3'
            ];
            audioCache.play(step1_2[_random.nextInt(step1_2.length)]);
            status = 3;
            eff_timer = 1;
            Future.delayed(Duration(seconds: 4)).then((value) => eff_timer = 0);
          }
          if (status == 3 &&
              re["label"] == "step3" &&
              re["confidence"] > 0.63) {
            status = 4;
            audioCache.play('audio/audio_10.mp3');

            Future.delayed(Duration(seconds: 1)).then((value) => status = 100);
            complete();
            Future.delayed(Duration(seconds: 4))
                .then((value) => _repeat = false);
            Future.delayed(Duration(seconds: 4))
                .then((value) => _visible = true);
          }
        }
        //레벨2 반응형
        if (widget.level == "2" || widget.level == "3") {
          if (status == 1 && re["label"] == "step1" && re["confidence"] > 0.8) {
            List step2_1 = ['audio/audio_0.mp3', 'audio/audio_1.mp3'];
            audioCache.play(step2_1[_random.nextInt(step2_1.length)]);
            status = 2;
            eff_timer = 1;
            Future.delayed(Duration(seconds: 4)).then((value) => eff_timer = 0);
          }
          if (status == 2 && re["label"] == "step2" && re["confidence"] > 0.8) {
            audioCache.play('audio/audio_5.mp3');
            status = 3;
            eff_timer = 1;
            Future.delayed(Duration(seconds: 4)).then((value) => eff_timer = 0);
          }
          if (status == 3 &&
              re["label"] == "step3" &&
              re["confidence"] > 0.55) {
            List step2_3 = ['audio/audio_2.mp3', 'audio/audio_3.mp3'];
            audioCache.play(step2_3[_random.nextInt(step2_3.length)]);
            status = 4;
            eff_timer = 1;
            Future.delayed(Duration(seconds: 4)).then((value) => eff_timer = 0);
          }
          if (status == 4 && re["label"] == "step4" && re["confidence"] > 0.4) {
            List step2_4 = [
              'audio/audio_3.mp3',
              'audio/audio_4.mp3',
              'audio/audio_5.mp3',
              'audio/audio_6.mp3'
            ];
            audioCache.play(step2_4[_random.nextInt(step2_4.length)]);
            status = 5;
            eff_timer = 1;
            Future.delayed(Duration(seconds: 4)).then((value) => eff_timer = 0);
          }
          if (status == 5 && re["label"] == "step5" && re["confidence"] > 0.5) {
            status = 6;
            List step2_5 = [
              'audio/audio_9.mp3',
              'audio/audio_10.mp3',
              'audio/audio_11.mp3'
            ];
            audioCache.play(step2_5[_random.nextInt(step2_5.length)]);
            Future.delayed(Duration(seconds: 1)).then((value) => status = 100);
            complete();

            Future.delayed(Duration(seconds: 4))
                .then((value) => _repeat = false);
            Future.delayed(Duration(seconds: 4))
                .then((value) => _visible = true);
          }
        }

        return Positioned(
          left: 30,
          top: 30,
          child: Text(
            "${re["label"]} ${(re["confidence"] * 100).toStringAsFixed(0)}% ${status}",
            style: TextStyle(
              color: Color.fromRGBO(37, 213, 253, 1.0).withOpacity(1.0),
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList();
    }

    // level 1 노가다

    if (level == '1') {
      if (status == 2) {
        setState(() {
          copy_block[0][1] = 0;
        });
      } else if (status == 3) {
        setState(() {
          copy_block[1][1] = 0;
        });
      } else if (status == 4) {
        setState(() {
          copy_block = [...block];
        });
      }
    }
    // level 2 노가다
    else if (level == '2') {
      if (status == 2) {
        setState(() {
          copy_block[0][1] = 2;
        });
      } else if (status == 3) {
        setState(() {
          copy_block[1][1] = 0;
        });
      } else if (status == 4) {
        setState(() {
          copy_block[2][1] = 0;
        });
      } else if (status == 5) {
        setState(() {
          copy_block[0][1] = 1;
          copy_block[3][1] = 1;
        });
      } else if (status == 6) {
        setState(() {
          copy_block = [...block];
        });
      }
    }
    // level 3 노가다
    else if (level == '3') {
      if (status == 2) {
        setState(() {
          copy_block[0][1] = 2;
        });
      } else if (status == 3) {
        setState(() {
          copy_block[1][1] = 2;
          copy_block[2][1] = 0;
          copy_block[3][1] = 0;
        });
      } else if (status == 4) {
        setState(() {
          copy_block[5][1] = 0;
        });
      } else if (status == 5) {
        setState(() {
          copy_block[0][1] = 1;
          copy_block[1][1] = 1;
          copy_block[4][1] = 1;
        });
      } else if (status == 6) {
        setState(() {
          copy_block = [...block];
        });
      }
    }

    return Stack(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(25.0, 40.0, 25.0, 25.0),
                child: ProgressStepper(
                  width: 330,
                  height: 20,
                  stepCount: total_step,
                  color: Colors.white,
                  progressColor: Colors.amber,
                  currentStep: status - 1,
                )),
            Container(
              height: 50,
            ),
            if (eff_timer == 1)
              Container(
                child: Lottie.asset('assets/effects/fireworks.json'),
              ),
          ],
        ),

        Visibility(
          visible: false,
          child: Stack(
            children: _renderStrings(),
          ),
        ),

        //뒷배경
        if (status == 100)
          (Container(
            color: Colors.black.withOpacity(0.8),
          )),

        if (status == 100)
          //라이팅 효과
          Lottie.asset('assets/effects/complete.json',
              animate: true, repeat: _repeat),

        //팝업페이지..
        Positioned(
          right: 30.w,
          left: 30.w,
          bottom: height / 6.3,
          child: Center(
            child: AnimatedOpacity(
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
                width: 310.w,
                height: 320.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('정말 멋진 모래성이네요!',
                          style: TextStyle(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700])),
                    ),

                    SizedBox(
                      height: 200.h,
                      child: Lottie.asset('assets/effects/castle.json',
                          repeat: true),
                    ),
                    // Image.asset('assets/images/level1.png',
                    //   height: 100,
                    //   width: 1500,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () =>
                              {status = 1, _visible = false, completed = true},
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey[600]),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Text(
                              "다시 해볼까?",
                              style: TextStyle(
                                letterSpacing: 1,
                                fontSize: 18.sp,
                                color: Colors.grey[100],
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, "/testlist"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey[600]),
                          child: Text(
                            "레벨선택하기로!",
                            style: TextStyle(
                              letterSpacing: 1,
                              fontSize: 18.sp,
                              color: Colors.grey[100],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: completed,
          child: Positioned(
            bottom: 20.h,
            child: Container(
              color: Colors.white.withOpacity(0.0),
              // color: Colors.transparent,
              height: height / 6,
              width: width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) {
                            return ButtomDrawer(
                              block: widget.block,
                              count: widget.count,
                              level: widget.level,
                              status: status,
                              copy_block: copy_block,
                            );
                          }),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.0),
                              spreadRadius: 1,
                              blurRadius: 1.0,
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: width / 2,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Lottie.asset(
                              'assets/step_img/castle${widget.level}_step${status}.json',
                              repeat: true,
                              animate: true),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: completed,
          child: Positioned(
            right: 50.w,
            bottom: 30.h,
            child: Container(
              width: width / 2.5,
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(25.0),
                          topRight: const Radius.circular(25.0),
                        ),
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset('assets/effects/comming_soon.json'),
                            Text(
                              'IOS에서 체험해 볼까요?',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.amber[100],
                              ),
                            )
                          ]),
                    ),
                  ),
                  child: Icon(Icons.view_in_ar),
                  backgroundColor: Color(0xff71A5D7).withBlue(1000),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
