import 'package:flutter/material.dart';
import 'objects.dart';

class ObjectList extends StatelessWidget {
  const ObjectList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFffead7),
      appBar: AppBar(
        
        elevation: 0,
        centerTitle: true,
        backgroundColor: const Color(0xFFffead7),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //레벨 선택 박스
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, "/objects");
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150, //나중에 변경할듯
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.amber[300]),
                    child: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Level 1',
                        textAlign: TextAlign.start,
                        style:TextStyle(
                          fontSize:30, fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
                
              ),
              
              
            ],
          ),
        ),
      ),
    );
  }
}
