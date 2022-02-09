import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffead7),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFFffead7),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/images/cover_sand1.svg',
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                child: Theme(
                  data: ThemeData(
                      primaryColor: Colors.amber,
                      inputDecorationTheme: const InputDecorationTheme(
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 15.0))),
                  child: Container(
                    child: Column(
                      children: const [
                        TextField(
                          decoration: InputDecoration(labelText: "E-mail"),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: "Password"),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Row(
                children: [
                  Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.amber[600],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30))
                      ),
                      onPressed: () {},
                      child: Text("Log In",style: TextStyle(
                        color: Colors.amber[100],
                        fontSize: 16,
                        ),
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
