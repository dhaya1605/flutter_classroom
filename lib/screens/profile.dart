import 'package:eclass/screens/classrom_page.dart';
import 'package:flutter/material.dart';

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';





class info extends StatefulWidget {
  info(this.email);
  String email;
  @override
  _infoState createState() => _infoState(email);
}

class _infoState extends State<info> {
  _infoState(this.email);
  String email;
  String image="";
  String own="";
  String name="";
  String joined="";
  bool noProfile = true;
  File _imageFile;
  StorageUploadTask _uploadTask;
  String URL;
  @override
  void initState() {
    // TODO: implement initState
    datagetter();
    super.initState();
  }

  datagetter()async{
    QuerySnapshot own_document = await Firestore.instance.collection('users').document(email).collection('joined_class').getDocuments();
    setState(() {
      own = own_document.documents.length.toString();
    });


    QuerySnapshot joined_document = await Firestore.instance.collection('users').document(email).collection('own_class').getDocuments();
    setState(() {
      joined = joined_document.documents.length.toString();
    });

    await Firestore.instance.collection('users').document(email).get().then((value){
      setState(() {
        name = value.data['username'];
        image = value.data['image_url'];
      });
      if(image == null){
        setState(() {
          noProfile  = true;
        });
      }
      else{
        setState(() {
          noProfile  = false;
        });
      }
    });

  }


