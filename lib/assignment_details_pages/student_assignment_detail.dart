import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:eclass/imagepickerPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class submission_imageCard extends StatelessWidget {
  submission_imageCard(
      this.image, this.classroomid, this.imagepath, this.assignmentTitle);
  String image;
  String classroomid;
  String imagepath;
  String assignmentTitle;
  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return Container();
    } else {
      return Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
//                height: MediaQuery.of(context).size.height * 0.4,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => Scaffold(
                                appBar: AppBar(
                                  title: Text(
                                    "Image",
                                  ),
                                  backgroundColor: Colors.black,
                                ),
                                backgroundColor: Colors.black,
                                body: Center(
                                  child: imageViewer(image),
                                ),
                              ));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Image.network(
                        image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.image),
                    ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
        ],
      );
    }
  }
}

class submission_docCard extends StatelessWidget {
  submission_docCard(
      this.documentTitle, this.classroomid, this.assignmentTitle);
  String documentTitle;
  String classroomid;
  String assignmentTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.ltr,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.picture_as_pdf,
                          color: Colors.red,
                        ),
                        title: Text(documentTitle),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
        ],
      ),
    );
  }
}

class contents extends StatelessWidget {
  contents(this.type, this.content);
  var type;
  var content;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "$type",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.02,
            fontFamily: 'marienda',
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
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Text(
                    "$content",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                ],
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

class image_Card extends StatelessWidget {
  image_Card(this.image, this.message, this.classroomid, this.imagepath,
      this.assignmentTitle);
  String image;
  String message;
  String classroomid;
  String imagepath;
  String assignmentTitle;
  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return Container();
    } else {
      return Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
//                height: MediaQuery.of(context).size.height * 0.4,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => Scaffold(
                                appBar: AppBar(
                                  title: Text(
                                    "Image",
                                  ),
                                  backgroundColor: Colors.black,
                                ),
                                backgroundColor: Colors.black,
                                body: Center(
                                  child: imageViewer(image),
                                ),
                              ));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Image.network(
                        image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(message),
                    ),
                  ),
                  Container(
                    child: ListTile(
                      leading: Icon(Icons.image),
                    ),
                  ),
                ],
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
        ],
      );
    }
  }
}

class imageViewer extends StatelessWidget {
  imageViewer(this.image);
  String image;
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: AspectRatio(aspectRatio: 16 / 9, child: Image.network(image)),
    );
  }
}

class document_Card extends StatelessWidget {
  document_Card(this.documentTitle, this.documentDesc, this.classroomid,
      this.assignmentTitle);
  String documentTitle;
  String documentDesc;
  String classroomid;
  String assignmentTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.picture_as_pdf,
                      color: Colors.red,
                    ),
                    title: Text(documentTitle),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        documentDesc,
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class student_assignment_detail extends StatefulWidget {
  student_assignment_detail(this.ATitle, this.classroomid, this.email);
  String ATitle;
  String classroomid;
  String email;
  @override
  _student_assignment_detailState createState() =>
      _student_assignment_detailState(ATitle, classroomid, email);
}

class _student_assignment_detailState extends State<student_assignment_detail> {
  _student_assignment_detailState(this.ATitle, this.classroomid, this.email);
  String ATitle;
  String classroomid;
  String email;
  bool submission = false;
  File _imageFile;

  File documentFile;
  bool submitButtonEnable = false;

