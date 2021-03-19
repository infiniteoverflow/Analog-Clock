import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key,}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2d2f41),
      body: Center(
        child: ClockView(),
      ),
    );
  }
}

class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {

  @override
  void initState() {
    // TODO: implement initState
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {

      });
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Transform.rotate(
        angle: -pi/2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}


class ClockPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    DateTime dateTime = DateTime.now();

    var centerX = size.width/2;
    var centerY = size.height/2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX-60, centerY-60);

    var fillBrush = Paint()
    ..color = Colors.black;

    var outlineBrush = Paint()
    ..color = Colors.white
    ..strokeWidth = 14
    ..style = PaintingStyle.stroke;

    var fillCenterBrush = Paint()
    ..color = Colors.white;

    var secondHandBrush = Paint()
    ..strokeWidth = 7
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..shader = RadialGradient(colors: [Colors.amber,Colors.yellow])
        .createShader(Rect.fromCircle(center: center, radius: radius));

    var hourHandBrush = Paint()
      ..strokeWidth = 15
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = RadialGradient(colors: [Colors.red,Colors.white])
          .createShader(Rect.fromCircle(center: center, radius: radius));

    var minuteHandBrush = Paint()
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = RadialGradient(colors: [Colors.blue,Colors.white])
          .createShader(Rect.fromCircle(center: center, radius: radius));

    var timeSlotBrush = Paint()
    ..strokeWidth = 7
    ..color = Colors.white;

    canvas.drawCircle(center, radius, fillBrush);
    canvas.drawCircle(center, radius, outlineBrush);

    var secondHandX = centerX + 120*cos(dateTime.second*6*pi/180);
    var secondHandY = centerY + 120*sin(dateTime.second*6*pi/180);

    canvas.drawLine(center, Offset(secondHandX,secondHandY), secondHandBrush);

    for(int i=1;i<=60;i++) {
      var secX = centerX + 120*cos(i*6*pi/180);
      var secY = centerY + 120*sin(i*6*pi/180);
      canvas.drawLine(Offset(secX + 60*cos(i*6*pi/180),secY + 60*sin(i*6*pi/180)), Offset(secX + 80*cos(i*6*pi/180),secY + 80*sin(i*6*pi/180)), timeSlotBrush);
    }

    var hourHandX = centerX + 90*cos((dateTime.hour*30 + dateTime.minute * 0.5)*pi/180);
    var hourHandY = centerY + 90*sin((dateTime.hour*30 + dateTime.minute * 0.5)*pi/180);
    canvas.drawLine(center, Offset(hourHandX,hourHandY), hourHandBrush);

    var minuteHandX = centerX + 120*cos(dateTime.minute*6*pi/180);
    var minuteHandY = centerY + 120*sin(dateTime.minute*6*pi/180);
    canvas.drawLine(center, Offset(minuteHandX,minuteHandY), minuteHandBrush);
    
    canvas.drawCircle(center, 14, fillCenterBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}