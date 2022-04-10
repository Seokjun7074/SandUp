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
      height: height * 1 / 3,
      decoration: BoxDecoration(
        // color: Colors.grey[200],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Stack(
        children: [
          // Positioned(
          //   right: 0,
          //   left: 0,
          //   child: Container(
          //     width: width / 2,
          //     height: height / 5,
          //     child: Image.asset('assets/cube/Pyramid.gif'),
          //   ),
          // ),
          Positioned(
            bottom: 0,
            child: Container(
              height: height / 3,
              width: width,
              // color: Colors.white,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '미리 준비해주세요',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 20),
                      child: Divider(
                        color: Colors.grey[700],
                        thickness: 1.5,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 100.h,
                          width: 100.w,
                          // color: Colors.blueAccent,
                          decoration: BoxDecoration(
                            color: Colors.grey[500],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 7,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image(
                            image: AssetImage('assets/images/piece_1.png'),
                          ),
                        ),
                        Container(
                          height: 100.h,
                          width: 100.w,
                          // color: Colors.blueAccent,
                          decoration: BoxDecoration(
                            color: Colors.grey[500],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 7,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image(
                            image: AssetImage('assets/images/piece_2.png'),
                          ),
                        ),
                        Container(
                          height: 100.h,
                          width: 100.w,
                          // color: Colors.blueAccent,
                          decoration: BoxDecoration(
                            color: Colors.grey[500],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 7,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image(
                            image: AssetImage('assets/images/piece_3.png'),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Center(
                              child: Text(
                                '2',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                            width: 100.w,
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                '2',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                            width: 100.w,
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                '2',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                            width: 100.w,
                          ),
                        ],
                      ),
                    ),
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
