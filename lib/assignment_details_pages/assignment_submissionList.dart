import 'package:eclass/assignment_details_pages/afterSubmission_assignment.dart';
import 'package:eclass/assignment_details_pages/assignment_evaluation_page.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:cloud_firestore/cloud_firestore.dart';



class assignment_submissionList extends StatefulWidget {
  assignment_submissionList(this.classroomId,this.ATitle);
  String classroomId;
  String ATitle;
  @override
  _assignment_submissionListState createState() => _assignment_submissionListState(classroomId,ATitle);
}

class _assignment_submissionListState extends State<assignment_submissionList> {
  _assignment_submissionListState(this.classroomId,this.ATitle);
  String classroomId;
  String ATitle;
  String email;

  String n ='';

  numberOfSubmission()async{
    QuerySnapshot numbers = await Firestore.instance.collection('classrooms').document(classroomId).collection('assignments').document(ATitle).collection('submissions').getDocuments();
    int len= numbers.documents.length;
    setState(() {
      n = len<10? "0${len.toString()}" : "${len.toString()}";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    numberOfSubmission();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: CustomPaint(
                painter: Sky("$n"),
              ),
            ),
            StreamBuilder(
                stream: Firestore.instance.collection('classrooms').document(classroomId).collection('assignments').document(ATitle).collection('submissions').snapshots(),
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
//                    n = len<10? "0${len.toString()}" : "${len.toString()}";

                    for(var Class in classes){
                      String time = Class.data['time'];
                      String email = Class.data['email'];
                      String date = Class.data['date'];
                      bool evaluated = Class.data['evaluated'];



                      final imageWidget = Student_detail(time,email,date,classroomId,ATitle,evaluated);
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



class Sky extends CustomPainter{
  Sky(this.num1);
  String num1;
  @override
  void paint(Canvas canvas,Size size){
    var paint = Paint();
    var circlePaint = Paint();
    var path = Path();
    var rect = Offset.zero & size;
    var center = Offset(size.width/2,size.height * 0.4);
    var tcenter = Offset(size.width * 0.43,size.height * 0.27);
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

    path.moveTo(0,size.height * 0.6);
    path.quadraticBezierTo(size.width/2,size.height * 0.1, size.width, size.height *0.6);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
    canvas.drawCircle(center, 60, circlePaint);
    canvas.drawCircle(center, 50, paint);
    canvas.drawParagraph(paragraph, tcenter);
  }
  @override
  bool shouldRepaint(CustomPainter old){
    return true;
  }
}




class Student_detail extends StatelessWidget {
  Student_detail(this.time,this.email,this.date,this.classroomId,this.title,this.evaluated);
  String time;
  String email;
  String date;
  String classroomId;
  String title;
  bool evaluated;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>assignment_evaluation(title,classroomId,email)));
          },
          child: Container(
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
                title: Text("$email"),
                subtitle: Text("$date      $time"),
                trailing:evaluated? Icon(Icons.check,color: Colors.green,):Icon(Icons.clear,color: Colors.red,),
              ),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
      ],
    );
  }
}