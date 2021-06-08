import 'package:flutter/material.dart';

class InfoScreenPart2 extends StatelessWidget {
  const InfoScreenPart2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.white,
                      Color(0xFF3383CD),
                    ]
                ),
              ),
              child: Image(
                image: AssetImage('assets/images/infoScreen2.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

