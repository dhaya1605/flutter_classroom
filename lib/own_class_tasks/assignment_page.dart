import 'package:eclass/own_class_tasks/assignment.dart';
import 'package:flutter/material.dart';
import 'package:eclass/styles.dart';
import 'package:eclass/screens/notes_own_classroom_page.dart';
import 'assignment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'quiz.dart';
import 'package:eclass/assignment_details_pages/assignment_detail.dart';
import 'package:eclass/assignment_details_pages/quiz_detail.dart';

class assignmentPage extends StatefulWidget {
  assignmentPage(this.classroomid,this.email);
  String classroomid;
  String email;
  @override
  _assignmentPageState createState() => _assignmentPageState(classroomid,email);
}

class _assignmentPageState extends State<assignmentPage> {
  _assignmentPageState(this.classroomid,this.email);
  String classroomid;
  String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks"),
      ),
      body:SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          child:Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height *0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){

                      showDialog(
                        context: context,
                        builder: (BuildContext context) => Scaffold(body: Center(child: assignment_name(classroomid,email)),backgroundColor: Colors.white38,),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.add),
                            Text("New Assignment"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){

                      showDialog(
                        context: context,
                        builder: (BuildContext context) => Scaffold(body: Center(child: quizname(classroomid)),backgroundColor: Colors.white38,),
                      );

//                    Navigator.push(context, MaterialPageRoute(builder: (context)=>quiz(classroomid)));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.add),
                            Text("New Quiz"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              StreamBuilder(
                stream: Firestore.instance.collection('classrooms').document(classroomid).collection('Assignments&Quiz').orderBy('created utc').snapshots(),
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
                        final assignment_widget = assignment_stful_widget(title,cDate,dueDate,classroomid);
                        Assignments.add(assignment_widget);
                      }
                      else{
                        final quiz_widget =quiz_stful_widget(title,cDate,dueDate,classroomid);
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
              ),
            ],
          )
        ),
      ),
    );
  }
}

class Quiz_widget extends StatelessWidget {
  Quiz_widget(this.Title,this.cdate,this.dueDate,this.classroomid);
  String cdate;
  String dueDate;
  String Title;
  String classroomid;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height *0.05,
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> quiz_details(classroomid,Title)));
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
  Assignment_widget(this.Title,this.cdate,this.dueDate,this.classroomid);
  String cdate;
  String dueDate;
  String Title;
  String classroomid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height *0.05,
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>assignment_details(Title,classroomid)));
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
  quiz_stful_widget(this.Title,this.cdate,this.dueDate,this.classroomid);
  String cdate;
  String dueDate;
  String Title;
  String classroomid;
  @override
  _quiz_stful_widgetState createState() => _quiz_stful_widgetState(Title,cdate,dueDate,classroomid);
}

class _quiz_stful_widgetState extends State<quiz_stful_widget> {
  _quiz_stful_widgetState(this.Title,this.cdate,this.dueDate,this.classroomid);
  String cdate;
  String dueDate;
  String Title;
  String classroomid;
  String SNumbers = '0';

  submissionNumbers()async{
   QuerySnapshot documents = await Firestore.instance.collection('classrooms').document(classroomid).collection('quiz').document(Title).collection('submissions').getDocuments();
   int len = documents.documents.length;
   setState(() {
     SNumbers = len.toString();
   });

  }

  @override
  void initState() {
    // TODO: implement initState
    submissionNumbers();
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
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> quiz_details(classroomid,Title)));
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
                      child: Text('$SNumbers',style: TextStyle(color: Colors.white),),
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



class assignment_stful_widget extends StatefulWidget {
  assignment_stful_widget(this.Title,this.cdate,this.dueDate,this.classroomid);
  String cdate;
  String dueDate;
  String Title;
  String classroomid;
  @override
  _assignment_stful_widgetState createState() => _assignment_stful_widgetState(Title,cdate,dueDate,classroomid);
}

class _assignment_stful_widgetState extends State<assignment_stful_widget> {
  _assignment_stful_widgetState(this.Title,this.cdate,this.dueDate,this.classroomid);
  String cdate;
  String dueDate;
  String Title;
  String classroomid;
  String SNumbers = '0';

