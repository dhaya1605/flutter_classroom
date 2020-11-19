import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';




List<Widget> QContents = [];
List<Widget> edit = [];
List<List> toDb =[];

int GQno;

void clearfunc(){
  edit.clear();
}

class quiz extends StatefulWidget {
  quiz(this.classroomId,this.quizTitle);
  String classroomId;
  String quizTitle;
  @override
  _quizState createState() => _quizState(classroomId,quizTitle);
}

class _quizState extends State<quiz> {
  _quizState(this.classroomId,this.quizTitle);
  String classroomId;
  String quizTitle;
  DateTime datetime;
  String QTitle;
  String QDesc;
  int month=00,year=0000,day=00;
  int Cmonth,Cyear,Cday;
  String dueDate;
  String Cdate;
  bool enableButton = false;

  @override
  void initState() {
    // TODO: implement initState
//    print(classroomId);
//    print(quizTitle);
    GQno = 1;
    super.initState();
  }




  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to discard this quiz?'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: ()async{
              await Firestore.instance.collection('classrooms').document(classroomId).collection('quiz').document(quizTitle).collection(quizTitle).getDocuments().then((snapshots){
                for (DocumentSnapshot ds in snapshots.documents){
                  ds.reference.delete();
                }
              });
              Navigator.of(context).pop(true);
              },
            child: Text("YES"),
          ),
        ],
      ),
    ) ??
        false;
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Quiz"),
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
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  StreamBuilder(
                    stream: Firestore.instance.collection('classrooms').document(classroomId).collection('quiz').document(quizTitle).collection(quizTitle).snapshots(),
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
                          int qno = ques.data['qno'];
                          var Question = ques.data['question'];
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
                            final shrt_ans_widget = shortAnswer(Question,qno);
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
                        if(Questions.length>0){
                          enableButton = true;
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => Scaffold(body: Center(child: editShortAnswer(classroomId,quizTitle)),backgroundColor: Colors.white38,),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(width: 0.5,color: Colors.redAccent),
                          ),
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.add,color: Colors.redAccent,),
                                Text("Short Answer",style: TextStyle(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => Scaffold(body: Center(child: editOptions(classroomId,quizTitle)),backgroundColor: Colors.white38,),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(width: 0.5,color: Colors.deepPurpleAccent),
                          ),
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.add,color: Colors.deepPurpleAccent,),
                                Text("Options",style: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => Scaffold(body: Center(child: editCheckbox(classroomId,quizTitle)),backgroundColor: Colors.white38,),
                          );

                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(width: 0.5,color: Colors.orangeAccent),
                          ),
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.add,color: Colors.orangeAccent,),
                                Text("CheckBox",style: TextStyle(
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Due Date",style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.02,
                        fontFamily: 'marienda',
                      ),),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width*0.9,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              color:Colors.white,
                              child: Text("$day-$month-$year",style: TextStyle(),textAlign: TextAlign.center,),
                              width: MediaQuery.of(context).size.width*0.6,
                            ),
                            RaisedButton(
                              child: Text("select"),
                              onPressed: (){
                                showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2100)).then((onValue){
                                  setState(() {
                                    month = onValue.month;
                                    year = onValue.year;
                                    day = onValue.day;
                                    dueDate= "$day-$month-$year";
                                    datetime = onValue;
                                  });
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),

                  enableButton?Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: ()async{
                         await Firestore.instance.collection('classrooms').document(classroomId).collection('quiz').document(quizTitle).collection(quizTitle).getDocuments().then((snapshots){
                            for (DocumentSnapshot ds in snapshots.documents){
                              ds.reference.delete();
                            }
                          });
                         await Firestore.instance.collection('classrooms').document(classroomId).collection('quiz').document(quizTitle).delete();
                          Navigator.pop(context);
                        },
                        child: Text("Discard",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                        color: Colors.redAccent,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.2,
                      ),

                      RaisedButton(
                        onPressed: ()async{
                          Cmonth = DateTime.now().month;
                          Cyear = DateTime.now().year;
                          Cday = DateTime.now().day;
                          Cdate= "$Cday-$Cmonth-$Cyear";
                          if(dueDate!=null) {
                            await Firestore.instance.collection('classrooms')
                                .document(classroomId).collection('quiz')
                                .document(quizTitle)
                                .setData({
                              'quizTitle': quizTitle,
                              'created utc': DateTime.now(),
                              'due date utc': datetime.toUtc(),
                              'created': Cdate,
                              'due date': dueDate,

                            });
                            await Firestore.instance.collection('classrooms')
                                .document(classroomId).collection(
                                'Assignments&Quiz').document()
                                .setData({
                              'type': 'Quiz',
                              'dueDate': dueDate,
                              'created utc': DateTime.now(),
                              'created': Cdate,
                              'dueDate utc': datetime.toUtc(),
                              'title': quizTitle,
                            });
                            Navigator.pop(context);
                          }
                          else{
                            Fluttertoast.showToast(
                              msg: "Enter the due date",
                              backgroundColor: Colors
                                  .grey,
                              textColor: Colors.white,
                              fontSize: MediaQuery.of(context)
                                  .size
                                  .height *
                                  0.03,
                            );
                          }
                        },
                        child: Text("Post",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                        color: Colors.green,
                      ),
                    ],
                  ):Container(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class shortAnswer extends StatefulWidget {
  shortAnswer(this.Question,this.Qno);
  var Question;
  int Qno;
  @override
  _shortAnswerState createState() => _shortAnswerState(Question,Qno);
}

class _shortAnswerState extends State<shortAnswer> {
  _shortAnswerState(this.Question,this.Qno);
  var Question;
  int Qno;
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
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 1.0, color: Colors.grey),
                ),
                child: new ConstrainedBox(
                  constraints: BoxConstraints(
//                minHeight: MediaQuery.of(context).size.height * 0.1,
                    maxHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                  child: new Scrollbar(
                    child: new SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      reverse: false,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 3.0),
                        child: new TextField(
                          onChanged: (value) {
                            setState(() {});
                          },
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Answer",
                            border: InputBorder.none,
                          ),
                          enabled: false,
                        ),
                      ),
                    ),
                  ),
                ),
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

