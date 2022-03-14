import 'package:flutter/material.dart';

class ListContent extends StatelessWidget {
  ListContent(
      {Key? key,
      required this.level,
      required this.image,
      required this.starNumber})
      : super(key: key);

  String level = "0";
  Widget image = Image.asset("assets/capture/test_img.png");
  int starNumber = 1;

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
              padding: const EdgeInsets.fromLTRB(7, 12, 5, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Level " + level,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  StarDisplay(value: starNumber),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
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
          size: 18,
          // color: Color(0xFF4ADEA3),
          color: Colors.indigo,
        );
      }),
    );
  }
}
