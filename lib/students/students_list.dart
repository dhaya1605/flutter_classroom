import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:eclass/screens/notes_own_classroom_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Students_list extends StatefulWidget {
  Students_list(this.classroomId);
  String classroomId;
  @override
  _Students_listState createState() => _Students_listState(classroomId);
}

class _Students_listState extends State<Students_list> {
  _Students_listState(this.classroomId);
  String classroomId;

  String n;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              child: CustomPaint(
                painter: Sky("$n"),
              ),
            ),
            StreamBuilder(
                stream: Firestore.instance.collection('classrooms').document(classroomId).collection('joined_students').snapshots(),
                builder: (context,snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    //listItem = snapshot.data.documents;
                    List<Widget> message_widgets = [];
                    final classes = snapshot.data.documents;
                    int len= snapshot.data.documents.length;
                    n = len<10? "0${len.toString()}" : "${len.toString()}";

                    for(var Class in classes){
                      String name = Class.data['student_name'];
                      String email = Class.data['student_email'];



                        final imageWidget = Student_detail(name,email);
                        message_widgets.add(imageWidget);





                    }
                    return Column(
                      children: message_widgets,
                    );
                  }
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}

class Student_detail extends StatelessWidget {
  Student_detail(this.name,this.email);
  String name;
  String email;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0,
                ),
              ]
          ),
          child: Center(
            child: ListTile(
              contentPadding: EdgeInsets.all(10.0),
              leading: CircleAvatar(
                radius: 50,
              ),
              title: Text("$name"),
              subtitle: Text("$email"),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
      ],
    );
  }
}

class Sky extends CustomPainter{
  Sky(this.num1);
  String num1;
  @override
  void paint(Canvas canvas,Size size){
    var paint = Paint();
    var circlePaint = Paint();
    var path = Path();
    var rect = Offset.zero & size;
    var center = Offset(size.width/2,size.height * 0.6);
    var tcenter = Offset(size.width*0.43,size.height/2);
    final style=ui.ParagraphStyle(textDirection: TextDirection.ltr);
    final textstyle = ui.TextStyle(color: Colors.white,fontSize:50);
    final paragraphB = ui.ParagraphBuilder(style)
        ..pushStyle(textstyle)
        ..addText(num1);
    final constraints = ui.ParagraphConstraints(width: 300.0);
    final paragraph = paragraphB.build();
    paragraph.layout(constraints);
    circlePaint.color = Colors.white;

    paint.color = Colors.orangeAccent;
    paint.style = PaintingStyle.fill;
    
    path.moveTo(0,size.height*0.35);
    path.quadraticBezierTo(size.width/2,size.height, size.width, size.height*0.35);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
    canvas.drawCircle(center, 75, circlePaint);
    canvas.drawCircle(center, 60, paint);
    canvas.drawParagraph(paragraph, tcenter);
  }
  @override
  bool shouldRepaint(CustomPainter old){
    return true;
  }
}