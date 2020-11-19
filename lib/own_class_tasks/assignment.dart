import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:eclass/imagepickerPage.dart';
import 'package:image_picker/image_picker.dart';

class assignment_task extends StatefulWidget {
  assignment_task(this.classroomid, this.email,this.Atitle);
  String classroomid;
  String email;
  String Atitle;
  @override
  _assignment_taskState createState() =>
      _assignment_taskState(classroomid, email,Atitle);
}

class _assignment_taskState extends State<assignment_task> {
  _assignment_taskState(this.classroomid, this.email,this.ATitle);
  String email;
  DateTime datetime;
  String classroomid;
  String ATitle;
  String ADesc;
  String AContents;
  int month = 00, year = 0000, day = 00;
  int Cmonth, Cyear, Cday;
  String dueDate;
  String Cdate;
  File _imageFile;

  File documentFile;

  _docPageNavigation(BuildContext context) async {
    final String docpath = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                quiz_documentPicker(documentFile, classroomid, email,ATitle)));
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
            builder: (context) =>
                quiz_imagePicker(_imageFile, classroomid, email,ATitle)));
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ADesc = null;
    AContents = null;
    datetime = null;
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to dicard the assignment'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () async{
              await Firestore.instance.collection('classrooms').document(classroomid).collection('assignments').document(ATitle).collection('attachments').getDocuments().then((snapshots){
                for (DocumentSnapshot ds in snapshots.documents){
                  ds.reference.delete();
                }
              });
              Navigator.of(context).pop(true);},
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
          title: Text("Assignment"),
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Assignment Description",
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
                        child: new ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.1,
                          ),
                          child: new Scrollbar(
                            child: new SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              reverse: false,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, right: 3.0),
                                child: new TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      ADesc = value;
                                    });
                                  },
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: "Description",
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
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        StreamBuilder(
                            stream: Firestore.instance.collection('classrooms').document(classroomid).collection('assignments').document(ATitle).collection('attachments').snapshots(),
                            builder: (context,snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else {
                                //listItem = snapshot.data.documents;
                                List<Widget> message_widgets = [];
                                final classes = snapshot.data.documents;
                                for(var Class in classes){
                                  String sender = Class.data['sender'];
                                  String message = Class.data['message'];
                                  String imageFile = Class.data['image'];
                                  String imagePath = Class.data['imagepath'];
                                  String documentFile = Class.data['doc'];
                                  String documentPath = Class.data['docopath'];
                                  String documentTitle = Class.data['documentTitle'];
                                  String documentDescription = Class.data['documentDescription'];
                                  if(imageFile != null) {


                                    final imageWidget = image_Card(imagePath,message,classroomid,imageFile,ATitle);
                                    message_widgets.add(imageWidget);


                                  }
                                  else if(documentFile != null){
                                    final docWidget = document_Card(documentTitle,documentDescription,classroomid,ATitle);
                                    message_widgets.add(docWidget);
                                  }

                                }
                                return Column(
                                  children: message_widgets,
                                );
                              }
                            }),

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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0, right: 3.0,top: 5.0,bottom:5.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text("Attachments"),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                Container(
                                  width: 40.0,
                                  height: 40.0,
                                  child: new RawMaterialButton(
                                    fillColor: Colors.blue,
                                    shape: new CircleBorder(),
                                    elevation: 0.0,
                                    child: Icon(
                                      Icons.attach_file,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      _pickDocument();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.02,
                                ),
                                Container(
                                  width: 40.0,
                                  height: 40.0,
                                  child: new RawMaterialButton(
                                    fillColor: Colors.blue,
                                    shape: new CircleBorder(),
                                    elevation: 0.0,
                                    child: Icon(
                                      Icons.add_photo_alternate,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      _pickImage(ImageSource.camera);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Assignment Questions",
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
                        child: new ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height * 0.3,
                            maxHeight: MediaQuery.of(context).size.height * 0.7,
                          ),
                          child: new Scrollbar(
                            child: new SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              reverse: false,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, right: 3.0),
                                child: new TextField(
                                  onChanged: (value) {
                                    setState(() {
                                      AContents = value;
                                    });
                                  },
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    hintText: "Contents",
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
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Due Date",
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
                              color: Colors.white,
                              child: Text(
                                "$day-$month-$year",
                                style: TextStyle(),
                                textAlign: TextAlign.center,
                              ),
                              width: MediaQuery.of(context).size.width * 0.6,
                            ),
                            RaisedButton(
                              child: Text("select"),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2020),
                                        lastDate: DateTime(2100))
                                    .then((onValue) {
                                  setState(() {
                                    datetime = onValue;
                                    day = onValue.day;
                                    month = onValue.month;
                                    year = onValue.year;
                                    dueDate = "$day-$month-$year";
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
                  Builder(
                    builder: (context) => GestureDetector(
                      onTap: () async {
                        Cday = DateTime.now().day;
                        Cmonth = DateTime.now().month;
                        Cyear = DateTime.now().year;
                        Cdate = "$Cday-$Cmonth-$Cyear";
                        if (AContents != null &&
                            ADesc != null &&
                            ATitle != null && dueDate!= null) {
                          await Firestore.instance
                              .collection('classrooms')
                              .document(classroomid)
                              .collection('assignments')
                              .document(ATitle)
                              .setData({
                            'assignmentName': ATitle,
                            'assignmentDesc': ADesc,
                            'assignmentContent': AContents,
                            'dueDate': dueDate,
                            'created utc': DateTime.now(),
                            'created': Cdate,
                            'dueDate utc': datetime.toUtc(),
                          });
                          await Firestore.instance
                              .collection('classrooms')
                              .document(classroomid)
                              .collection('Assignments&Quiz')
                              .document()
                              .setData({
                            'type': 'Assignment',
                            'dueDate': dueDate,
                            'created utc': DateTime.now(),
                            'created': Cdate,
                            'dueDate utc': datetime.toUtc(),
                            'title': ATitle,
                          });
                          Navigator.pop(context);
                        } else {
                          final snackBar = SnackBar(
                            content: Text(
                              'Please fill all the details',
                              style: TextStyle(fontSize: 20.0),
                            ),
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                          color: Colors.green,
                        ),
                        child: Center(
                          child: Text(
                            "Post",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.height * 0.03,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
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


class image_Card extends StatelessWidget {
  image_Card(this.image,this.message,this.classroomid,this.imagepath,this.assignmentTitle);
  String image;
  String message;
  String classroomid;
  String imagepath;
  String assignmentTitle;
  @override
  Widget build(BuildContext context) {
    if(image == null){
      return Container();
    }
    else{
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Image.network(
                      image,
                      fit: BoxFit.fill,
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
                      leading:Icon(Icons.image) ,
                      trailing: GestureDetector(
                          onTap: ()async{
                            await Firestore.instance.collection('classrooms').document(classroomid).collection('assignments').document(assignmentTitle).collection('attachments').where('image',isEqualTo: imagepath).getDocuments().then((snapshot){
                              snapshot.documents.first.reference.delete();
                            });
                          },
                          child: Icon(Icons.more_vert)),
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
      );}
  }
}


class document_Card extends StatelessWidget {
  document_Card(this.documentTitle,this.documentDesc,this.classroomid,this.assignmentTitle);
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
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 5.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading:Icon(Icons.picture_as_pdf,color: Colors.red,) ,
                    title: Text(documentTitle),
                    trailing: GestureDetector(
                      onTap: ()async{
                        await Firestore.instance.collection('classrooms').document(classroomid).collection('assignments').document(assignmentTitle).collection('attachments').where('documentTitle',isEqualTo: documentTitle).getDocuments().then((snapshot){
                          snapshot.documents.first.reference.delete();
                        });
                      },
                        child: Icon(Icons.more_vert)),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(documentDesc,
                        style: TextStyle(
                          fontSize: 15.0,
                        ),),
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
