import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';

//Routes list
import 'package:jolzak/home.dart';
import 'package:jolzak/login.dart';
import 'package:jolzak/signup.dart';
import 'package:jolzak/widgets/list.dart';
import 'package:jolzak/widgets/objects.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sand UP',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: "/",
      //라우터는 여기에
      routes: {
        "/": (context) => Home(),
        "/objectlist": (context) => ObjectList(),
        "/objects": (context) => Objects(),
        "/login": (context) => LogIn(),
        "/loginsignup": (context) => LoginSignupScreen(),
      },
    );
  }
}
