import 'package:eclass/assignment_details_pages/afterSubmission_assignment.dart';
import 'package:eclass/assignment_details_pages/afterSubmission_quiz.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eclass/styles.dart';
import 'package:eclass/assignment_details_pages/student_quiz_detail.dart';
import 'package:eclass/assignment_details_pages/student_assignment_detail.dart';


class assignmentsList extends StatefulWidget {
  assignmentsList(this.classroomId,this.email);
  String classroomId;
  String email;
  @override
  _assignmentsListState createState() => _assignmentsListState(classroomId,email);
}

class _assignmentsListState extends State<assignmentsList> {
  _assignmentsListState(this.classroomId,this.email);
  String classroomId;
  String email;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                    child: Icon(Icons.arrow_back)),
                Expanded(child: Center(child: Text("Assignments & Quiz",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,fontFamily: 'marienda',fontWeight: FontWeight.bold,
                      color: Colors.blue),))),
              ],
            ),
            Container(
              child: Column(
                children: <Widget>[
                  StreamBuilder(
                  stream: Firestore.instance.collection('classrooms').document(classroomId).collection('Assignments&Quiz').orderBy('created utc').snapshots(),
                  builder: (context,snapshot){
                    if(!snapshot.hasData){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else{
                      List<Widget> Assignments = [];
                      final assignments = snapshot.data.documents.reversed;
                      for(var assignment in assignments){
                        String type = assignment.data['type'];
                        String dueDate = assignment.data['dueDate'];
                        String cDate = assignment.data['created'];
                        String title = assignment.data['title'];
                        if(type == "Assignment"){
                          final assignment_widget = assignment_stful_widget(title,cDate,dueDate,classroomId,email);
                          Assignments.add(assignment_widget);
                        }
                        else{
                          final quiz_widget =quiz_stful_widget(title,cDate,dueDate,classroomId,email);
                          Assignments.add(quiz_widget);
                        }
                      }
                      return Column(
                        children: Assignments,
                      );
                    }
                  },
                ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *0.05,
                  ),],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Quiz_widget extends StatelessWidget {
  Quiz_widget(this.Title,this.cdate,this.dueDate,this.classroomid,this.email);
  String cdate;
  String dueDate;
  String Title;
  String classroomid;
  String email;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height *0.05,
        ),
        GestureDetector(
          onTap: ()async{
            await Firestore.instance.collection('classrooms').document(classroomid).collection('quiz').document(Title).collection('submissions').where('email',isEqualTo: email).getDocuments().then((event){
              if(event.documents.isEmpty){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> student_qyiz_details(classroomid,Title,email)));

                //print("not submitted");
              }
              else{
                Navigator.push(context, MaterialPageRoute(builder: (context)=> afterSubmission_quiz(classroomid,Title,email)));

                //print("submitted");
              }
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width *0.92,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: secondaryColor,
                  blurRadius: 1.0,
                  offset: Offset(0, 2),
                ),],
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.04,
                  backgroundImage:AssetImage('images/quiz.png'),
                ),
                Container(
                  child: Text("$Title",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                      fontFamily: 'marienda',
                    ),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Submitted Students"),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.04,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text('5',style: TextStyle(color: Colors.white),),
                      radius: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child:Column(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text("Posted on",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.023,
                            ),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text("$cdate",style: TextStyle(
                              color: Colors.white,
                            ),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                          ],
                        )
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child:Column(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text("Due date",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.023,
                            ),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text("$dueDate",style: TextStyle(
                              color: Colors.white,
                            ),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Assignment_widget extends StatelessWidget {
  Assignment_widget(this.Title,this.cdate,this.dueDate,this.classroomid,this.email);
  String cdate;
  String dueDate;
  String Title;
  String classroomid;
  String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height *0.05,
        ),
        GestureDetector(
          onTap: () async{
            await Firestore.instance.collection('classrooms').document(classroomid).collection('assignments').document(Title).collection('submissions').where('email',isEqualTo: email).getDocuments().then((event){
              if(event.documents.isEmpty){
               // print("not submitted");
                Navigator.push(context, MaterialPageRoute(builder: (context)=>student_assignment_detail(Title,classroomid,email)));
              }
              else{
               // print("submitted");
                Navigator.push(context, MaterialPageRoute(builder: (context)=>afterSubmission_assignment(Title,classroomid,email)));
              }
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width *0.92,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: secondaryColor,
                  blurRadius: 1.0,
                  offset: Offset(0, 2),
                ),],
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.04,
                  backgroundImage:AssetImage('images/assignment.png'),
                ),
                Container(
                  child: Text("$Title",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                      fontFamily: 'marienda',
                    ),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Submitted Students"),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.04,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Text('5',style: TextStyle(color: Colors.white),),
                      radius: MediaQuery.of(context).size.width * 0.03,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child:Column(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text("Posted on",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.023,
                            ),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text("$cdate",style: TextStyle(
                              color: Colors.white,
                            ),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                          ],
                        )
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child:Column(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text("Due Date",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.023,
                            ),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text("$dueDate",style: TextStyle(
                              color: Colors.white,
                            ),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



class quiz_stful_widget extends StatefulWidget {
  quiz_stful_widget(this.Title,this.cdate,this.dueDate,this.classroomid,this.email);
  String cdate;
  String dueDate;
  String Title;
  String classroomid;
  String email;
  @override
  _quiz_stful_widgetState createState() => _quiz_stful_widgetState(Title,cdate,dueDate,classroomid,email);
}

class _quiz_stful_widgetState extends State<quiz_stful_widget> {
  _quiz_stful_widgetState(this.Title,this.cdate,this.dueDate,this.classroomid,this.email);
  String cdate;
  String dueDate;
  String Title;
  String classroomid;
  String SNumbers = '0';
  String email;
  bool submitted = false;


  submission()async{
    await Firestore.instance.collection('classrooms').document(classroomid).collection('quiz').document(Title).collection('submissions').where('email',isEqualTo: email).getDocuments().then((event){
      if(event.documents.isEmpty){
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> student_qyiz_details(classroomid,Title,email)));

        //print("not submitted");

        setState(() {
          submitted = false;
        });
      }
      else{
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> afterSubmission_quiz(classroomid,Title,email)));

        //print("submitted");
        setState(() {
          submitted = true;
        });
      }
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    submission();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height *0.05,
        ),
        GestureDetector(
          onTap: ()async{
            await Firestore.instance.collection('classrooms').document(classroomid).collection('quiz').document(Title).collection('submissions').where('email',isEqualTo: email).getDocuments().then((event){
              if(event.documents.isEmpty){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> student_qyiz_details(classroomid,Title,email)));

                //print("not submitted");
              }
              else{
                Navigator.push(context, MaterialPageRoute(builder: (context)=> afterSubmission_quiz(classroomid,Title,email)));

                //print("submitted");
              }
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width *0.92,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: secondaryColor,
                  blurRadius: 1.0,
                  offset: Offset(0, 2),
                ),],
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.04,
                  backgroundImage:AssetImage('images/quiz.png'),
                ),
                Container(
                  child: Text("$Title",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                      fontFamily: 'marienda',
                    ),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    submitted?Text("Submitted",style: TextStyle(color: Colors.green),):Text("Not Submitted",style: TextStyle(color: Colors.redAccent),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child:Column(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text("Posted on",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.023,
                            ),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text("$cdate",style: TextStyle(
                              color: Colors.white,
                            ),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                          ],
                        )
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child:Column(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text("Due date",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.023,
                            ),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text("$dueDate",style: TextStyle(
                              color: Colors.white,
                            ),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



class assignment_stful_widget extends StatefulWidget {
  assignment_stful_widget(this.Title,this.cdate,this.dueDate,this.classroomid,this.email);
  String cdate;
  String dueDate;
  String Title;
  String classroomid;
  String email;
  @override
  _assignment_stful_widgetState createState() => _assignment_stful_widgetState(Title,cdate,dueDate,classroomid,email);
}

class _assignment_stful_widgetState extends State<assignment_stful_widget> {
  _assignment_stful_widgetState(this.Title,this.cdate,this.dueDate,this.classroomid,this.email);
  String cdate;
  String dueDate;
  String Title;
  String classroomid;
  String SNumbers = '0';
  String email;
  bool submitted = false;


  submission()async{
    await Firestore.instance.collection('classrooms').document(classroomid).collection('assignments').document(Title).collection('submissions').where('email',isEqualTo: email).getDocuments().then((event){
      if(event.documents.isEmpty){
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> student_qyiz_details(classroomid,Title,email)));

        //print("not submitted");

        setState(() {
          submitted = false;
        });
      }
      else{
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> afterSubmission_quiz(classroomid,Title,email)));

        //print("submitted");
        setState(() {
          submitted = true;
        });
      }
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    submission();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height *0.05,
        ),
        GestureDetector(
          onTap: () async{
            await Firestore.instance.collection('classrooms').document(classroomid).collection('assignments').document(Title).collection('submissions').where('email',isEqualTo: email).getDocuments().then((event){
              if(event.documents.isEmpty){
                // print("not submitted");
                Navigator.push(context, MaterialPageRoute(builder: (context)=>student_assignment_detail(Title,classroomid,email)));
              }
              else{
                // print("submitted");
                Navigator.push(context, MaterialPageRoute(builder: (context)=>afterSubmission_assignment(Title,classroomid,email)));
              }
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width *0.92,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: secondaryColor,
                  blurRadius: 1.0,
                  offset: Offset(0, 2),
                ),],
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.04,
                  backgroundImage:AssetImage('images/assignment.png'),
                ),
                Container(
                  child: Text("$Title",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                      fontFamily: 'marienda',
                    ),),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    submitted?Text("Submitted",style: TextStyle(color: Colors.green),):Text("Not Submitted",style: TextStyle(color: Colors.redAccent),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child:Column(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text("Posted on",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.023,
                            ),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text("$cdate",style: TextStyle(
                              color: Colors.white,
                            ),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                          ],
                        )
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child:Column(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text("Due Date",style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.height * 0.023,
                            ),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text("$dueDate",style: TextStyle(
                              color: Colors.white,
                            ),),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.015,
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}