// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffead7),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFFffead7),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/images/cover_sand1.svg',
              ),
              Padding(
                padding: EdgeInsets.all(40.0),
                child: Form(
                  child: Theme(
                    data: ThemeData(
                        primaryColor: Colors.amber,
                        inputDecorationTheme: InputDecorationTheme(
                            labelStyle: TextStyle(
                                color: Colors.black, fontSize: 15.0))),
                    child: Container(
                      child: Column(
                        children: [
                          // TextField(
                          //   autofocus: true,
                          //   controller: controller,
                          //   decoration: InputDecoration(labelText: "E-mail"),
                          //   keyboardType: TextInputType.emailAddress,
                          // ),
                          // TextField(
                          //   controller: controller2,
                          //   decoration: InputDecoration(labelText: "Password"),
                          //   keyboardType: TextInputType.text,
                          //   obscureText: true,
                          // ),
                          TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                hintText: 'Email',
                                hintStyle: TextStyle(
                                    fontSize: 14, color: Colors.grey[600]),
                                contentPadding: EdgeInsets.all(10)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.account_circle,
                                  color: Colors.grey,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    fontSize: 14, color: Colors.grey[600]),
                                contentPadding: EdgeInsets.all(10)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 130,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.amber[600],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onPressed: () {
                          // if (controller.text == "email" &&
                          //     controller2.text == "123456") {
                          //   Navigator.pushNamed(context, "/objectlist");
                          // } else if (controller.text == "" ||
                          //     controller2.text == "") {
                          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //     content: Text(
                          //       '입력을 해야지',
                          //       textAlign: TextAlign.center,
                          //       style: TextStyle(fontWeight: FontWeight.bold),
                          //     ),
                          //     duration: Duration(seconds: 2),
                          //     backgroundColor: Colors.amber[700],
                          //   ));
                          // } else if (controller.text != "email" ||
                          //     controller2.text != "123456") {
                          //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //     content: Text(
                          //       '이메일이나 비밀번호 틀림',
                          //       textAlign: TextAlign.center,
                          //       style: TextStyle(fontWeight: FontWeight.bold),
                          //     ),
                          //     duration: Duration(seconds: 1),
                          //     backgroundColor: Colors.amber[700],
                          //   ));
                          // }
                        },
                        child: Text(
                          "Log In",
                          style: TextStyle(
                            color: Colors.amber[100],
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 130,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.amber[600],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onPressed: () {},
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.amber[100],
                            fontSize: 22,
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
      ),
    );
  }
}
