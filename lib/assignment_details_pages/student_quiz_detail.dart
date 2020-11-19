import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eclass/own_class_tasks/assignment_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool submitButtonEnable = false;

class shortAnswer extends StatefulWidget {
  shortAnswer(this.Question,this.Qno,this.classroomId,this.quiztitle,this.email);
  var Question;
  int Qno;
  String classroomId;
  String quiztitle;
  String email;

  @override
  _shortAnswerState createState() => _shortAnswerState(Question,Qno,classroomId,quiztitle,email);
}

class _shortAnswerState extends State<shortAnswer> {
  _shortAnswerState(this.Question,this.Qno,this.classroomId,this.quiztitle,this.email);
  var Question;
  int Qno;
  var answer;
  String classroomId;
  String quiztitle;
  String email;
  bool confirm = false;
  bool enable = true;
  bool error = false;

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
                            setState(() {
                              answer = value;
                            });
                          },
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: "Answer",
                            border: InputBorder.none,
                            errorText:error? "Empty answer can't be submitted":null,
                          ),
                          enabled: enable,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.025,
              ),
              RawMaterialButton(
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
                elevation: 5.0,
                child: confirm?Icon(Icons.check,color: Colors.white,):Icon(Icons.check,color: Colors.lightGreen,),
                fillColor:confirm? Colors.lightGreen:Colors.white,
                onPressed: ()async{
                  if(answer==null){
                    setState(() {
                      error = true;
                    });
                  }

                  else {
                    setState(() {
                      confirm = !confirm;
                      enable = !enable;
                      submitButtonEnable = true;
                    });


                    if (confirm == true) {
                      await Firestore.instance.collection('classrooms')
                          .document(classroomId).collection('quiz').document(
                          quiztitle).collection("submissions").document(email)
                          .collection("answers").document(Qno.toString())
                          .setData({
                        'answer': answer,
                        'Qno': Qno,
                        'qtype': 'shortAnswer',
                        'question': Question,
                      });
                    }
                  }

                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.025,
              ),
            ],
          ),
        ),

//        RawMaterialButton(
//          padding: EdgeInsets.all(15.0),
//          shape: CircleBorder(),
//          elevation: 5.0,
//          child: confirm?Icon(Icons.check,color: Colors.white,):Icon(Icons.check,color: Colors.lightGreen,),
//          fillColor:confirm? Colors.lightGreen:Colors.white,
//          onPressed: ()async{
//            setState(() {
//              confirm = !confirm;
//            });
//
//
//
//            if(confirm == true){
//              await Firestore.instance.collection('classrooms').document(classroomId).collection('quiz').document(quiztitle).collection("submissions").document(email).collection("answers").document(Qno.toString()).setData({
//                'answer': answer,
//                'Qno' : Qno,
//                'qtype':'short answer',
//                'question': Question,
//              });
//            }
//
//
//
//          },
//        ),
      ],
    );
  }
}


class options extends StatefulWidget {
  options(this.Question,this.optA,this.optB,this.optC,this.optD,this.CorrectOption,this.Qno,this.classroomId,this.quizTitle,this.email);
  var Question;
  var optA;
  var optB;
  var optC;
  var optD;
  var CorrectOption;
  int Qno;
  String classroomId;
  String quizTitle;
  String email;
  @override
  _optionsState createState() => _optionsState(Question,optA,optB,optC,optD,CorrectOption,Qno,classroomId,quizTitle,email);
}

