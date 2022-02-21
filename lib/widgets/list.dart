import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'listcontent.dart';
import 'objects.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<CameraDescription>? cameras;

class ObjectList extends StatefulWidget {
  const ObjectList({Key? key}) : super(key: key);

  @override
  State<ObjectList> createState() => _ObjectListState();
}

class _ObjectListState extends State<ObjectList> {
  final _authentication = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      User? loggedUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser.email);
        print(_authentication.currentUser);
        print("로그인되어있음");
      } else {
        print("로그인 안되어있음");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color(0xFFFFFFFF),
        iconTheme: IconThemeData(color: Colors.grey[800]),
        actions: [
          IconButton(
              onPressed: () {
                _authentication.signOut();
                // Navigator.pop(context);
                Navigator.pushNamed(context, "/loginsignup");
              },
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.grey[800],
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  "Special Level",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: GestureDetector(
                onTap: () {
                  print('스페샬~~');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 1),
                    ],
                  ),
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          height: 150,
                          color: Colors.purple[300],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 7, 5, 0),
                        child: Text(
                          "스페샬~~",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text(
                  "Level",
                  style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: SizedBox(
                height: 380,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  children: [
                    GestureDetector(
                      onTap: () {
                        print("탭탭탭!!!!");
                        Navigator.pushNamed(context, "/objects");
                      },
                      child: ListContent(
                        level: "2",
                        image: Image.asset("assets/capture/test_img.png"),
                        starNumber: 2,
                      ),
                    ),
                    ListContent(
                      level: "3",
                      image: Image.asset("assets/capture/test_img.png"),
                      starNumber: 3,
                    ),
                    ListContent(
                      level: "4",
                      image: Image.asset("assets/capture/test_img.png"),
                      starNumber: 4,
                    ),
                    ListContent(
                      level: "5",
                      image: Image.asset("assets/capture/test_img.png"),
                      starNumber: 5,
                    ),
                    ListContent(
                      level: "5",
                      image: Image.asset("assets/capture/test_img.png"),
                      starNumber: 5,
                    ),
                    ListContent(
                      level: "3",
                      image: Image.asset("assets/capture/test_img.png"),
                      starNumber: 3,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
