
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:maskekontrol_gercekzamanli/main.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  CameraImage imgCamera;
  CameraController cameraController;
  bool isWorking = false;
  String resault = "";

  initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);

    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController.startImageStream((imageFromStream) => {
        if(!isWorking){
            isWorking = true,
            imgCamera = imageFromStream,
            runModelOnFrame(),
            }
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCamera();
    loadModel();
  }

  runModelOnFrame() async {
      if(imgCamera != null){
        var recognitions = await Tflite.runModelOnFrame(
            bytesList: imgCamera.planes.map((plane) {
                return plane.bytes;
            }).toList(),
        imageHeight: imgCamera.height,
          imageWidth: imgCamera.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 1,
          threshold: 0.1,
          asynch: true,
        );
        resault  = "";
        recognitions.forEach((response) {
          resault += response["label"] + "\n";


        });
        setState(() {
          resault;
        });

        isWorking = false;
      }
  }

  loadModel()async{
    await Tflite.loadModel(model: "assets/model.tflite",labels: "assets/labels.txt");
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Padding(
              padding: EdgeInsets.only(top: 40),
              child: Center(
                child: Text(
                    resault,style: TextStyle(backgroundColor: Colors.black54,fontSize: 30,color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Positioned(
                top: 0,
                left: 0,
                width: size.width,
                height: size.height - 100,
                child: Container(
                  height: size.height-100,
                  child: (!cameraController.value.isInitialized)
                      ? Container()
                      : AspectRatio(
                    aspectRatio: cameraController.value.aspectRatio,
                    child: CameraPreview(cameraController),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
