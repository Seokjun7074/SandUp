import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtomDrawer extends StatefulWidget {
  const ButtomDrawer({Key? key, required this.block, required this.count})
      : super(key: key);
  final List block;
  final int count;
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
          Positioned(
            bottom: 0,
            child: Container(
              height: height / 3.5,
              width: width,
              // color: Colors.white,
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
                    Text(
                      '미리 준비해주세요',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                      child: Divider(
                        color: Colors.grey[600],
                        thickness: 1.5,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < count; i++)
                          Padding(
                            padding: count < 6
                                ? const EdgeInsets.fromLTRB(5.0, 0, 10, 0)
                                : const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Container(
                              width: count < 6 ? width / 5.5 : width / 7,
                              height: count < 6 ? width / 5.5 : width / 7,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.amber, width: 2),
                                color: Colors.amber[50],
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 1.0,
                                    offset: Offset(
                                        0, 2), // changes position of shadow
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
                          ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        for (int i = 0; i < count; i++)
                          Padding(
                            padding: count < 6
                                ? const EdgeInsets.fromLTRB(5.0, 0, 10, 0)
                                : const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Container(
                              width: count < 6 ? width / 5.5 : width / 7,
                              child: Center(
                                child: Text(
                                  '${block[i][1]}',
                                  style: TextStyle(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600],
                                  ),
                                ),
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
        ],
      ),
    );
  }
}
