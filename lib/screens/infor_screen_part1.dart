import 'package:flutter/material.dart';

class InfoScreenPart1 extends StatelessWidget {
  const InfoScreenPart1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
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
                image: AssetImage('assets/images/infoscreen1.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
