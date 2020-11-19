import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class shortAnswer extends StatefulWidget {
  shortAnswer(this.Question,this.Qno,this.answer);
  var Question;
  int Qno;
  var answer;
  @override
  _shortAnswerState createState() => _shortAnswerState(Question,Qno,answer);
}

class _shortAnswerState extends State<shortAnswer> {
  _shortAnswerState(this.Question,this.Qno,this.answer);
  var Question;
  int Qno;
  var answer;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0, 2),
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.025,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.only(bottomRight: Radius.elliptical(30, 25)),
                      color: Colors.red,
                    ),
                    child: Center(child: Text("$Qno",style: TextStyle(color: Colors.white),),),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.025,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Text(
                      "Short Answer",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        fontFamily: 'marienda',
                        color: Colors.black,
                      ),
                    ),
                  ),


                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.025,
              ),
              Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.025,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child:Text("$Question",style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                ),),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.025,
              ),
              Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.025,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child:Text("$answer",style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                ),),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.025,
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class options extends StatefulWidget {
  options(this.Question,this.optA,this.optB,this.optC,this.optD,this.CorrectOption,this.Qno);
  var Question;
  var optA;
  var optB;
  var optC;
  var optD;
  var CorrectOption;
  int Qno;
  @override
  _optionsState createState() => _optionsState(Question,optA,optB,optC,optD,CorrectOption,Qno);
}

class _optionsState extends State<options> {
  _optionsState(this.Question,this.optA,this.optB,this.optC,this.optD,this.CorrectOption,this.Qno);
  var Question;
  var optA;
  var optB;
  var optC;
  var optD;
  var CorrectOption;
  int Qno;
  List<Widget> optionsWidgets = [];
  String dropdownValue = 'A';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
//      height: MediaQuery.of(context).size.height * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0, 2),
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.only(bottomRight: Radius.elliptical(30, 25)),
                      color: Colors.deepPurpleAccent,
                    ),
                    child: Center(
                      child: Text("$Qno",style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        color: Colors.white,
                      ),),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width *0.6,
                    child: Text(
                      "Choose the correct option",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        fontFamily: 'marienda',
                        color: Colors.black,
                      ),
                    ),
                  ),


                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Text("$Question",style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.03,
                ),),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("A)",style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                  ),),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text('$optA',style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                    ),),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("B)",style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                  ),),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text('$optB',style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                    ),),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("C)",style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                  ),),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text('$optC',style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                    ),),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("D)",style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                  ),),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text('$optD',style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                    ),),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height *0.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.deepPurpleAccent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("Selected option",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white24,
                      ),
                      child: Center(
                        child: Text("$CorrectOption"),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class checkBoxs extends StatefulWidget {
  checkBoxs(this.Question,this.optA,this.optB,this.optC,this.optD,this.Avalue,this.Bvalue,this.Cvalue,this.Dvalue,this.qno);
  bool Avalue;
  bool Bvalue;
  bool Cvalue;
  bool Dvalue;
  var Question;
  var optA;
  var optB;
  var optC;
  var optD;
  int qno;
  @override
  _checkBoxsState createState() => _checkBoxsState(Question,optA,optB,optC,optD,Avalue,Bvalue,Cvalue,Dvalue,qno);
}

class _checkBoxsState extends State<checkBoxs> {
  _checkBoxsState(this.Question,this.optA,this.optB,this.optC,this.optD,this.Avalue,this.Bvalue,this.Cvalue,this.Dvalue,this.qno);

  bool Avalue;
  bool Bvalue;
  bool Cvalue;
  bool Dvalue;
  var Question;
  var optA;
  var optB;
  var optC;
  var optD;
  int qno;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
//      height: MediaQuery.of(context).size.height * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0, 2),
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.only(bottomRight: Radius.elliptical(30, 25)),
                      color: Colors.orangeAccent,
                    ),
                    child:Center(
                      child: Text("$qno",style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        color: Colors.white,
                      ),),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Text(
                      "Choose the correct options",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        fontFamily: 'marienda',
                        color: Colors.black,
                      ),
                    ),
                  ),


                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Text("$Question",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                  ),),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Checkbox(
                    value: Avalue,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text("$optA",style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                    ),),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Checkbox(
                    value: Bvalue,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text("$optB",style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                    ),),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Checkbox(
                    value: Cvalue,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text("$optC",style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                    ),),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Checkbox(
                    value: Dvalue,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text("$optD",style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                    ),),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class afterSubmission_quiz extends StatefulWidget {
  afterSubmission_quiz(this.classroomId,this.quizTitle,this.email);
  String classroomId;
  String quizTitle;
  String email;
  @override
  _afterSubmission_quizState createState() => _afterSubmission_quizState(classroomId,quizTitle,email);
}

class _afterSubmission_quizState extends State<afterSubmission_quiz> {
  _afterSubmission_quizState(this.classroomId,this.quizTitle,this.email);
  String classroomId;
  String quizTitle;
  String email;
  String time;
  String date;
  bool evaluated = false;
  String points;
  String total;

  submissionTime()async{
    DocumentSnapshot document =  await Firestore.instance.collection('classrooms').document(classroomId).collection('quiz').document(quizTitle).collection('submissions').document(email).get();
    setState(() {
      time = document.data['time'];
      date  = document.data['date'];
      evaluated = document.data['evaluated'];
      points = document.data['points'];
      total = document.data['total'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    submissionTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("$quizTitle"),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  evaluated? Column(
                    children: <Widget>[
                      SizedBox(height: 10,),
                      Text("Evaluated",style: TextStyle(color: Colors.green),),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                              height:40.0,
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Center(child: Text("$points",style: TextStyle(fontSize: 20,color: Colors.green),))
                          ),
                          Text("/"),
                          Container(
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Center(child: Text("$total",style: TextStyle(fontSize: 20,color: Colors.green),))
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),

                    ],
                  ) : Text("Not Evaluated",style: TextStyle(color: Colors.orangeAccent),),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Submitted on"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Text("$date"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.05,
                      ),
                      Text("$time"),
                    ],
                  ),
                  StreamBuilder(
                      stream: Firestore.instance.collection('classrooms').document(classroomId).collection('quiz').document(quizTitle).collection('submissions').document(email).collection('answers').snapshots(),
                      builder: (context,snapshot){
                        if(!snapshot.hasData){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        else{
                          List<Widget> Questions = [];
                          final questions = snapshot.data.documents;
                          for(var ques in questions){
                            String type = ques.data['qtype'];
                            int qno = ques.data['Qno'];
                            var Question = ques.data['question'];
                            var answer = ques.data['answer'];
                            var optionA = ques.data['a'];
                            var optionB = ques.data['b'];
                            var optionC = ques.data['c'];
                            var optionD = ques.data['d'];
                            bool valueA = ques.data['avalue'];
                            bool valueB = ques.data['bvalue'];
                            bool valueC = ques.data['cvalue'];
                            bool valueD = ques.data['dvalue'];
                            String crtOption = ques.data['correctOption'];
                            if(type == "shortAnswer"){
                              final shrt_ans_widget = shortAnswer(Question,qno,answer);
                              Questions.add(shrt_ans_widget);
                            }
                            else if (type == "options"){
                              final options_widget = options(Question,optionA,optionB,optionC,optionD,crtOption,qno);
                              Questions.add(options_widget);
                            }
                            else{
                              final checkbox_widget = checkBoxs(Question,optionA,optionB,optionC,optionD,valueA,valueB,valueC,valueD,qno);
                              Questions.add(checkbox_widget);
                            }
                          }
                          return Column(
                            children: Questions,
                          );
                        }
                      }
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  }
}