  submissionNumbers()async{
    QuerySnapshot documents = await Firestore.instance.collection('classrooms').document(classroomid).collection('assignments').document(Title).collection('submissions').getDocuments();
    int len = documents.documents.length;
    setState(() {
      SNumbers = len.toString();
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    submissionNumbers();
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
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>assignment_details(Title,classroomid)));
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
                      child: Text('$SNumbers',style: TextStyle(color: Colors.white),),
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




class quizname extends StatefulWidget {
  quizname(this.classroomId);
  String classroomId;

  @override
  _quiznameState createState() => _quiznameState(classroomId);
}

class _quiznameState extends State<quizname> {
  _quiznameState(this.classroomId);
  String classroomId;
  String QuizTitle;
  bool title= false;
  int sameName = 0;
  bool nameCheck;
  String originalTitle;


  changingName(){
    setState(() {
      sameName = sameName+1;
      QuizTitle = "$originalTitle" + "($sameName)";
    });
    sameNameChecking(QuizTitle);
  }
  sameNameChecking(SATitle)async{
    await Firestore.instance.collection('classrooms').document(classroomId).collection('quiz').where('quizTitle',isEqualTo: SATitle).getDocuments().then((event){
      if(event.documents.isEmpty){
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> student_qyiz_details(classroomid,Title,email)));
        print(QuizTitle);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>quiz(classroomId,QuizTitle)));

      }
      else{
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> afterSubmission_quiz(classroomid,Title,email)));
        changingName();
        print("changing again");


      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height *0.02,
            ),
            Text("Quiz Title"),
            SizedBox(
              height: MediaQuery.of(context).size.height *0.02,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your title here",
                errorText: title ? "Title should not be null" : null,
              ),
              onChanged: (value){
                QuizTitle = value;
                originalTitle = value;
              },

            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("cancel"),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                RaisedButton(
                  onPressed: ()async{
                    if(QuizTitle != null){
                      await Firestore.instance.collection('classrooms').document(classroomId).collection('quiz').where('quizTitle',isEqualTo: QuizTitle).getDocuments().then((event){
                        if(event.documents.isEmpty){
                          print("new");
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>quiz(classroomId,QuizTitle)));

                        }
                        else{

                          print("already");
                          changingName();

                        }
                      });

                    }
                    else{
                      setState(() {
                        title = true;
                      });

                    }
                  },
                  child: Text("Confirm"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class assignment_name extends StatefulWidget {
  assignment_name(this.classroomId,this.email);
  String classroomId;
  String email;
  @override
  _assignment_nameState createState() => _assignment_nameState(classroomId,email);
}

class _assignment_nameState extends State<assignment_name> {
  _assignment_nameState(this.classroomId,this.email);
  String classroomId;
  String ATitle;
  bool title= false;
  String email;
  int sameName = 0;
  bool nameCheck;
  String originalTitle;

  changingName(){
    setState(() {
      sameName = sameName+1;
      ATitle = "$originalTitle" + "($sameName)";
    });
    sameNameChecking(ATitle);
  }
  sameNameChecking(SATitle)async{
    await Firestore.instance.collection('classrooms').document(classroomId).collection('assignments').where('assignmentName',isEqualTo: SATitle).getDocuments().then((event){
      if(event.documents.isEmpty){
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> student_qyiz_details(classroomid,Title,email)));
        print(ATitle);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>assignment_task(classroomId,email,ATitle)));
      }
      else{
        //Navigator.push(context, MaterialPageRoute(builder: (context)=> afterSubmission_quiz(classroomid,Title,email)));
        changingName();
        print("changing again");


      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height *0.02,
            ),
            Text("Assignment Title"),
            SizedBox(
              height: MediaQuery.of(context).size.height *0.02,
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter your title here",
                errorText: title ? "Title should not be null" : null,
              ),
              onChanged: (value){
                ATitle = value;
                originalTitle = value;
              },

            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text("cancel"),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                RaisedButton(
                  onPressed: ()async{
                    if(ATitle != null){
                      await Firestore.instance.collection('classrooms').document(classroomId).collection('assignments').where('assignmentName',isEqualTo: ATitle).getDocuments().then((event){
                        if(event.documents.isEmpty){
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=> student_qyiz_details(classroomid,Title,email)));
                          print("new");
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>assignment_task(classroomId,email,ATitle)));

                        }
                        else{
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=> afterSubmission_quiz(classroomid,Title,email)));

                          print("already");
                          changingName();

                        }
                      });

                    }
                    else{
                      setState(() {
                        title = true;
                      });

                    }
                  },
                  child: Text("Confirm"),
                ),
              ],
            ),
          ],
        ),
      ),
    );;
  }
}
