import 'package:flutter/material.dart';
import 'package:maskekontrol_gercekzamanli/splashscreen.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;
Future <void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maske kontrol',

      home: MySplash(),
    );
  }
}