  _docPageNavigation(BuildContext context) async {
    final String docpath = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => submission_document_picker(
                documentFile, classroomid, email, ATitle)));
  }

  Future<void> _pickDocument() async {
    File file = await FilePicker.getFile(
        type: FileType.custom, allowedExtensions: ['pdf']);
    setState(() {
      documentFile = file;
    });
    if (documentFile != null) {
      _docPageNavigation(context);
    }
  }

  _imagePageNavigation(BuildContext context) async {
    final String imagepath = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => submission_image_picker(
                _imageFile, classroomid, email, ATitle)));
  }

  Future<void> _pickImage(ImageSource source) async {
    File selectedImage = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selectedImage;
    });
    if (_imageFile != null) {
      _imagePageNavigation(context);
    }
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
                onTap: () async {
                  await Firestore.instance
                      .collection('classrooms')
                      .document(classroomid)
                      .collection('assignments')
                      .document(ATitle)
                      .collection('submissions')
                      .document(email)
                      .collection('attachments')
                      .getDocuments()
                      .then((snapshots) {
                    for (DocumentSnapshot ds in snapshots.documents) {
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

  deleteEmail() async {
    await Firestore.instance
        .collection('classrooms')
        .document(classroomid)
        .collection('assignments')
        .document(ATitle)
        .collection('submissions')
        .document(email)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("$ATitle"),
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
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        StreamBuilder(
                            stream: Firestore.instance
                                .collection('classrooms')
                                .document(classroomid)
                                .collection('assignments')
                                .document(ATitle)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                //listItem = snapshot.data.documents;
                                List<Widget> message_widgets = [];
                                var assignments = snapshot.data;
                                var desc = assignments['assignmentDesc'];
                                var content = assignments['assignmentContent'];
                                final descWidget =
                                    contents('Assignment Description', desc);

                                message_widgets.add(descWidget);

                                return Column(
                                  children: message_widgets,
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        StreamBuilder(
                            stream: Firestore.instance
                                .collection('classrooms')
                                .document(classroomid)
                                .collection('assignments')
                                .document(ATitle)
                                .collection('attachments')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                //listItem = snapshot.data.documents;
                                List<Widget> message_widgets = [];
                                final classes = snapshot.data.documents;
                                for (var Class in classes) {
                                  String sender = Class.data['sender'];
                                  String message = Class.data['message'];
                                  String imageFile = Class.data['image'];
                                  String imagePath = Class.data['imagepath'];
                                  String documentFile = Class.data['doc'];
                                  String documentPath = Class.data['docopath'];
                                  String documentTitle =
                                      Class.data['documentTitle'];
                                  String documentDescription =
                                      Class.data['documentDescription'];
                                  if (imageFile != null) {
                                    final imageWidget = image_Card(
                                        imagePath,
                                        message,
                                        classroomid,
                                        imageFile,
                                        ATitle);
                                    message_widgets.add(imageWidget);
                                  } else if (documentFile != null) {
                                    final docWidget = document_Card(
                                        documentTitle,
                                        documentDescription,
                                        classroomid,
                                        ATitle);
                                    message_widgets.add(docWidget);
                                  }
                                }
                                return Column(
                                  children: message_widgets,
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        StreamBuilder(
                            stream: Firestore.instance
                                .collection('classrooms')
                                .document(classroomid)
                                .collection('assignments')
                                .document(ATitle)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                //listItem = snapshot.data.documents;
                                List<Widget> message_widgets = [];
                                var assignments = snapshot.data;
                                var desc = assignments['assignmentDesc'];
                                var content = assignments['assignmentContent'];

                                final contentWidget =
                                    contents('Assignment Questions', content);

                                message_widgets.add(contentWidget);

                                return Column(
                                  children: message_widgets,
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  StreamBuilder(
                      stream: Firestore.instance
                          .collection('classrooms')
                          .document(classroomid)
                          .collection('assignments')
                          .document(ATitle)
                          .collection('submissions')
                          .document(email)
                          .collection('attachments')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else {
                          //listItem = snapshot.data.documents;
                          List<Widget> message_widgets = [];
                          final classes = snapshot.data.documents;
                          int length_of_docs = snapshot.data.documents.length;
                          for (var Class in classes) {
                            String sender = Class.data['sender'];
                            String message = Class.data['message'];
                            String imageFile = Class.data['image'];
                            String imagePath = Class.data['imagepath'];
                            String documentFile = Class.data['doc'];
                            String documentPath = Class.data['docopath'];
                            String documentTitle = Class.data['documentTitle'];
                            String documentDescription =
                                Class.data['documentDescription'];
                            if (imageFile != null) {
                              final imageWidget = submission_imageCard(
                                  imagePath, classroomid, imageFile, ATitle);
                              message_widgets.add(imageWidget);
                            } else if (documentFile != null) {
                              final docWidget = submission_docCard(
                                  documentTitle, classroomid, ATitle);
                              message_widgets.add(docWidget);
                            }
                          }
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                Text(
                                  "Your submission",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                      fontFamily: 'marienda'),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                Column(
                                  children: message_widgets,
                                ),
                                RawMaterialButton(
                                  padding: EdgeInsets.all(15.0),
                                  shape: CircleBorder(),
                                  elevation: 5.0,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.lightGreen,
                                  ),
                                  fillColor: Colors.white,
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder:
                                            (BuildContext context) => Scaffold(
                                                  backgroundColor:
                                                      Colors.white70,
                                                  body: Center(
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.5,
                                                      child: Stack(
                                                        overflow:
                                                            Overflow.visible,
                                                        children: <Widget>[
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.7,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.4,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20.0),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: <
                                                                    Widget>[
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: <
                                                                        Widget>[
                                                                      Column(
                                                                        children: <
                                                                            Widget>[
                                                                          GestureDetector(
                                                                            child:
                                                                                Icon(Icons.assignment),
                                                                            onTap:
                                                                                () {
                                                                              _pickDocument();

//                                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>assignmentsList(classroomId,email)));
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.01,
                                                                          ),
                                                                          Text(
                                                                              "Document"),
                                                                        ],
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Column(
                                                                            children: <Widget>[
                                                                              GestureDetector(
                                                                                child: Icon(Icons.camera),
                                                                                onTap: () {
                                                                                  _pickImage(ImageSource.camera);
                                                                                },
                                                                              ),
                                                                              SizedBox(
                                                                                height: MediaQuery.of(context).size.height * 0.01,
                                                                              ),
                                                                              Text("Photo from camera"),
                                                                            ],
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                          ),
                                                                        ),
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.3,
                                                                      ),
                                                                      Container(
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Column(
                                                                            children: <Widget>[
                                                                              GestureDetector(
                                                                                child: Icon(Icons.photo),
                                                                                onTap: () {
                                                                                  _pickImage(ImageSource.gallery);
                                                                                },
                                                                              ),
                                                                              SizedBox(
                                                                                height: MediaQuery.of(context).size.height * 0.01,
                                                                              ),
                                                                              Text("Photo from gallery"),
                                                                            ],
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                          ),
                                                                        ),
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.3,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: -10,
                                                            left: -10,
                                                            child:
                                                                GestureDetector(
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: CircleAvatar(
                                                                        radius:
                                                                            15.0,
                                                                        child: Icon(
                                                                            Icons.clear))),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ));
                                  },
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                message_widgets.length > 0
                                    ? GestureDetector(
                                        onTap: () async {
                                          DateTime now = DateTime.now();
                                          String date = now.day.toString() +
                                              "-" +
                                              now.month.toString() +
                                              "-" +
                                              now.year.toString();
                                          int ampm = now.hour > 12
                                              ? now.hour - 12
                                              : now.hour;
                                          String period =
                                              ampm < 12 ? "AM" : "PM";
                                          String time = ampm.toString() +
                                              ":" +
                                              now.minute.toString() +
                                              " " +
                                              period;
                                          await Firestore.instance
                                              .collection('classrooms')
                                              .document(classroomid)
                                              .collection('assignments')
                                              .document(ATitle)
                                              .collection("submissions")
                                              .document(email)
                                              .setData({
                                            'submitted_utc': now,
                                            'date': date,
                                            'time': time,
                                            'email': email,
                                            'evaluated': false
                                          });

                                          Fluttertoast.showToast(
                                            msg: "Submitted successfully",
                                            backgroundColor: Colors
                                                .deepPurpleAccent.shade200,
                                            textColor: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.03,
                                          );

                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.lightGreen,
                                          ),
                                          child: Center(
                                              child: Text(
                                            "Submit",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.4,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08,
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                ),
                              ],
                            ),
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
        ),
      ),
    );
  }
}
