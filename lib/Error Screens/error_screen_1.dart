import 'package:covid_developersonline/screens/loading_screen.dart';
import 'package:flutter/material.dart';

class ErrorScreen1 extends StatelessWidget {
  const ErrorScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image(image: AssetImage('assets/images/error.png')),
                SizedBox(height: 20,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xFF11249F),
                      shadowColor: Colors.black
                  ),
                  child: Text(
                    "Try again !",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return LoadingScreen();
                    }));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