  Future<void> _pickImage(ImageSource source) async{
    File selectedImage =await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile =selectedImage;
    });
    if(_imageFile !=null){
      //_imagePageNavigation(context);
      _startUpload(_imageFile);
    }
  }

  void _startUpload(image) async{

    /// Unique file name for the file
    String filePath = '$email/${DateTime.now()}.png';

    var ref = FirebaseStorage.instance.ref().child(filePath);

    setState((){
      _uploadTask = ref.putFile(image);
    });

    var storageTaskSnapshot = await _uploadTask.onComplete;

    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

    setState(() {
      URL = "${DateTime.now()}+$email";
    });

    if(downloadUrl!=null) {
     FinalStep(downloadUrl,filePath);
    }


  }

  FinalStep(downloadUrl,filePath)async{
    await Firestore.instance.collection('users').document(email).updateData({
      'image_url' : downloadUrl,
    });
   // await Firestore.instance.collection('users').document().collection('joined_class').where('classroom_author',isEqualTo: )
    setState(() {
      image = downloadUrl;
    });
    Fluttertoast.showToast(
      msg: "Changed successfully",
      backgroundColor: Colors
          .teal,
      textColor: Colors.white,
      fontSize: MediaQuery.of(context)
          .size
          .height *
          0.03,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    showDialog(context: context, builder: (BuildContext context) => Scaffold(
                      appBar: AppBar(
                        title: Text("Image",),
                        backgroundColor: Colors.black,
                      ),
                      backgroundColor: Colors.black,
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: noProfile ? Container(
                              color:Colors.white,
                              child: Icon(Icons.person,size: MediaQuery.of(context).size.height * 0.3,),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.5,
                            ):
                            Container(
                              child: Image.network(image),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.5,
                            )
                          ),
                          RaisedButton(
                            child: Text("Edit Profile Picture",style: TextStyle(color: Colors.black),),
                            onPressed: (){
                              showModalBottomSheet(context: context, builder: (BuildContext context){
                                return Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      child: ListTile(
                                        title: Text("Pick from gallery"),
                                        leading: Icon(Icons.image),
                                        onTap: (){
                                          _pickImage(ImageSource.gallery);
                                        },
                                      ),
                                    ),
                                    GestureDetector(
                                      child: ListTile(
                                        title: Text("Pick from camera"),
                                        leading: Icon(Icons.camera),
                                        onTap: (){
                                          _pickImage(ImageSource.camera);
                                        },
                                      ),
                                    )
                                  ],
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ));
                    //print('image');
                  },
                  child: CircleAvatar(
                    radius: 70.0,
                    backgroundImage: noProfile ? AssetImage('images/login.jpg'):NetworkImage(image),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                Text(
                  "$name",
                  style: TextStyle(
                    fontSize: 35.0,
                    fontFamily: 'Marienda',
                    color: Colors.teal,
                  ),
                ),
                SizedBox(
                  width: 300.0,
                  height: 30.0,
                  child: Divider(
                    thickness: 1.0,
                    color: Colors.teal,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListTile(
                    subtitle: Center(child: Text("E-mail Id",style: TextStyle(fontSize: 15.0,),)),
                    title: Center(child: Text("$email",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListTile(
                    subtitle: Center(child: Text("No.of Own Classrooms",style: TextStyle(fontSize: 15.0,),)),
                    title: Center(child: Text("$own",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListTile(
                    subtitle: Center(child: Text("No.of Joined Classrooms",style: TextStyle(fontSize: 15.0,),)),
                    title: Center(child: Text("$joined",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}



class classroomInfo extends StatefulWidget {
  classroomInfo(this.classroomId);
  String classroomId;
  @override
  _classroomInfoState createState() => _classroomInfoState(classroomId);
}

class _classroomInfoState extends State<classroomInfo> {
  _classroomInfoState(this.classroomId);
  String classroomId;
  String email;
  String image="";
  String className="";
  String staffName="";
  String joined="";
  bool noProfile = true;
  File _imageFile;
  StorageUploadTask _uploadTask;
  String URL;
  @override
  void initState() {
    // TODO: implement initState
    datagetter();
    super.initState();
  }

  datagetter()async{

    QuerySnapshot joined_document = await Firestore.instance.collection('classrooms').document(classroomId).collection('joined_students').getDocuments();
    setState(() {
      joined = joined_document.documents.length.toString();
    });

    await Firestore.instance.collection('classrooms').document(classroomId).get().then((value){
      setState(() {
        //name = value.data['username'];
        image = value.data['image_url'];
        className = value.data['classroom_name'];
        staffName = value.data['classroom_author'];
      });
      if(image == null){
        setState(() {
          noProfile  = true;
        });
      }
      else{
        setState(() {
          noProfile  = false;
        });
      }
    });

  }


  Future<void> _pickImage(ImageSource source) async{
    File selectedImage =await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile =selectedImage;
    });
    if(_imageFile !=null){
      //_imagePageNavigation(context);
      _startUpload(_imageFile);
    }
  }

  void _startUpload(image) async{

    /// Unique file name for the file
    String filePath = '$classroomId/${DateTime.now()}.png';

    var ref = FirebaseStorage.instance.ref().child(filePath);

    setState((){
      _uploadTask = ref.putFile(image);
    });

    var storageTaskSnapshot = await _uploadTask.onComplete;

    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

    setState(() {
      URL = "${DateTime.now()}+$classroomId";
    });

    if(downloadUrl!=null) {
      FinalStep(downloadUrl,filePath);
    }


  }

  FinalStep(downloadUrl,filePath)async{
    await Firestore.instance.collection('classrooms').document(classroomId).updateData({
      'image_url' : downloadUrl,
    });
    setState(() {
      image = downloadUrl;
    });
    Fluttertoast.showToast(
      msg: "Changed successfully",
      backgroundColor: Colors
          .teal,
      textColor: Colors.white,
      fontSize: MediaQuery.of(context)
          .size
          .height *
          0.03,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                    showDialog(context: context, builder: (BuildContext context) => Scaffold(
                      appBar: AppBar(
                        title: Text("Image",),
                        backgroundColor: Colors.black,
                      ),
                      backgroundColor: Colors.black,
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                              child: noProfile ? Container(
                                color:Colors.white,
                                child: Icon(Icons.person,size: MediaQuery.of(context).size.height * 0.3,),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.5,
                              ):
                              Container(
                                child: Image.network(image),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 0.5,
                              )
                          ),
                          RaisedButton(
                            child: Text("Edit Classroom Picture",style: TextStyle(color: Colors.black),),
                            onPressed: (){
                              showModalBottomSheet(context: context, builder: (BuildContext context){
                                return Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      child: ListTile(
                                        title: Text("Pick from gallery"),
                                        leading: Icon(Icons.image),
                                        onTap: (){
                                          _pickImage(ImageSource.gallery);
                                        },
                                      ),
                                    ),
                                    GestureDetector(
                                      child: ListTile(
                                        title: Text("Pick from camera"),
                                        leading: Icon(Icons.camera),
                                        onTap: (){
                                          _pickImage(ImageSource.camera);
                                        },
                                      ),
                                    )
                                  ],
                                );
                              });
                            },
                          ),
                        ],
                      ),
                    ));
                    //print('image');
                  },
                  child: CircleAvatar(
                    radius: 70.0,
                    backgroundImage: noProfile ? AssetImage('images/login.jpg'):NetworkImage(image),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                Text(
                  "$className",
                  style: TextStyle(
                    fontSize: 35.0,
                    fontFamily: 'Marienda',
                    color: Colors.teal,
                  ),
                ),
                SizedBox(
                  width: 300.0,
                  height: 30.0,
                  child: Divider(
                    thickness: 1.0,
                    color: Colors.teal,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListTile(
                    subtitle: Center(child: Text("Staff Name",style: TextStyle(fontSize: 15.0,),)),
                    title: Center(child: Text("$staffName",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListTile(
                    subtitle: Center(child: Text("Classroom Id",style: TextStyle(fontSize: 15.0,),)),
                    title: Center(child: Text("$classroomId",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListTile(
                    subtitle: Center(child: Text("No.of Students",style: TextStyle(fontSize: 15.0,),)),
                    title: Center(child: Text("$joined",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)),
                  ),
                ),

              ],
            ),
          )),
    );
  }
}



class student_classroom_info extends StatefulWidget {
  student_classroom_info(this.classroomId);
  String classroomId;
  @override
  _student_classroom_infoState createState() => _student_classroom_infoState(classroomId);
}

class _student_classroom_infoState extends State<student_classroom_info> {
  _student_classroom_infoState(this.classroomId);
  String classroomId;
  String email;
  String image="";
  String className="";
  String staffName="";
  String joined="";
  bool noProfile = true;
  File _imageFile;
  StorageUploadTask _uploadTask;
  String URL;
  @override
  void initState() {
    // TODO: implement initState
    datagetter();
    super.initState();
  }

  datagetter()async{

    QuerySnapshot joined_document = await Firestore.instance.collection('classrooms').document(classroomId).collection('joined_students').getDocuments();
    setState(() {
      joined = joined_document.documents.length.toString();
    });

    await Firestore.instance.collection('classrooms').document(classroomId).get().then((value){
      setState(() {
        //name = value.data['username'];
        image = value.data['image_url'];
        className = value.data['classroom_name'];
        staffName = value.data['classroom_author'];
      });
      if(image == null){
        setState(() {
          noProfile  = true;
        });
      }
      else{
        setState(() {
          noProfile  = false;
        });
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 70.0,
                  backgroundImage: noProfile ? AssetImage('images/login.jpg'):NetworkImage(image),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                Text(
                  "$className",
                  style: TextStyle(
                    fontSize: 35.0,
                    fontFamily: 'Marienda',
                    color: Colors.teal,
                  ),
                ),
                SizedBox(
                  width: 300.0,
                  height: 30.0,
                  child: Divider(
                    thickness: 1.0,
                    color: Colors.teal,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListTile(
                    subtitle: Center(child: Text("Staff Name",style: TextStyle(fontSize: 15.0,),)),
                    title: Center(child: Text("$staffName",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListTile(
                    subtitle: Center(child: Text("Classroom Id",style: TextStyle(fontSize: 15.0,),)),
                    title: Center(child: Text("$classroomId",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: ListTile(
                    subtitle: Center(child: Text("No.of Students",style: TextStyle(fontSize: 15.0,),)),
                    title: Center(child: Text("$joined",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),)),
                  ),
                ),

              ],
            ),
          )),
    );
  }
}

