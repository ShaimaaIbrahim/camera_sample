import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;


Future<Null> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page' , myCameras: cameras,),
    );
  }
}

class MyHomePage extends StatefulWidget {

  List<CameraDescription> myCameras;

  MyHomePage({Key key, this.title , this.myCameras}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = new CameraController(widget.myCameras[0] , ResolutionPreset.medium);
    controller.initialize().then((_){
      if(!mounted){
        return;
      }
    });
  }
  @override
  void setState(fn) {
    super.setState(fn);

  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    if(!controller.value.isInitialized){
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body : Container(
        child: Text("no camera"),
        ),
      );
    }
    return Scaffold(
    body : AspectRatio(
    aspectRatio: controller.value.aspectRatio,
    child: new CameraPreview(controller),
    ),
    );

  }
}
