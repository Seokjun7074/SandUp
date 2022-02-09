// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/list.dart';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return MaterialApp(
      title: 'Sand UP',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffead7),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        // color: Color(0xFFffead7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Text(
                'Sand Up',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 70,
                    color: Colors.amber[600]),
              ),
            ),
            SvgPicture.asset(
              'assets/images/cover_sand1.svg',
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
              height: 60,
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.amber[600],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                // ButtonStyle(
                //   backgroundColor:
                //       MaterialStateProperty.all<Color>(Colors.amber),
                // ),

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ObjectList()),
                  );
                },
                child: Text(
                  'START',
                  style: TextStyle(
                      // backgroundColor: Colors.amber[300],
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.amber[100]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