class editShortAnswer extends StatefulWidget {
  editShortAnswer(this.classroomId,this.quizTitle);
  String classroomId;
  String quizTitle;
  @override
  _editShortAnswerState createState() => _editShortAnswerState(classroomId,quizTitle);
}

class _editShortAnswerState extends State<editShortAnswer> {
  _editShortAnswerState(this.classroomId,this.quizTitle);
  String classroomId;
  String quizTitle;

  var Question;
  String Type = "shortAnswer";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
//          height: MediaQuery.of(context).size.height * 0.3,
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
                  height: MediaQuery.of(context).size.height * 0.02,
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
                    ),
                    Text(
                      "Question Number",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                        fontFamily: 'marienda',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                            ))),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(width: 1.0, color: Colors.grey),
                  ),
                  child: new ConstrainedBox(
                    constraints: BoxConstraints(
//                minHeight: MediaQuery.of(context).size.height * 0.1,
                      maxHeight: MediaQuery.of(context).size.height * 0.7,
                    ),
                    child: new Scrollbar(
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: false,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 3.0),
                          child: new TextField(
                            onChanged: (value) {
                              setState(() {
                                Question=value;
                              });
                            },
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "Question",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(width: 1.0, color: Colors.grey),
                  ),
                  child: new ConstrainedBox(
                    constraints: BoxConstraints(
//                minHeight: MediaQuery.of(context).size.height * 0.1,
                      maxHeight: MediaQuery.of(context).size.height * 0.7,
                    ),
                    child: new Scrollbar(
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: false,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 3.0),
                          child: new TextField(
                            onChanged: (value) {
                              setState(() {});
                            },
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "Answer",
                              border: InputBorder.none,
                            ),
                            enabled: false,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                RaisedButton(
                  child: Text("done"),
                  onPressed: ()async{

                    await Firestore.instance.collection('classrooms').document(classroomId).collection('quiz').document(quizTitle).collection(quizTitle).document().setData({
                      'qno': GQno,
                      'qtype': Type,
                      'question':Question,
                    });
                    setState(() {
                      GQno=GQno+1;
                    });

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
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
                  color: Colors.lightGreen,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("Correct option",style: TextStyle(
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

class editOptions extends StatefulWidget {
  editOptions(this.classroomId,this.quizTitle);
  String classroomId;
  String quizTitle;
  @override
  _editOptionsState createState() => _editOptionsState(classroomId,quizTitle);
}

class _editOptionsState extends State<editOptions> {
  _editOptionsState(this.classroomId,this.quizTitle);
  String classroomId;
  String quizTitle;
  List<Widget> optionsWidgets = [];
  String dropdownValue = 'A';
  var Question;
  String Type ="options";
  var optA;
  var optB;
  var optC;
  var optD;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
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
                    ),
                    Text(
                      "Question Number",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        fontFamily: 'marienda',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                            ))),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(width: 1.0, color: Colors.grey),
                  ),
                  child: new ConstrainedBox(
                    constraints: BoxConstraints(
//                minHeight: MediaQuery.of(context).size.height * 0.1,
                      maxHeight: MediaQuery.of(context).size.height * 0.7,
                    ),
                    child: new Scrollbar(
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: false,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 3.0),
                          child: new TextField(
                            onChanged: (value) {
                              setState(() {
                                Question = value;
                              });
                            },
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "Question",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("A)"),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1.0, color: Colors.grey),
                      ),
                      child: new ConstrainedBox(
                        constraints: BoxConstraints(
//                minHeight: MediaQuery.of(context).size.height * 0.1,
                          maxHeight: MediaQuery.of(context).size.height * 0.7,
                        ),
                        child: new Scrollbar(
                          child: new SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            reverse: false,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0, right: 3.0),
                              child: new TextField(
                                onChanged: (value) {
                                  setState(() {
                                    optA = value;
                                  });
                                },
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: "Answer",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("B)"),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1.0, color: Colors.grey),
                      ),
                      child: new ConstrainedBox(
                        constraints: BoxConstraints(
//                minHeight: MediaQuery.of(context).size.height * 0.1,
                          maxHeight: MediaQuery.of(context).size.height * 0.7,
                        ),
                        child: new Scrollbar(
                          child: new SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            reverse: false,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0, right: 3.0),
                              child: new TextField(
                                onChanged: (value) {
                                  setState(() {
                                    optB = value;
                                  });
                                },
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: "Answer",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("C)"),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1.0, color: Colors.grey),
                      ),
                      child: new ConstrainedBox(
                        constraints: BoxConstraints(
//                minHeight: MediaQuery.of(context).size.height * 0.1,
                          maxHeight: MediaQuery.of(context).size.height * 0.7,
                        ),
                        child: new Scrollbar(
                          child: new SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            reverse: false,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0, right: 3.0),
                              child: new TextField(
                                onChanged: (value) {
                                  setState(() {
                                    optC = value;
                                  });
                                },
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: "Answer",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("D)"),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1.0, color: Colors.grey),
                      ),
                      child: new ConstrainedBox(
                        constraints: BoxConstraints(
//                minHeight: MediaQuery.of(context).size.height * 0.1,
                          maxHeight: MediaQuery.of(context).size.height * 0.7,
                        ),
                        child: new Scrollbar(
                          child: new SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            reverse: false,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0, right: 3.0),
                              child: new TextField(
                                onChanged: (value) {
                                  setState(() {
                                    optD = value;
                                  });
                                },
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: "Answer",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                    color: Colors.lightGreen,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text("Correct option",style: TextStyle(
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
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            items: <String>['A', 'B', 'C', 'D'].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            onChanged: (value) {
                              setState(() {
                                dropdownValue = value;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                RaisedButton(
                  child: Text("done"),
                  onPressed: ()async{


                    await Firestore.instance.collection('classrooms').document(classroomId).collection('quiz').document(quizTitle).collection(quizTitle).document().setData({
                      'qno': GQno,
                      'qtype': Type,
                      'question':Question,
                      'a':optA,
                      'b':optB,
                      'c':optC,
                      'd':optD,
                      'correctOption': dropdownValue,
                    });
                    setState(() {
                      GQno=GQno+1;
                    });

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
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


class editCheckbox extends StatefulWidget {
  editCheckbox(this.classroomId,this.quizTitle);
  String classroomId;
  String quizTitle;
  @override
  _editCheckboxState createState() => _editCheckboxState(classroomId,quizTitle);
}

class _editCheckboxState extends State<editCheckbox> {
  _editCheckboxState(this.classroomId,this.quizTitle);
  String quizTitle;
  String classroomId;
  bool Avalue = false;
  bool Bvalue = false;
  bool Cvalue = false;
  bool Dvalue = false;
  var Question;
  var optA;
  var optB;
  var optC;
  var optD;
  String Type = "checkbox";
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
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
                    ),
                    Text(
                      "Question Number",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.03,
                        fontFamily: 'marienda',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.33,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            child: Icon(
                              Icons.close,
                              color: Colors.red,
                            ))),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(width: 1.0, color: Colors.grey),
                  ),
                  child: new ConstrainedBox(
                    constraints: BoxConstraints(
//                minHeight: MediaQuery.of(context).size.height * 0.1,
                      maxHeight: MediaQuery.of(context).size.height * 0.7,
                    ),
                    child: new Scrollbar(
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: false,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 3.0),
                          child: new TextField(
                            onChanged: (value) {
                              setState(() {
                                Question = value;
                              });
                            },
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "Question",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Checkbox(
                      value: Avalue,
                      onChanged: (bool value){
                        setState(() {
                          Avalue = value;
                        });
                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1.0, color: Colors.grey),
                      ),
                      child: new ConstrainedBox(
                        constraints: BoxConstraints(
//                minHeight: MediaQuery.of(context).size.height * 0.1,
                          maxHeight: MediaQuery.of(context).size.height * 0.7,
                        ),
                        child: new Scrollbar(
                          child: new SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            reverse: false,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0, right: 3.0),
                              child: new TextField(
                                onChanged: (value) {
                                  setState(() {
                                    optA= value;
                                  });
                                },
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: "Answer",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                      value: Bvalue,
                      onChanged: (bool value){
                        setState(() {
                          Bvalue = value;
                        });

                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1.0, color: Colors.grey),
                      ),
                      child: new ConstrainedBox(
                        constraints: BoxConstraints(
//                minHeight: MediaQuery.of(context).size.height * 0.1,
                          maxHeight: MediaQuery.of(context).size.height * 0.7,
                        ),
                        child: new Scrollbar(
                          child: new SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            reverse: false,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0, right: 3.0),
                              child: new TextField(
                                onChanged: (value) {
                                  setState(() {
                                    optB = value;
                                  });
                                },
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: "Answer",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                      onChanged: (bool value){
                        setState(() {
                          Cvalue = value;
                        });
                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1.0, color: Colors.grey),
                      ),
                      child: new ConstrainedBox(
                        constraints: BoxConstraints(
//                minHeight: MediaQuery.of(context).size.height * 0.1,
                          maxHeight: MediaQuery.of(context).size.height * 0.7,
                        ),
                        child: new Scrollbar(
                          child: new SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            reverse: false,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0, right: 3.0),
                              child: new TextField(
                                onChanged: (value) {
                                  setState(() {
                                    optC = value;
                                  });
                                },
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: "Answer",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
                      value: Dvalue,
                      onChanged: (bool value){
                        setState(() {
                          Dvalue = value;
                        });
                      },
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 1.0, color: Colors.grey),
                      ),
                      child: new ConstrainedBox(
                        constraints: BoxConstraints(
//                minHeight: MediaQuery.of(context).size.height * 0.1,
                          maxHeight: MediaQuery.of(context).size.height * 0.7,
                        ),
                        child: new Scrollbar(
                          child: new SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            reverse: false,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5.0, right: 3.0),
                              child: new TextField(
                                onChanged: (value) {
                                  setState(() {
                                    optD = value;
                                  });
                                },
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: "Answer",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                RaisedButton(
                  child: Text("done"),
                  onPressed: ()async{

                    await Firestore.instance.collection('classrooms').document(classroomId).collection('quiz').document(quizTitle).collection(quizTitle).document().setData({
                      'qno': GQno,
                      'qtype': Type,
                      'question':Question,
                      'avalue':Avalue,
                      'bvalue':Bvalue,
                      'cvalue':Cvalue,
                      'dvalue':Dvalue,
                      'a':optA,
                      'b':optB,
                      'c':optC,
                      'd':optD,

                    });

                    setState(() {
                      GQno=GQno+1;
                    });

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



