import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'objects.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:scaled_list/scaled_list.dart';

List<CameraDescription>? cameras;

class TestList extends StatefulWidget {
  const TestList({Key? key}) : super(key: key);

  @override
  State<TestList> createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  final _authentication = FirebaseAuth.instance;

  void initState() {
    super.initState();
    // getCurrentUser();
  }

  refresh() {
    setState(() {});
    // deactivate();
  }
  // void getCurrentUser() {
  //   try {
  //     final user = _authentication.currentUser;
  //     User? loggedUser;
  //     if (user != null) {
  //       loggedUser = user;
  //       print(loggedUser.email);
  //       print(_authentication.currentUser);
  //       print("로그인되어있음");
  //     } else {
  //       print("로그인 안되어있음");
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool selected = false;

    return Scaffold(
      backgroundColor: Colors.amber[50],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber[50],
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
          child: Text(
            'Sand Up',
            style: TextStyle(
              fontSize: 35.sp,
              fontWeight: FontWeight.bold,
              color: Colors.amber[600],
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Stack(
          children: [
            Positioned(
              child: ScaledList(
                unSelectedCardHeightRatio: 0.35,
                selectedCardHeightRatio: 0.8,
                itemCount: categories.length,
                itemColor: (index) {
                  return kMixedColors[index % kMixedColors.length];
                },
                itemBuilder: (index, selectedIndex) {
                  final category = categories[index];
                  List copy_block = [...category.block];
                  // print('블록:" ${category.block}');
                  // print('카피블록:" ${copy_block}');
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "/objects",
                        arguments: ObjectsArguments(
                          index: index + 1,
                          count: category.count,
                          block: category.block,
                          copy_block: copy_block,
                        ),
                      ).then(
                        ((value) => value == null ? refresh() : null),
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      width: 100.w,
                      height: 100.h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text('${category.count}'),
                          Container(
                            height: selectedIndex == index ? 200 : 80,
                            child: Image.asset(category.image),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            category.name,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: selectedIndex == index ? 25 : 20,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          StarDisplay(value: index + 1),
                          SizedBox(
                            height: 10.h,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<Color> kMixedColors = [
    Color(0xff71A5D7),
    Color(0xff72CCD4),
    Color(0xffFBAB57),
    Color(0xffF8B993),
    Color(0xff962D17),
    Color(0xffc657fb),
    Color(0xfffb8457),
  ];

  final List<Category> categories = [
    Category(
        image: "assets/images/level1.png",
        name: "Level 1",
        count: '3',
        block: [
          [3, 1],
          [1, 1],
          [5, 1],
          // [블럭번호, 개수]
        ]),
    Category(
        image: "assets/images/level2.png",
        name: "Level 2",
        count: '4',
        block: [
          [4, 5],
          [7, 1],
          [1, 2],
          [6, 2],
        ]),
    Category(
        image: "assets/images/level3.png",
        name: "Level 3",
        count: '6',
        block: [
          [4, 4],
          [1, 3],
          [3, 1],
          [5, 1],
          [6, 2],
          [7, 2],
        ]),
  ];
}

class Category {
  final String image;
  final String name;
  final String count;
  final List block;

  Category({
    required this.image,
    required this.name,
    required this.count,
    required this.block,
  });
}

class StarDisplay extends StatelessWidget {
  final int value;
  const StarDisplay({Key? key, this.value = 0})
      : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
          size: 18.sp,
          // color: Color(0xFF4ADEA3),
          color: Colors.grey[800],
        );
      }),
    );
  }
}
