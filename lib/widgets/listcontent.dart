import 'package:flutter/material.dart';

class ListContent extends StatelessWidget {
  ListContent({Key? key, required this.level, required this.image})
      : super(key: key);

  // ListContent({required this.level, required this.image});
  String level = "0";
  Widget image = Image.asset("assets/capture/test_img.png");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: 170,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 3,
                spreadRadius: 1),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset("assets/capture/test_img.png"),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 8, 5, 5),
              child: Row(
                children: [
                  Text(
                    "Level" + level,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Icon(Icons.star),
                  // RatingBar.builder(
                  //   itemBuilder: (context, _) => Icon(
                  //     Icons.star,
                  //     color: Colors.red,
                  //   ),
                  //   onRatingUpdate: (rating) {
                  //     print(rating);
                  //   },
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
