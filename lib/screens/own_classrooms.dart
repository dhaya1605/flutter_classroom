import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eclass/styles.dart';
import 'package:eclass/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'own_classrom_page.dart';
import 'package:short_readable_id/short_readable_id.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'notes_own_classroom_page.dart';




class own_classroom extends StatefulWidget {
  own_classroom(this.username,this.email);
  String email,username;
  @override
  _own_classroomState createState() => _own_classroomState(username,email);
}

class _own_classroomState extends State<own_classroom> {
  _own_classroomState(this.username,this.email);
  String email,username;

  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  String l_email="E-Class";
  var newClassroomName;
  String newClasssroomId;
  int gC;
  int C=1;

  List<Widget> classroomContainer =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async{
    try{
      final current_user = await _auth.currentUser();
      if(current_user != null){
        setState(() {
          loggedInUser = current_user;
        }
        );
       // print(loggedInUser.email);
      }
    }
    catch(e){
      print(e);
    }
  }


  void showCenterShortToast() {
    Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
  }

  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Your Classroms",style: TextStyle(color: secondaryColor),),
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: secondaryColor),
      ),
      endDrawer: menu(loggedInUser: loggedInUser,email: email,username: username, auth: _auth,colour: false,),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //Add your onPressed code here!
          showDialog(
            context: context,
            builder:(BuildContext context)=>Container(
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                content: Container(
                  height: MediaQuery.of(context).size.width * 0.4,
                  width: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("New Classroom",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                      Padding(
                        padding: const EdgeInsets.only(left:20.0,right: 20.0),
                        child: TextField(
                          onChanged: (value){
                            newClassroomName = value;
                          },
//                          autofocus: true,
                          keyboardType: TextInputType.text,
                          //textAlign: TextAlign.center,
                          decoration: InputDecoration(
//                            border: InputBorder.none,
                              hintText: 'Enter The Classroom Name'
                          ),
                        ),
//                      child: CupertinoTextField(),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      RaisedButton(
                        color: secondaryColor,
                        child: Text("Create",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),),
                        onPressed: (){
                          setState(() {
                            newClasssroomId = idGenerator.generate();
                            gC=C.remainder(15);
                            C=C+1;
                          });
                          Firestore.instance.collection('users').document(email).collection('own_class').document(newClassroomName).setData({
                            'classroom_name': newClassroomName,
                            'classroom_id': newClasssroomId,
                            'classroom_author':username,
                            'gC':gC,
                          });
                          Firestore.instance.collection('classrooms').document(newClasssroomId).setData({
                            'classroom_name':newClassroomName,
                            'classroom_author':username,
                            'gC':gC,
                            'classroom_id' : newClasssroomId,
                          });

                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );


        },
        label: Text('Create Classroom'),
        icon: Icon(Icons.add_to_queue),
        backgroundColor:secondaryColor,
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              StreamBuilder(
                  stream: Firestore.instance.collection('users').document(email).collection('own_class').snapshots(),
                  builder: (context,snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      //listItem = snapshot.data.documents;
                      List<Widget> classes_widgets = [];
                      final classes = snapshot.data.documents.reversed;
                      for(var Class in classes){
                        String classroom_name = Class.data['classroom_name'];
                        String classroom_id = Class.data['classroom_id'];
                        String classroom_author = username;
                        int gC = Class.data['gC'];
                        final classCardWidget = classroom_card_stful(gC,classroom_author,classroom_id,classroom_name,email);
                        classes_widgets.add(classCardWidget);
                      }
                      return Column(
                        children: classes_widgets,
                      );
                    }
                  }),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class classroom_card_stful extends StatefulWidget {
  classroom_card_stful(this.gC,this.classroomStaffName,this.classroomId,this.classroomName,this.email);
  final int gC;
  final String classroomId;
  final String classroomName;
  final String classroomStaffName;
  final String email;

  @override
  _classroom_card_stfulState createState() => _classroom_card_stfulState(gC,classroomStaffName,classroomId,classroomName,email);
}

class _classroom_card_stfulState extends State<classroom_card_stful> {
  _classroom_card_stfulState(this.gC,this.classroomStaffName,this.classroomId,this.classroomName,this.email);
  final int gC;
  final String classroomId;
  final String classroomName;
  final String classroomStaffName;
  final String email;
  bool noProfile = true;
  String image;

  gettingImage()async{
    await Firestore.instance.collection('classrooms').document(classroomId).get().then((value){
      setState(() {
        image = value.data['image_url'];
        if(image!=null){
          noProfile = false;
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    gettingImage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> own_notes_page(classroomId,email,classroomStaffName,gradienColor[4][0],classroomName)));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all( Radius.circular(15.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 5.0,
                  offset: Offset(0, 0),
                ),
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5.0,
                  offset: Offset(4, 4),
                ),
              ],

            ),
            child: Column(
              children: <Widget>[

                Container(
                  width: MediaQuery.of(context).size.width *0.95,
//                  height: MediaQuery.of(context).size.height *0.15,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(15.0),
//                    boxShadow:[
//                    BoxShadow(
//                    color: Colors.white38,
//                    blurRadius: 2.0,
//                      offset: Offset(-4,-4),
//                  ),
//                      BoxShadow(
//                        color: Colors.white38,
//                        blurRadius: 1.0,
//                        offset: Offset(4,4),
//
//                      ),
//                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top:20.0),
                            child: CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.07,
                              //backgroundColor: gradienColor[gC][1],
                              //backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/e-class-4abc6.appspot.com/o/EOKBZ%2F2020-05-18%2020%3A18%3A48.639337.png?alt=media&token=7b329989-909c-445a-85f5-a31339875fd1'),
                              backgroundImage: noProfile ? null :NetworkImage(image),
                              backgroundColor: Color(0xff828fe5),
                              child: noProfile?Icon(Icons.person,color: Colors.white,):null,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                          Padding(
                            padding: const EdgeInsets.only(bottom:10.0),
                            child: Text("$classroomId",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'lemonada',color: Color(0xff828fe5)),),
                          ),

                        ],
                      ),
                      SizedBox(width: 1.0,child: Container(
                        width: 1.0,
                        height: 50.0,
                        color: Colors.black,),),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Text("$classroomStaffName",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height * 0.03,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'marienda',
                                  color: Colors.black,
                                ),),
                            ),SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
//                            Text("$classroomName",style: TextStyle(fontWeight: FontWeight.bold),),
                            Padding(
                              padding: const EdgeInsets.only(bottom:8.0),
                              child: Text('$classroomName',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height * 0.02,
                                  color: Colors.black,
                                  fontFamily: 'marienda',
                                  fontWeight:FontWeight.bold,
                                ),),
                            ),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: <Widget>[
//                                Text("No,of Students"),
//                                SizedBox(
//                                  width: MediaQuery.of(context).size.width * 0.04,
//                                ),
//                                CircleAvatar(
//                                  backgroundColor: gradienColor[gC][0],
//                                  child: Text('5'),
//                                  radius: MediaQuery.of(context).size.width * 0.03,
//                                ),
//                              ],
//                            ),
                          ],
                        ),
                      ),
                      Chip(
                        backgroundColor: Colors.orange.shade200,
                        label: Text("new"),
                      ),
                    ],
                  ),
                ),
