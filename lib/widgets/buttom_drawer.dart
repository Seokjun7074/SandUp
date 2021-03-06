import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class ButtomDrawer extends StatefulWidget {
  const ButtomDrawer({
    Key? key,
    required this.block,
    required this.count,
    required this.level,
    required this.status,
    required this.copy_block,
  }) : super(key: key);
  final List block;
  final int count;
  final String level;
  final int status;
  final List copy_block;
  @override
  State<ButtomDrawer> createState() => _ButtomDrawerState();
}

class _ButtomDrawerState extends State<ButtomDrawer> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    List block = widget.block;
    int count = widget.count;
    String level = widget.level;
    int status = widget.status;
    List copy_block = widget.copy_block;

    return Container(
      height: height,
      decoration: BoxDecoration(
        // color: Colors.grey[800],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: count < 6 ? height / 3.2 : height / 2,
              width: width,
              decoration: BoxDecoration(
                color: Colors.amber[50],
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
                    Center(
                      child: Container(
                        alignment: Alignment.topCenter,
                        width: width,
                        height: 35.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.amber.withAlpha(100), Colors.amber],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                // '?????? ${level} ????????? ?????????',
                                '????????? ????????????!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 1,
                                ),
                              ),
                              // Icon(Icons.tag_faces_sharp),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    //   child: Divider(
                    //     color: Colors.grey[600],
                    //     thickness: 1.5,
                    //   ),
                    // ),
                    // Center(
                    //   child: Container(
                    //     height: 130,
                    //     child: Lottie.asset('assets/images/castle${level}.json'),
                    //   ),
                    // ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runSpacing: 10,
                        children: [
                          for (int i = 0; i < count; i++)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5.0, 0, 10, 0),
                              child: Column(
                                children: [
                                  Container(
                                    width: count == 4 ? width / 6 : width / 4.5,
                                    height:
                                        count == 4 ? width / 6 : width / 4.5,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.amber, width: 2),
                                      color: Colors.amber[50],
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 1.0,
                                          offset: Offset(0,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.asset(
                                      'assets/blocks/SANDUP_block_block${block[i][0]}.png',
                                      width: 100,
                                      height: 100,
                                    ),
                                  ),
                                  Text(
                                    '${copy_block[i][1]}???',
                                    // '${status}',
                                    style: TextStyle(
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
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
