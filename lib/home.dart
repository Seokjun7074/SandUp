import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'widgets/list.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
            Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 70, 0, 0),
                  height: 60,
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.amber[600],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () {
                      Navigator.pushNamed(context, "/objectlist");
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
                Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  height: 60,
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.amber[600],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () {
                      Navigator.pushNamed(context, "/loginsignup");
                    },
                    child: Text(
                      'LOGIN',
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
          ],
        ),
      ),
    );
  }
}
