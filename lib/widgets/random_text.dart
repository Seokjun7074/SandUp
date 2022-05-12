import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class RandomText extends StatefulWidget {
  const RandomText({Key? key}) : super(key: key);

  @override
  State<RandomText> createState() => _RandomTextState();
}

class _RandomTextState extends State<RandomText> {
  List guide_text = [
    '힌트를 눌러보세요! 모래성에 필요한 블럭을 볼 수 있답니다',
    '가운데 버튼을 눌러보세요! 🏰 멋진 모래성이 나타날 거예요 🏰',
    '🧱 블럭 몇 개 남았지?! 힌트를 눌러 확인해볼까요?',
    '같은 모양인데 뭔가 이상하다면🤔? 블럭을 뒤집어 쌓아보세요!',
    '블럭 모양이 이상해요😢 블럭을 뒤집어 쌓아보세요!',
    '모양이 잘 안 만들어져요😢 엄마를 불러주세요~! 야호~!',
  ];
  int random_idx = 0;

  void setRandom() {
    setState(() {
      random_idx = Random().nextInt(6);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // Timer(Duration(milliseconds: 1500), () => Random().nextInt(6));

    Timer.periodic(new Duration(seconds: 5), (timer) {
      setRandom();
    });

    return Container(
      width: width,
      height: 90,
      color: Colors.amberAccent,
      child: Text(
        '${guide_text[random_idx]}',
      ),
    );
  }
}
