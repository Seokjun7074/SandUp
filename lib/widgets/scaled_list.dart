import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'listcontent.dart';
import 'objects.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:scaled_list/scaled_list.dart';

class TestList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaledList(
          itemCount: categories.length,
          itemColor: (index) {
            return kMixedColors[index % kMixedColors.length];
          },
          itemBuilder: (index, selectedIndex) {
            final category = categories[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: selectedIndex == index ? 100 : 80,
                  child: Image.asset(category.image),
                ),
                SizedBox(height: 15),
                Text(
                  category.name,
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: selectedIndex == index ? 25 : 20),
                )
              ],
            );
          },
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
    Category(image: "assets/images/piece_1.png", name: "Level 1"),
    Category(image: "assets/images/piece_2.png", name: "Level 2"),
    Category(image: "assets/images/piece_3.png", name: "Level 3"),
    Category(image: "assets/images/piece_4.png", name: "Level 4"),
  ];
}

class Category {
  final String image;
  final String name;

  Category({required this.image, required this.name});
}