//                Container(
//                  child: Padding(
//                    padding: const EdgeInsets.all(8.0),
//                    child: Center(
//                      child: Text('$classroomName',
//                      style: TextStyle(
//                        fontSize: MediaQuery.of(context).size.height * 0.03,
//                        color: Colors.black,
//                        fontFamily: 'marienda'
//                      ),),
//                    ),
//                  ),
//                  width: MediaQuery.of(context).size.width *0.9,
//                  decoration: BoxDecoration(
//                    color: Colors.white,
////                      gradient: LinearGradient(
////                          begin: Alignment.topRight,
////                          end: Alignment.bottomLeft,
////                          colors: [gradienColor[gC][0], gradienColor[gC][1]]),
//                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.0),bottomRight: Radius.circular(25.0)),
////                    boxShadow:[
////                      BoxShadow(
////                        color: Colors.grey,
////                        blurRadius: 1.0,
////                        offset: Offset(0, 0),
////                      ), ],
//                  ),
//                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}






class classroomCard extends StatelessWidget {
  const classroomCard({
    Key key,
    @required this.gC,
    @required this.classroomName,
    @required this.classroomId,
    @required this.classroomStaffName,
    @required this.email,
  }) : super(key: key);

  final int gC;
  final String classroomId;
  final String classroomName;
  final String classroomStaffName;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => own_notes_page(classroomId,email,classroomStaffName,gradienColor[4][0],classroomName)));
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all( Radius.circular(25.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 1.0,
                    offset: Offset(0, 0),
                  ),
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    offset: Offset(4, 4),
                  ),
                ]
            ),
            child: Column(
              children: <Widget>[

                Container(
                  width: MediaQuery.of(context).size.width *0.9,
                  height: MediaQuery.of(context).size.height *0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0),topRight: Radius.circular(25.0)),
                    boxShadow:[
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 2.0,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.07,
                        backgroundColor: gradienColor[gC][1],
                        child: Text('C',style: TextStyle(color: Colors.white),),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("$classroomStaffName",
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.height * 0.03,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'marienda'
                              ),),
                            Text("$classroomId",style: TextStyle(fontWeight: FontWeight.bold),),
//                            Row(
//                              mainAxisAlignment: MainAxisAlignment.start,
//                              children: <Widget>[
//                                Text("No,of Students"),
//                                SizedBox(
//                                  width: MediaQuery.of(context).size.width * 0.04,
//                                ),
//                                CircleAvatar(
//                                  backgroundColor: gradienColor[gC][0],
//                                  child: Text('5'),
//                                  radius: MediaQuery.of(context).size.width * 0.03,
//                                ),
//                              ],
//                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Text('$classroomName',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.03,
                            color: Colors.white,
                            fontFamily: 'lemonada'
                        ),),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width *0.9,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [gradienColor[gC][0], gradienColor[gC][1]]),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25.0),bottomRight: Radius.circular(25.0)),
                    boxShadow:[
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1.0,
                        offset: Offset(0, 0),
                      ), ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class classes_card extends StatelessWidget {
  const classes_card({
    Key key,
    @required this.username,
    @required this.class_id,
    @required this.class_name,
    @required this.email,
  }) : super(key: key);

  final String username;
  final String class_name;
  final String class_id;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            GestureDetector(
              onTap: (){
//                Navigator.push(context, MaterialPageRoute(builder: (context) => own_notes_page(class_id,email,username,gradienColor[4][0],)));
              },
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color:gradienColor[4][0],
//                        gradient: LinearGradient(
//                            begin: Alignment.topLeft,
//                            end: Alignment.bottomRight,
//                            colors: [gradienColor[4][0],gradienColor[4][1]]),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.04,
                    left: MediaQuery.of(context).size.width * 0.05,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.016,
                    left: MediaQuery.of(context).size.width * 0.25,
                    child: Container(
                      decoration: BoxDecoration(
                        color:gradienColor[4][0] ,
//                          gradient: LinearGradient(
//                              begin: Alignment.topLeft,
//                              end: Alignment.bottomRight,
//                              colors: [gradienColor[4][0],gradienColor[4][1]]),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Text(
                              "$class_name",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'lemonada',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Text(
                              "$username",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'lemonada',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        )
      ],
    );
  }
}
