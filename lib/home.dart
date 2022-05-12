import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.amber[50],
      body: Container(
        width: width,
        child: Stack(
          children: [
            Positioned(
              top: height / 6,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 6,
                    child: Text(
                      'Sand up',
                      style: TextStyle(
                          letterSpacing: 3,
                          fontWeight: FontWeight.bold,
                          fontSize: 85.sp,
                          color: Colors.amber[600]),
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/images/cover_sand1.svg',
                    width: height / 3,
                  ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: height / 10,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
                    height: 80.h,
                    width: width / 3 * 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.amber[600],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))),
                      onPressed: () {
                        // Navigator.pushNamed(context, "/objectlist");
                        Navigator.pushNamed(context, "/testlist");
                        print(width);
                      },
                      child: Text(
                        'START',
                        style: TextStyle(
                            letterSpacing: 8,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.sp,
                            color: Colors.amber[100]),
                      ),
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  //   height: 60.h,
                  //   // width: 250.w,
                  //   width: width / 3 * 1.8,
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //         primary: Colors.amber[600],
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(30))),
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, "/loginsignup");
                  //     },
                  //     child: Text(
                  //       'LOGIN',
                  //       style: TextStyle(
                  //           // backgroundColor: Colors.amber[300],
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 30.sp,
                  //           color: Colors.amber[100]),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
