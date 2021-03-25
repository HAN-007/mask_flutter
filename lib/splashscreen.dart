import 'package:flutter/material.dart';
import 'package:maskekontrol_gercekzamanli/home_page.dart';
import 'package:splashscreen/splashscreen.dart';
class MySplash extends StatefulWidget {
  @override
  _MySplashState createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      navigateAfterSeconds: HomePage(),
      title: Text(
        "Maske Kontrol",
        style: TextStyle(fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.black),
      ),
      image: Image.asset("assets/splash.png"),
      photoSize: 130,
      backgroundColor: Colors.white,
      loaderColor: Colors.black,
      loadingText: Text("nanlambda.com",style: TextStyle(color: Colors.black,fontSize: 16.0),),

    );
  }
}
