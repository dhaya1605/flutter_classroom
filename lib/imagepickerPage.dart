import 'package:eclass/assignment_details_pages/student_assignment_detail.dart';
import 'package:flutter/material.dart';
import 'package:eclass/screens/own_classrom_page.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';


class imagepickerPage extends StatefulWidget {
  imagepickerPage(this.image,this.classroomId,this.email);
  File image;
  String classroomId;
  String email;
  bool button = false;
  @override
  _imagepickerPageState createState() => _imagepickerPageState(image,classroomId,email);
}

class _imagepickerPageState extends State<imagepickerPage> {
  _imagepickerPageState(this.image,this.classroomId,this.email);

  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://e-class-4abc6.appspot.com/');

  StorageUploadTask _uploadTask;

  File image;
  String classroomId;
  String email;
  String imageDescription;
  int Cday;
  int Cyear;
  int Cmonth;
  String Cdate;
  String URL;
  bool descCheck = true;
  bool progress = false;
  int hour;
  int minute;
  String twelve;
  String time;
  int thour;



  void _startUpload() async{

    /// Unique file name for the file
    String filePath = '$classroomId/${DateTime.now()}.png';

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


  FinalStep(url,filepath) async{
    await Firestore.instance.collection('classrooms').document(classroomId).collection('contents').document(URL).setData({
      'sender' :email,
      'message' : imageDescription,
      'image' : filepath,
      'imagepath':url,
      'created':Cdate,
      'created utc':DateTime.now(),
      'Name':URL,
      'time':time,
    });

    setState(() {
      progress = false;
    });

    Navigator.pop(context,url);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('image'),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Stack(
          children: <Widget>[

            Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  child: Image.file(image),
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow:  [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: new ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: new Scrollbar(
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: Padding(
                          padding: const EdgeInsets.only(left:3.0,right: 3.0),
                          child: new TextField(
                            onChanged: (value){
                              setState(() {
                                imageDescription=value;
                              });

                            },
                            textAlign: TextAlign.center,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: "Type here......",
                              border: InputBorder.none,
                              errorText: descCheck?null :"Enter the note"
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text("cancel"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    FlatButton(
                      onPressed: (){
                        if(imageDescription==null){
                          setState(() {
                            descCheck = false;
                          });
                        }
                        else {
                          setState(() {
                            progress = true;
                          });
                          Cday = DateTime.now().day;
                          Cmonth = DateTime.now().month;
                          Cyear = DateTime.now().year;
                          Cdate = "$Cday-$Cmonth-$Cyear";
                          hour = DateTime.now().hour;
                          minute = DateTime.now().minute;
                          twelve = hour>12 ? "pm":"am";
                          thour = hour>12 ? hour-12 : hour;
                          time = "$thour:$minute $twelve";
                          _startUpload();
                        }
                      },
                      child: Text("upload"),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height *0.4,
              left: MediaQuery.of(context).size.width * 0.46,
              child: Container(
                child: progress? CircularProgressIndicator(strokeWidth: 5,):null,
              ),
            ),
          ],

        ),
      ),
    );
  }
}


class videopickerpage extends StatefulWidget {
  videopickerpage(this.image,this.classroomId,this.email);
  File image;
  String classroomId;
  String email;
  bool button = false;
  @override
  _videopickerpageState createState() => _videopickerpageState(image,classroomId,email);
}

class _videopickerpageState extends State<videopickerpage> {
  _videopickerpageState(this.image,this.classroomId,this.email);
  File image;
  String classroomId;
  String email;
  bool button = false;
  String videoDescription;
  String videoTitle;
  int Cday;
  int Cyear;
  int Cmonth;
  String Cdate;
  String URL;
  bool titlecheck = true;
  bool descCheck = true;
  bool progress = false;
  int hour;
  int minute;
  String twelve;
  String time;
  int thour;



  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://e-class-4abc6.appspot.com/');

  StorageUploadTask _uploadTask;

  void _startUpload(videoTitle,videoDescription) async{
    setState(() {
      progress = true;
    });

    /// Unique file name for the file
    String filePath = '$classroomId/${DateTime.now()}.png';

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
      FinalStep(downloadUrl,filePath,videoTitle,videoDescription);
    }


  }


  FinalStep(url,filepath,videoTitle,videoDescription) async{
    await Firestore.instance.collection('classrooms').document(classroomId).collection('contents').document(URL).setData({
      'sender' :email,
      'message' : "new message",
      'video' : filepath,
      'videopath':url,
      'videoTitle':videoTitle,
      'videoDescription':videoDescription,
      'created':Cdate,
      'created utc':DateTime.now(),
      'Name':URL,
      'time':time,
    });

    setState(() {
      progress = false;
    });

    Navigator.pop(context,url);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: MediaQuery.of(context).size.height *0.4,
                left: MediaQuery.of(context).size.width * 0.46,
                child: Container(
                  child: progress? CircularProgressIndicator(strokeWidth: 5,):null,
                ),
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Container(
                    child: Icon(Icons.play_circle_outline,
                      size: MediaQuery.of(context).size.height * 0.2,),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width *0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow:  [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: new ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.1,
                      ),
                      child: new Scrollbar(
                        child: new SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          reverse: true,
                          child: Padding(
                            padding: const EdgeInsets.only(left:3.0,right: 3.0),
                            child: new TextField(
                              onChanged: (value){
                                setState(() {
                                  videoTitle=value;
                                });

                              },
                              textAlign: TextAlign.center,
                              maxLines: null,
                              decoration: InputDecoration(
                                  hintText: "Video Title",
                                  border: InputBorder.none,
                                  errorText: titlecheck?null:"Enter the title"
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width *0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow:  [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: new ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.1,
                      ),
                      child: new Scrollbar(
                        child: new SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          reverse: true,
                          child: Padding(
                            padding: const EdgeInsets.only(left:3.0,right: 3.0),
                            child: new TextField(
                              onChanged: (value){
                                setState(() {
                                  videoDescription=value;
                                });
                              },
                              textAlign: TextAlign.center,
                              maxLines: null,
                              decoration: InputDecoration(
                                  hintText: "Video Description",
                                  border: InputBorder.none,
                                  errorText: descCheck?null:"Enter the Description"
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text("cancel"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.1,
                      ),
                      FlatButton(
                        onPressed: (){
                          if(videoTitle == null && videoDescription == null){
                            setState(() {
                              titlecheck = false;
                              descCheck = false;
                            });
                          }
                          else if (videoTitle != null && videoDescription == null){
                            setState(() {
                              titlecheck = true;
                              descCheck = false;
                            });
                          }
                          else if (videoTitle == null && videoDescription != null){
                            setState(() {
                              titlecheck = false;
                              descCheck = true;
                            });
                          }
                          else{
                            setState(() {
                              titlecheck = true;
                              descCheck = true;
                            });
                            Cday = DateTime.now().day;
                            Cmonth = DateTime.now().month;
                            Cyear = DateTime.now().year;
                            Cdate = "$Cday-$Cmonth-$Cyear";
                            hour = DateTime.now().hour;
                            minute = DateTime.now().minute;
                            twelve = hour>12 ? "pm":"am";
                            thour = hour>12 ? hour-12 : hour;
                            time = "$thour:$minute $twelve";
                            _startUpload(videoTitle,videoDescription);}
                        },
                        child: Text("upload"),
                      ),
                    ],
                  ),
                ],
              ),
            ],

          ),
        ),
      ),
    );
  }
}


class documentPicker extends StatefulWidget {
  documentPicker(this.doc,this.classroomId,this.email);
  File doc;
  String classroomId;
  String email;

  @override
  _documentPickerState createState() => _documentPickerState(doc,classroomId,email);
}

class _documentPickerState extends State<documentPicker> {
  _documentPickerState(this.doc,this.classroomId,this.email);
  File doc;
  String classroomId;
  String email;
  String documentTitle;
  String documentDescription;
  int Cday;
  int Cyear;
  int Cmonth;
  String Cdate;
  String URL;
  bool titlecheck = true;
  bool descCheck = true;
  bool progress = false;
  int hour;
  int minute;
  String twelve;
  String time;
  int thour;
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://e-class-4abc6.appspot.com/');

  StorageUploadTask _uploadTask;

  void _startUpload(documentTitle,documentDescription) async{

    /// Unique file name for the file
    String filePath = '$classroomId/${DateTime.now()}.png';

    var ref = FirebaseStorage.instance.ref().child(filePath);

    setState((){
      _uploadTask = ref.putFile(doc);
    });

    var storageTaskSnapshot = await _uploadTask.onComplete;

    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

    setState(() {
      URL = "${DateTime.now()}+$email";
    });

    if(downloadUrl!=null) {
      FinalStep(downloadUrl,filePath,documentTitle,documentDescription);
    }


  }


  FinalStep(url,filepath,docTitle,docDescription) async{
    await Firestore.instance.collection('classrooms').document(classroomId).collection('contents').document(URL).setData({
      'sender' :email,
      'message' : "new message",
      'doc' : filepath,
      'docopath':url,
      'documentTitle':docTitle,
      'documentDescription':docDescription,
      'created':Cdate,
      'created utc':DateTime.now(),
      'Name':URL,
      'time':time,
    });
    setState(() {
      progress = false;
    });

    Navigator.pop(context,url);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  child: Icon(Icons.description,
                    size: MediaQuery.of(context).size.height * 0.2,),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  width: MediaQuery.of(context).size.width *0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow:  [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: new ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: new Scrollbar(
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: Padding(
                          padding: const EdgeInsets.only(left:3.0,right: 3.0),
                          child: new TextField(
                            onChanged: (value){
                              setState(() {
                                documentTitle=value;
                              });

                            },
                            textAlign: TextAlign.center,
                            maxLines: null,
                            decoration: InputDecoration(
                                hintText: "Document Title",
                                border: InputBorder.none,
                                errorText: titlecheck?null:"Enter the title"
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  width: MediaQuery.of(context).size.width *0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow:  [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: new ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: new Scrollbar(
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: Padding(
                          padding: const EdgeInsets.only(left:3.0,right: 3.0),
                          child: new TextField(
                            onChanged: (value){
                              setState(() {
                                documentDescription=value;
                              });

                            },
                            textAlign: TextAlign.center,
                            maxLines: null,
                            decoration: InputDecoration(
                                hintText: "Document Description",
                                border: InputBorder.none,
                                errorText: descCheck?null:"Enter the description"
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text("cancel"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    FlatButton(
                      onPressed: (){
                        if(documentTitle == null && documentDescription == null){
                          setState(() {
                            titlecheck = false;
                            descCheck=false;
                          });
                        }
                        else if(documentTitle != null && documentDescription == null){
                          setState(() {
                            titlecheck = true;
                            descCheck=false;
                          });
                        }
                        else if(documentTitle == null && documentDescription != null){
                          setState(() {
                            titlecheck = false;
                            descCheck=true;
                          });
                        }
                        else{
                          setState(() {
                            titlecheck = true;
                            descCheck=true;
                            progress = true;
                          });

                          Cday = DateTime.now().day;
                          Cmonth = DateTime.now().month;
                          Cyear = DateTime.now().year;
                          Cdate = "$Cday-$Cmonth-$Cyear";
                          hour = DateTime.now().hour;
                          minute = DateTime.now().minute;
                          twelve = hour>12 ? "pm":"am";
                          thour = hour>12 ? hour-12 : hour;
                          time = "$thour:$minute $twelve";
                          _startUpload(documentTitle,documentDescription);}
                      },
                      child: Text("upload"),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
        bottom: MediaQuery.of(context).size.height *0.4,
        left: MediaQuery.of(context).size.width * 0.46,
        child: Container(
          child: progress? CircularProgressIndicator(strokeWidth: 5,):null,
        ),
      ),],
        ),
      ),
    );
  }
}




class quiz_documentPicker extends StatefulWidget {
  quiz_documentPicker(this.doc,this.classroomId,this.email,this.assignmentTitle);
  File doc;
  String classroomId;
  String email;
  String assignmentTitle;
  @override
  _quiz_documentPickerState createState() => _quiz_documentPickerState(doc,classroomId,email,assignmentTitle);
}

class _quiz_documentPickerState extends State<quiz_documentPicker> {
  _quiz_documentPickerState(this.doc,this.classroomId,this.email,this.assignmentTitle);
  File doc;
  String classroomId;
  String email;
  String documentTitle;
  String documentDescription;
  String assignmentTitle;
  bool uploadHandler = false;
  bool uploadHandlerdes = false;

  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://e-class-4abc6.appspot.com/');

  StorageUploadTask _uploadTask;

  void _startUpload(documentTitle,documentDescription) async{

    /// Unique file name for the file
    String filePath = '$classroomId/${DateTime.now()}.png';

    var ref = FirebaseStorage.instance.ref().child(filePath);

    setState((){
      _uploadTask = ref.putFile(doc);
    });

    var storageTaskSnapshot = await _uploadTask.onComplete;

    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

    if(downloadUrl!=null) {
      FinalStep(downloadUrl,filePath,documentTitle,documentDescription);
    }


  }


  FinalStep(url,filepath,docTitle,docDescription) async{
    await Firestore.instance.collection('classrooms').document(classroomId).collection('assignments').document(assignmentTitle).collection('attachments').document().setData({
      'sender' :email,
      'message' : "new message",
      'doc' : filepath,
      'docopath':url,
      'documentTitle':docTitle,
      'documentDescription':docDescription,
    });

    Navigator.pop(context,url);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document'),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              child: Icon(Icons.description,
                size: MediaQuery.of(context).size.height * 0.2,),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              width: MediaQuery.of(context).size.width *0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow:  [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: new ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.1,
                ),
                child: new Scrollbar(
                  child: new SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    child: Padding(
                      padding: const EdgeInsets.only(left:3.0,right: 3.0),
                      child: new TextField(
                        onChanged: (value){
                          setState(() {
                            documentTitle=value;
                          });

                        },
                        textAlign: TextAlign.center,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "Document Title",
                          errorText: uploadHandler?"enter the title":null
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Container(
              width: MediaQuery.of(context).size.width *0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow:  [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: new ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.1,
                ),
                child: new Scrollbar(
                  child: new SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    child: Padding(
                      padding: const EdgeInsets.only(left:3.0,right: 3.0),
                      child: new TextField(
                        onChanged: (value){
                          setState(() {
                            documentDescription=value;
                          });

                        },
                        textAlign: TextAlign.center,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "Document Description",
                          errorText: uploadHandlerdes ? "enter the description": null,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("cancel"),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                FlatButton(
                  onPressed: (){
                    if(documentTitle != null && documentDescription!=null) {
                      _startUpload(documentTitle, documentDescription);
                    }
                    else if(documentTitle != null && documentDescription==null){
                      setState(() {
                        uploadHandler=false;
                        uploadHandlerdes= true;
                      });

                    }
                    else if(documentTitle == null && documentDescription!=null){
                      setState(() {
                        uploadHandlerdes=false;
                        uploadHandler= true;
                      });

                    }
                    else{
                      setState(() {
                        uploadHandlerdes= true;
                        uploadHandler= true;
                      });

                    }
                  },
                  child: Text("upload"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class quiz_imagePicker extends StatefulWidget {
  quiz_imagePicker(this.image,this.classroomId,this.email,this.assignmentTitle);
  File image;
  String classroomId;
  String email;
  String assignmentTitle;
  @override
  _quiz_imagePickerState createState() => _quiz_imagePickerState(image,classroomId,email,assignmentTitle);
}

class _quiz_imagePickerState extends State<quiz_imagePicker> {
  _quiz_imagePickerState(this.image,this.classroomId,this.email,this.assignmentTitle);
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://e-class-4abc6.appspot.com/');

  StorageUploadTask _uploadTask;

  File image;
  String classroomId;
  String email;
  String imageDescription;
  String assignmentTitle;
  bool uploadHandler=false;


  void _startUpload() async{

    /// Unique file name for the file
    String filePath = '$classroomId/${DateTime.now()}.png';

    var ref = FirebaseStorage.instance.ref().child(filePath);

    setState((){
      _uploadTask = ref.putFile(image);
    });

    var storageTaskSnapshot = await _uploadTask.onComplete;

    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

    if(downloadUrl!=null) {
      FinalStep(downloadUrl,filePath);
    }


  }


  FinalStep(url,filepath) async{
    await Firestore.instance.collection('classrooms').document(classroomId).collection('assignments').document(assignmentTitle).collection('attachments').document().setData({
      'sender' :email,
      'message' : imageDescription,
      'image' : filepath,
      'imagepath':url,
    });

    Navigator.pop(context,url);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('image'),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              child: Image.file(image),
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow:  [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: new ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.1,
                ),
                child: new Scrollbar(
                  child: new SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    reverse: true,
                    child: Padding(
                      padding: const EdgeInsets.only(left:3.0,right: 3.0),
                      child: new TextField(
                        onChanged: (value){
                          setState(() {
                            imageDescription=value;
                          });

                        },
                        textAlign: TextAlign.center,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "Pic Title",

                          errorText: uploadHandler? "enter the title":null
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("cancel"),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                FlatButton(
                  onPressed: (){
                    if(imageDescription!=null){
                    _startUpload();}
                    else{
                      setState(() {
                        uploadHandler=true;
                      });

                    }
                  },
                  child: Text("upload"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class announcement_image_picker extends StatefulWidget {
  announcement_image_picker(this.image,this.classroomId,this.email);
  File image;
  String classroomId;
  String email;
  @override
  _announcement_image_pickerState createState() => _announcement_image_pickerState(image,classroomId,email);
}

class _announcement_image_pickerState extends State<announcement_image_picker> {
  _announcement_image_pickerState(this.image,this.classroomId,this.email);
  File image;
  String classroomId;
  String email;
  String imageDescription;
  int Cday;
  int Cyear;
  int Cmonth;
  String Cdate;
  String URL;
  bool descCheck = true;
  bool progress = false;
  int hour;
  int minute;
  String twelve;
  String time;
  int thour;

  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://e-class-4abc6.appspot.com/');

  StorageUploadTask _uploadTask;

  void _startUpload() async{

    /// Unique file name for the file
    String filePath = '$classroomId/${DateTime.now()}.png';

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


  FinalStep(url,filepath) async{
    await Firestore.instance.collection('classrooms').document(classroomId).collection('contents').document(URL).setData({
      'sender' :email,
      'message' : imageDescription,
      'Aimage' : filepath,
      'Aimagepath':url,
      'created':Cdate,
      'created utc':DateTime.now(),
      'Name':URL,
      'time':time,
    });

    setState(() {
      progress = false;
    });

    Navigator.pop(context,url);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('image'),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Stack(
          children: <Widget>[

            Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  child: Image.file(image),
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow:  [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: new ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: new Scrollbar(
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: Padding(
                          padding: const EdgeInsets.only(left:3.0,right: 3.0),
                          child: new TextField(
                            onChanged: (value){
                              setState(() {
                                imageDescription=value;
                              });

                            },
                            textAlign: TextAlign.center,
                            maxLines: null,
                            decoration: InputDecoration(
                                hintText: "Type here......",
                                border: InputBorder.none,
                                errorText: descCheck?null :"Enter the note"
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text("cancel"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    FlatButton(
                      onPressed: (){
                        if(imageDescription==null){
                          setState(() {
                            descCheck = false;
                          });
                        }
                        else {
                          setState(() {
                            progress = true;
                          });
                          Cday = DateTime.now().day;
                          Cmonth = DateTime.now().month;
                          Cyear = DateTime.now().year;
                          Cdate = "$Cday-$Cmonth-$Cyear";
                          hour = DateTime.now().hour;
                          minute = DateTime.now().minute;
                          twelve = hour>12 ? "pm":"am";
                          thour = hour>12 ? hour-12 : hour;
                          time = "$thour:$minute $twelve";
                          _startUpload();
                        }
                      },
                      child: Text("upload"),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height *0.4,
              left: MediaQuery.of(context).size.width * 0.46,
              child: Container(
                child: progress? CircularProgressIndicator(strokeWidth: 5,):null,
              ),
            ),
          ],

        ),
      ),
    );
  }
}





class submission_image_picker extends StatefulWidget {
  submission_image_picker(this.image,this.classroomId,this.email,this.assignmentTitle);
  File image;
  String classroomId;
  String email;
  String assignmentTitle;
  @override
  _submission_image_pickerState createState() => _submission_image_pickerState(image,classroomId,email,assignmentTitle);
}

class _submission_image_pickerState extends State<submission_image_picker> {
  _submission_image_pickerState(this.image,this.classroomId,this.email,this.assignmentTitle);
  File image;
  String classroomId;
  String email;
  String assignmentTitle;
  StorageUploadTask _uploadTask;
  bool progress = false;

  void _startUpload() async{

    /// Unique file name for the file
    String filePath = '$classroomId/${DateTime.now()}.png';

    var ref = FirebaseStorage.instance.ref().child(filePath);

    setState((){
      _uploadTask = ref.putFile(image);
    });

    var storageTaskSnapshot = await _uploadTask.onComplete;

    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

    if(downloadUrl!=null) {
      FinalStep(downloadUrl,filePath);
    }


  }


  FinalStep(url,filepath) async{
    await Firestore.instance.collection('classrooms').document(classroomId).collection('assignments').document(assignmentTitle).collection('submissions').document(email).collection("attachments").document().setData({
      'sender' :email,
      'image' : filepath,
      'imagepath':url,
    });

    setState(() {
      progress = false;
    });

    Navigator.pop(context,url);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('image'),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  child: Image.file(image),
                  height: MediaQuery.of(context).size.height * 0.5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
//            Container(
//              width: MediaQuery.of(context).size.width * 0.8,
//              decoration: BoxDecoration(
//                color: Colors.white,
//                borderRadius: BorderRadius.circular(10.0),
//                boxShadow:  [
//                  BoxShadow(
//                    color: Colors.black12,
//                    blurRadius: 10.0,
//                    offset: Offset(0, 2),
//                  ),
//                ],
//              ),
//              child: new ConstrainedBox(
//                constraints: BoxConstraints(
//                  maxHeight: MediaQuery.of(context).size.height * 0.1,
//                ),
//                child: new Scrollbar(
//                  child: new SingleChildScrollView(
//                    scrollDirection: Axis.vertical,
//                    reverse: true,
//                    child: Padding(
//                      padding: const EdgeInsets.only(left:3.0,right: 3.0),
//                      child: new TextField(
//                        onChanged: (value){
//                          setState(() {
//                            imageDescription=value;
//                          });
//
//                        },
//                        textAlign: TextAlign.center,
//                        maxLines: null,
//                        decoration: InputDecoration(
//                            hintText: "Pic Title",
//
//                            errorText: uploadHandler? "enter the title":null
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text("cancel"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    FlatButton(
                      onPressed: (){
                        setState(() {
                          progress = true;
                        });
                        _startUpload();
                      },
                      child: Text("upload"),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.4,
              left: MediaQuery.of(context).size.width * 0.45,
              child:Container(
                child: progress? CircularProgressIndicator(strokeWidth: 5,):null,
              ) ,
            ),
          ],

        ),
      ),
    );
  }
}




class submission_document_picker extends StatefulWidget {
  submission_document_picker(this.doc,this.classroomId,this.email,this.ATitle);
  File doc;
  String classroomId;
  String email;
  String ATitle;
  @override
  _submission_document_pickerState createState() => _submission_document_pickerState(doc,classroomId,email,ATitle);
}

class _submission_document_pickerState extends State<submission_document_picker> {
  _submission_document_pickerState(this.doc,this.classroomId,this.email,this.assignmentTitle);
  File doc;
  String classroomId;
  String email;
  String documentTitle;
  String documentDescription;
  int Cday;
  int Cyear;
  int Cmonth;
  String Cdate;
  String URL;
  bool titlecheck = true;
  bool descCheck = true;
  bool progress = false;
  int hour;
  int minute;
  String twelve;
  String time;
  int thour;
  String assignmentTitle;
  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://e-class-4abc6.appspot.com/');

  StorageUploadTask _uploadTask;

  void _startUpload(documentTitle) async{

    /// Unique file name for the file
    String filePath = '$classroomId/${DateTime.now()}.png';

    var ref = FirebaseStorage.instance.ref().child(filePath);

    setState((){
      _uploadTask = ref.putFile(doc);
    });

    var storageTaskSnapshot = await _uploadTask.onComplete;

    var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

    setState(() {
      URL = "${DateTime.now()}+$email";
    });

    if(downloadUrl!=null) {
      FinalStep(downloadUrl,filePath,documentTitle);
    }


  }


  FinalStep(url,filepath,docTitle) async{
    await Firestore.instance.collection('classrooms').document(classroomId).collection('assignments').document(assignmentTitle).collection('submissions').document(email).collection("attachments").document().setData({
      'sender' :email,
      'message' : "new message",
      'doc' : filepath,
      'docopath':url,
      'documentTitle':docTitle,
      'created':Cdate,
      'created utc':DateTime.now(),
      'Name':URL,
      'time':time,
    });
    setState(() {
      progress = false;
    });

    Navigator.pop(context,url);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  child: Icon(Icons.description,
                    size: MediaQuery.of(context).size.height * 0.2,),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Container(
                  width: MediaQuery.of(context).size.width *0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow:  [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: new ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.1,
                    ),
                    child: new Scrollbar(
                      child: new SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        reverse: true,
                        child: Padding(
                          padding: const EdgeInsets.only(left:3.0,right: 3.0),
                          child: new TextField(
                            onChanged: (value){
                              setState(() {
                                documentTitle=value;
                              });

                            },
                            textAlign: TextAlign.center,
                            maxLines: null,
                            decoration: InputDecoration(
                                hintText: "Document Title",
                                border: InputBorder.none,
                                errorText: titlecheck?null:"Enter the title"
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
//                SizedBox(
//                  height: MediaQuery.of(context).size.height * 0.1,
//                ),
//                Container(
//                  width: MediaQuery.of(context).size.width *0.8,
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.circular(10.0),
//                    boxShadow:  [
//                      BoxShadow(
//                        color: Colors.black12,
//                        blurRadius: 10.0,
//                        offset: Offset(0, 2),
//                      ),
//                    ],
//                  ),
//                  child: new ConstrainedBox(
//                    constraints: BoxConstraints(
//                      maxHeight: MediaQuery.of(context).size.height * 0.1,
//                    ),
//                    child: new Scrollbar(
//                      child: new SingleChildScrollView(
//                        scrollDirection: Axis.vertical,
//                        reverse: true,
//                        child: Padding(
//                          padding: const EdgeInsets.only(left:3.0,right: 3.0),
//                          child: new TextField(
//                            onChanged: (value){
//                              setState(() {
//                                documentDescription=value;
//                              });
//
//                            },
//                            textAlign: TextAlign.center,
//                            maxLines: null,
//                            decoration: InputDecoration(
//                                hintText: "Document Description",
//                                border: InputBorder.none,
//                                errorText: descCheck?null:"Enter the description"
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text("cancel"),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    FlatButton(
                      onPressed: (){
                        if(documentTitle == null){
                          setState(() {
                            titlecheck = false;
                          });
                        }

                        else{
                          setState(() {
                            titlecheck = true;
                            progress = true;
                          });

                          Cday = DateTime.now().day;
                          Cmonth = DateTime.now().month;
                          Cyear = DateTime.now().year;
                          Cdate = "$Cday-$Cmonth-$Cyear";
                          hour = DateTime.now().hour;
                          minute = DateTime.now().minute;
                          twelve = hour>12 ? "pm":"am";
                          thour = hour>12 ? hour-12 : hour;
                          time = "$thour:$minute $twelve";
                          _startUpload(documentTitle);}
                      },
                      child: Text("upload"),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height *0.4,
              left: MediaQuery.of(context).size.width * 0.46,
              child: Container(
                child: progress? CircularProgressIndicator(strokeWidth: 5,):null,
              ),
            ),],
        ),
      ),
    );
  }
}