class _optionsState extends State<options> {
  _optionsState(this.Question,this.optA,this.optB,this.optC,this.optD,this.CorrectOption,this.Qno,this.classroomId,this.quizTitle,this.email);
  var Question;
  var optA;
  var optB;
  var optC;
  var optD;
  var CorrectOption;
  int Qno;
  List<Widget> optionsWidgets = [];
  String dropdownValue = 'A';
  bool confirm = false;
  bool enable = true;
  String classroomId;
  String quizTitle;
  String email;

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
                height: MediaQuery.of(context).size.height * 0.03,
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
                height: MediaQuery.of(context).size.height * 0.03,
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
                height: MediaQuery.of(context).size.height * 0.03,
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
                height: MediaQuery.of(context).size.height * 0.03,
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
                height: MediaQuery.of(context).size.height * 0.03,
              ),

              Container(
                width:confirm? MediaQuery.of(context).size.width * 0.5 : MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height *0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color:confirm? Colors.lightGreen : Colors.deepPurpleAccent,
                ),
                child:confirm?Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Text("Your option",style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white24,
                      ),
                      child: Center(
                        child: Text("$dropdownValue",style: TextStyle(color: Colors.white),),
                      ),
                    )
                  ],
                ): Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("Choose your option",style: TextStyle(
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
              RawMaterialButton(
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
                elevation: 5.0,
                child: confirm?Icon(Icons.check,color: Colors.white,):Icon(Icons.check,color: Colors.lightGreen,),
                fillColor:confirm? Colors.lightGreen:Colors.white,
                onPressed: ()async{
                  setState(() {
                    confirm = !confirm;
                    enable = !enable;
                    submitButtonEnable = true;
                  });



                  if(confirm == true){
                    await Firestore.instance.collection('classrooms').document(classroomId).collection('quiz').document(quizTitle).collection("submissions").document(email).collection("answers").document(Qno.toString()).setData({
                      'answer': dropdownValue,
                      'Qno' : Qno,
                      'qtype':'options',
                      'question': Question,
                      'a':optA,
                      'b':optB,
                      'c':optC,
                      'd':optD,
                      'correctOption' : CorrectOption,
                    });
                  }



                },
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


class checkBoxs extends StatefulWidget {
  checkBoxs(this.Question,this.optA,this.optB,this.optC,this.optD,this.Avalue,this.Bvalue,this.Cvalue,this.Dvalue,this.qno,this.classroomId,this.quizTitle,this.email);
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
  String classroomId;
  String quizTitle;
  String email;
  @override
  _checkBoxsState createState() => _checkBoxsState(Question,optA,optB,optC,optD,Avalue,Bvalue,Cvalue,Dvalue,qno,classroomId,quizTitle,email);
}

class _checkBoxsState extends State<checkBoxs> {
  _checkBoxsState(this.Question,this.optA,this.optB,this.optC,this.optD,this.Avalue,this.Bvalue,this.Cvalue,this.Dvalue,this.qno,this.classroomId,this.quizTitle,this.email);

  bool Avalue ;
  bool Bvalue ;
  bool Cvalue;
  bool Dvalue ;
  bool a_value = false;
  bool b_value = false;
  bool c_value = false;
  bool d_value = false;
  var Question;
  var optA;
  var optB;
  var optC;
  var optD;
  int qno;
  bool confirm = false;
  bool enable = true;
  String classroomId;
  String quizTitle;
  String email;

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
                  enable? Checkbox(
                    value: a_value,
                    onChanged: (bool value){
                      setState(() {
                        a_value = value;
                      });
                    },
                  ) : Checkbox(value: a_value,),
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
                  enable?Checkbox(
                    value: b_value,
                    onChanged: (bool value){
                      setState(() {
                        b_value = value;
                      });
                    },
                  ):Checkbox(value: b_value,),
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
                  enable?Checkbox(
                    value: c_value,
                    onChanged: (bool value){
                      setState(() {
                        c_value = value;
                      });
                    },
                  ):Checkbox(value: c_value,),
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
                  enable?Checkbox(
                    value: d_value,
                    onChanged: (bool value){
                      setState(() {
                        d_value = value;
                      });
                    },
                  ):Checkbox(value: d_value,),
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
              RawMaterialButton(
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
                elevation: 5.0,
                child: confirm?Icon(Icons.check,color: Colors.white,):Icon(Icons.check,color: Colors.lightGreen,),
                fillColor:confirm? Colors.lightGreen:Colors.white,
                onPressed: ()async{
                  if(a_value ==false && b_value ==false && c_value == false && d_value == false){
                    null;
                  }
                  else {
                    setState(() {
                      confirm = !confirm;
                      enable = !enable;
                      submitButtonEnable = true;
                    });


                    if (confirm == true) {
                      await Firestore.instance.collection('classrooms')
                          .document(classroomId).collection('quiz').document(
                          quizTitle).collection("submissions").document(email)
                          .collection("answers").document(qno.toString())
                          .setData({
                        'Qno': qno,
                        'qtype': 'checkbox',
                        'question': Question,
                        'a': optA,
                        'b': optB,
                        'c': optC,
                        'd': optD,
                        'avalue': Avalue,
                        'bvalue': Bvalue,
                        'cvalue': Cvalue,
                        'dvalue': Dvalue,
                        'std_avalue': a_value,
                        'std_bvalue': b_value,
                        'std_cvalue': c_value,
                        'std_dvalue': d_value
                      });
                    }
                  }
                },
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



class student_qyiz_details extends StatefulWidget {
  student_qyiz_details(this.classroomId,this.quizTitle,this.email);
  String classroomId;
  String quizTitle;
  String email;
  @override
  _student_qyiz_detailsState createState() => _student_qyiz_detailsState(classroomId,quizTitle,email);
}

class _student_qyiz_detailsState extends State<student_qyiz_details> {
  _student_qyiz_detailsState(this.classroomId,this.quizTitle,this.email);
  String classroomId;
  String quizTitle;
  String email;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  deleteEmail()async{
    await Firestore.instance.collection('classrooms').document(classroomId).collection('quiz').document(quizTitle).collection('submissions').document(email).delete();
  }


  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to discard your attempt?'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: ()async{
              await Firestore.instance.collection('classrooms').document(classroomId).collection('quiz').document(quizTitle).collection('submissions').document(email).collection('answers').getDocuments().then((snapshots){
                for (DocumentSnapshot ds in snapshots.documents){
                  ds.reference.delete();
                }
              });

              deleteEmail();



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
                              final shrt_ans_widget = shortAnswer(Question,qno,classroomId,quizTitle,email);
                              Questions.add(shrt_ans_widget);
                            }
                            else if (type == "options"){
                              final options_widget = options(Question,optionA,optionB,optionC,optionD,crtOption,qno,classroomId,quizTitle,email);
                              Questions.add(options_widget);
                            }
                            else{
                              final checkbox_widget = checkBoxs(Question,optionA,optionB,optionC,optionD,valueA,valueB,valueC,valueD,qno,classroomId,quizTitle,email);
                              Questions.add(checkbox_widget);
                            }
                          }
                          return Column(
                            children: Questions.reversed.toList(),
                          );
                        }
                      }
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  GestureDetector(
                    onTap: ()async{
                      if(submitButtonEnable) {
                        DateTime now = DateTime.now();
                        String date = now.day.toString() + "-" + now.month
                            .toString() + "-" + now.year.toString();
                        int ampm = now.hour > 12 ? now.hour - 12 : now.hour;
                        String period = ampm < 12 ? "AM" : "PM";
                        String time = ampm.toString() + ":" + now.minute
                            .toString() + " " + period;
                        await Firestore.instance.collection('classrooms')
                            .document(classroomId).collection('quiz').document(
                            quizTitle).collection("submissions").document(email)
                            .setData({
                          'submitted_utc': now,
                          'date': date,
                          'time': time,
                          'email':email,
                          'evaluated' : false
                        });


                        Fluttertoast.showToast(
                          msg: "Submitted successfully",
                          backgroundColor: Colors.deepPurpleAccent.shade200,
                          textColor: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                        );


                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color:submitButtonEnable?Colors.lightGreen: Colors.grey.shade200,
                      ),
                      child: Center(child: Text("Submit",style: TextStyle(
                          color: submitButtonEnable?Colors.white:Colors.black,fontWeight: FontWeight.bold),)),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                  ),
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
