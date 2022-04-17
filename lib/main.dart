// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:jolzak/camera/camera.dart';
//Routes list
import 'package:jolzak/home.dart';
import 'package:jolzak/login.dart';
import 'package:jolzak/signup.dart';
import 'package:jolzak/widgets/list.dart';
import 'package:jolzak/widgets/objects.dart';
// import 'package:jolzak/widgets/objects_test.dart';
import 'package:jolzak/camera/arcore.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jolzak/widgets/scaled_list.dart';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
// double width = 180.w // 숫자 뒤에 *.w를 쓰면, designSize 기준 가로 길이가 된다.
// double height = 300.h // 숫자 뒤에 *.h를 쓰면, designSize 기준 세로 길이가 된다.
// double textSize = 18.sp // 숫자 뒤에 *.sp를 쓰면, designSize 기준 폰트 크기가 설정된다.
// 기타 .sw .sh .r
      designSize: Size(350, 690),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sand UP',
        theme: ThemeData(
          fontFamily: 'yanolja',
        ),
        initialRoute: "/",
        //라우터는 여기에
        routes: {
          "/": (context) => Home(),
          "/objectlist": (context) => ObjectList(),
          // "/objects": (context) => Objects(cameras!),
          "/objects": (context) => Objects(cameras!),
          "/login": (context) => LogIn(),
          "/loginsignup": (context) => LoginSignupScreen(),
          "/arcore": (context) => ObjectGesturesWidget(),
          "/testlist": (context) => TestList(),
        },
      ),
    );
  }
}
