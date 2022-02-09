import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';

//Routes list
import 'package:jolzak/home.dart';
import 'package:jolzak/widgets/list.dart';
import 'package:jolzak/widgets/objects.dart';
// import 'home.dart';
// import 'widgets/list.dart';
// import 'widgets/objects.dart';

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
      routes: {
        "/": (context) => Home(),
        "/objectlist": (context) => ObjectList(),
        "/objects":(context) => Objects(),
      },
    );
  }
}
