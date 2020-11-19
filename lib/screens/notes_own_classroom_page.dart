import 'dart:io';
import 'package:eclass/own_class_tasks/assignment_page.dart';
import 'package:eclass/screens/example.dart';
import 'package:flutter/material.dart';
import 'own_classrom_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';
import 'chewie_video.dart';
import 'example2.dart';
import 'package:eclass/imagepickerPage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:eclass/styles.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';
import 'package:full_screen_menu/full_screen_menu.dart';
import 'package:eclass/contents/videoContents.dart';
import 'package:eclass/students/students_list.dart';
import 'profile.dart';




class own_notes_page extends StatefulWidget {
  own_notes_page(this.classroomId,this.email,this.username,this.bgcolor,this.classroomName);
  Color bgcolor;
  String classroomId;
  String username;
  String email;
  String classroomName;
  @override
  _own_notes_pageState createState() => _own_notes_pageState(classroomId,email,username,bgcolor,classroomName);
}

class _own_notes_pageState extends State<own_notes_page> with SingleTickerProviderStateMixin{
  _own_notes_pageState(this.classroomId,this.email,this.username,this.bgcolor,this.classroomName);
  Color bgcolor;
  String classroomId;
  String username;
  String email;
  TabController tcontroller;
  String classroomName;

  @override
  void initState(){
    super.initState();
    tcontroller = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose(){
    tcontroller.dispose();
    super.dispose();
  }


  void showFullScreenMenu(BuildContext context) {
    FullScreenMenu.show(
      context,
      backgroundColor: Colors.white10,
      items: [
        FSMenuItem(
          icon: Icon(Icons.library_books, color: Colors.white),
          text: Text('Assignment', style: TextStyle(color: Colors.black)),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>assignmentPage(classroomId,email)));
          },
        ),
        FSMenuItem(
          icon: Icon(Icons.video_call, color: Colors.white),
          text: Text('Live Class', style: TextStyle(color: Colors.black)),
          onTap: (){

          },
        ),
        FSMenuItem(
          icon: Icon(Icons.border_color, color: Colors.white),
          text: Text('Conduct Test', style: TextStyle(color: Colors.black)),
        ),
        FSMenuItem(
          icon: Icon(Icons.info_outline, color: Colors.white),
          text: Text('Classroom Info', style: TextStyle(color: Colors.black)),
        ),
        FSMenuItem(
          icon: Icon(Icons.share, color: Colors.white),
          text: Text('Share Class Id', style: TextStyle(color: Colors.black)),
        ),

      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: new Text("Notes"), backgroundColor: bgcolor,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: (){
                  showDialog(context: context, builder: (BuildContext context) => Scaffold(

                    backgroundColor: Colors.white70,
                    body: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Stack(
                          overflow: Overflow.visible,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: MediaQuery.of(context).size.height * 0.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white,
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            GestureDetector(
                                              child: Icon(Icons.border_color),
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>assignmentPage(classroomId,email)));
                                              },
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context).size.height * 0.01,
                                            ),
                                            Text("Assignment & Quiz"),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.center,
                                        ),

                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          child: Center(
                                            child: Column(
                                              children: <Widget>[
                                                GestureDetector(
                                                  child: Icon(Icons.people),
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Students_list(classroomId)));
                                                  },
                                                ),
                                                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                                Text("Students"),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            ),
                                          ),
                                          width: MediaQuery.of(context).size.width*0.3,
                                        ),
                                        Container(
                                          child: Center(
                                            child: Column(
                                              children: <Widget>[
                                                GestureDetector(
                                                  child: Icon(Icons.video_call),
                                                  onTap: (){

                                                  },
                                                ),
                                                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                                                Text("Live Class"),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            ),
                                          ),
                                          width: MediaQuery.of(context).size.width*0.3,

                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          child: Center(
                                            child: Column(
                                              children: <Widget>[
                                                GestureDetector(
                                                  child: Icon(Icons.info),
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>classroomInfo(classroomId)));
                                                  },
                                                ),
                                                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                                Text("Info"),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            ),
                                          ),
                                          width: MediaQuery.of(context).size.width*0.3,
                                        ),
                                        Container(
                                          child: Center(
                                            child: Column(
                                              children: <Widget>[
                                                GestureDetector(
                                                  child: Icon(Icons.share),
                                                  onTap: (){

                                                  },
                                                ),
                                                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),

                                                Text("share"),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            ),
                                          ),
                                          width: MediaQuery.of(context).size.width*0.3,

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
                              child: GestureDetector(
                                  onTap: (){
                                    Navigator.pop(context);
                                  },
                                  child: CircleAvatar(
                                      radius: 15.0,
                                      child: Icon(Icons.clear))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
//                  showFullScreenMenu(context);
                },
              ),
            ],
            iconTheme: new IconThemeData(color: Colors.white),
            bottom: new TabBar(
                controller: tcontroller,
                tabs: <Tab>[
                  new Tab(icon: new Icon(Icons.new_releases), text: "Announcements",),
                  new Tab(icon: new Icon(Icons.video_library),text:"Videos"),
                  new Tab(icon: new Icon(Icons.description),text: "Documents",)
                ]
            )
        ),
        body: new TabBarView(
            controller: tcontroller,
            children: <Widget>[
              new ThirdPage(classroomId, email, username, bgcolor),

              new SecondPage(classroomId, email, username, bgcolor),

              new FirstPage(classroomId,email,username,bgcolor),
            ]
        )
    );
  }
}






class FirstPage extends StatefulWidget {
  FirstPage(this.classroomId,this.email,this.username,this.bgcolor);
  Color bgcolor;
  String classroomId;
  String username;
  String email;
  @override
  _FirstPageState createState() => _FirstPageState(this.classroomId,this.email,this.username,this.bgcolor);
}

class _FirstPageState extends State<FirstPage> {
  _FirstPageState(this.classroomId,this.email,this.username,this.bgcolor);
  Color bgcolor;
  String classroomId;
  String username;
  String email;
  File _imageFile;

  File documentFile;

  _docPageNavigation(BuildContext context)async{
    final String docpath = await Navigator.push(context, MaterialPageRoute(builder: (context)=>documentPicker(documentFile,classroomId,email)));

  }

  Future<void> _pickDocument() async{
    File file =await FilePicker.getFile(type:FileType.custom,allowedExtensions:['pdf']);
    setState(() {
      documentFile =file;
    });
    if(documentFile !=null){
      _docPageNavigation(context);
    }
  }


  _imagePageNavigation(BuildContext context)async{
    final String imagepath = await Navigator.push(context, MaterialPageRoute(builder: (context)=>imagepickerPage(_imageFile,classroomId,email)));

  }

  Future<void> _pickImage(ImageSource source) async{
    File selectedImage =await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile =selectedImage;
    });
    if(_imageFile !=null){
      _imagePageNavigation(context);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom:10.0),
        child: SpeedDial(
          child: Icon(Icons.add),
          backgroundColor: bgcolor,
          closeManually: false,
          children: [
            SpeedDialChild(
              child: Icon(Icons.filter),
              label: 'Add a Photo',
              onTap: (){
//                _settingModalBottomSheetForPhoto(context);
                _pickImage(ImageSource.gallery);

              },
            ),
            SpeedDialChild(
              child: Icon(Icons.add_photo_alternate),
              label: 'Add a Photo',
              onTap: (){
                _pickImage(ImageSource.camera);
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.description),
              label: 'Add a document',
              onTap: (){
                _pickDocument();
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                StreamBuilder(
                    stream: Firestore.instance.collection('classrooms').document(classroomId).collection('contents').orderBy('created utc').snapshots(),
                    builder: (context,snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        //listItem = snapshot.data.documents;
                        List<Widget> message_widgets = [];
                        final classes = snapshot.data.documents.reversed;
                        for(var Class in classes){
                          String sender = Class.data['sender'];
                          String message = Class.data['message'];
                          String imageFile = Class.data['image'];
                          String imagePath = Class.data['imagepath'];
                          String documentFile = Class.data['doc'];
                          String documentPath = Class.data['docopath'];
                          String documentTitle = Class.data['documentTitle'];
                          String documentDescription = Class.data['documentDescription'];
                          String name = Class.data['Name'];
                          String date  = Class.data['created'];
                          String time = Class.data['time'];
                          if(imageFile != null) {


                            final imageWidget = image_Card(imagePath,message,classroomId,name,time,date);
                            message_widgets.add(imageWidget);


                          }
                          else if(documentFile != null){
                            final docWidget = document_Card(documentTitle,documentDescription,time,date,classroomId,name);
                            message_widgets.add(docWidget);
                          }

                        }
                        return Column(
                          children: message_widgets,
                        );
                      }
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),],
            ),
          ),
        ],
      ),
    );
  }
}


class SecondPage extends StatefulWidget {
  SecondPage(this.classroomId,this.email,this.username,this.bgcolor);
  Color bgcolor;
  String classroomId;
  String username;
  String email;
  @override
  _SecondPageState createState() => _SecondPageState(this.classroomId,this.email,this.username,this.bgcolor);
}

class _SecondPageState extends State<SecondPage> {
  _SecondPageState(this.classroomId,this.email,this.username,this.bgcolor);
  Color bgcolor;
  String classroomId;
  String username;
  String email;
  File _imageFile;



  _videoPageNavigation(BuildContext context)async{
    final String videopath = await Navigator.push(context, MaterialPageRoute(builder: (context)=>videopickerpage(_imageFile,classroomId,email)));

  }

  Future<void> _pickVideo(ImageSource source) async{
    File selectedImage =await ImagePicker.pickVideo(source: source);
    setState(() {
      _imageFile =selectedImage;
    });
    if(_imageFile !=null){
      _videoPageNavigation(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                _pickVideo(ImageSource.gallery);
              },
              heroTag: 'video0',
              tooltip: 'Pick Video from gallery',
              child: const Icon(Icons.video_library),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                _pickVideo(ImageSource.camera);
              },
              heroTag: 'video1',
              tooltip: 'Take a Video',
              child: const Icon(Icons.videocam),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                StreamBuilder(
                    stream: Firestore.instance.collection('classrooms').document(classroomId).collection('contents').orderBy('created utc').snapshots(),
                    builder: (context,snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        //listItem = snapshot.data.documents;
                        List<Widget> message_widgets = [];
                        final classes = snapshot.data.documents.reversed;
                        for(var Class in classes){
                          String sender = Class.data['sender'];
                          String message = Class.data['message'];
                          String videoFile = Class.data['video'];
                          String videoPath = Class.data['videopath'];
                          String videoTitle = Class.data['videoTitle'];
                          String videoDescription = Class.data['videoDescription'];
                          String name = Class.data['Name'];
                          String date = Class.data['created'];
                          String time = Class.data['time'];
                          if(videoPath != null){
                            final videoWidget = video_Card(videoPath,videoTitle,videoDescription,name,classroomId,username,date,time);
                            message_widgets.add(videoWidget);
                          }

                        }
                        return Column(
                          children: message_widgets,
                        );
                      }
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),],
            ),
          ),
        ],
      ),
    );
  }
}



class ThirdPage extends StatefulWidget {
  ThirdPage(this.classroomId,this.email,this.username,this.bgcolor);
  Color bgcolor;
  String classroomId;
  String username;
  String email;
  @override
  _ThirdPageState createState() => _ThirdPageState(classroomId,email,username,bgcolor);
}

class _ThirdPageState extends State<ThirdPage> {
  _ThirdPageState(this.classroomId,this.email,this.username,this.bgcolor);
  Color bgcolor;
  String classroomId;
  String username;
  String email;
  @override
  File documentFile;
  String newMessage;
  var message;
  File _imageFile;
  var tc = TextEditingController();
  int Cday;
  int Cyear;
  int Cmonth;
  String Cdate;
  String URL;
  int hour;
  int minute;
  String twelve;
  String time;
  int thour;

  _imagePageNavigation(BuildContext context)async{
    final String imagepath = await Navigator.push(context, MaterialPageRoute(builder: (context)=>announcement_image_picker(_imageFile,classroomId,email)));

  }


  Future<void> _pickImage(ImageSource source) async{
    File selectedImage =await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile =selectedImage;
    });
    if(_imageFile !=null){
      _imagePageNavigation(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.68,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child:  StreamBuilder(
                    stream: Firestore.instance.collection('classrooms').document(classroomId).collection('contents').orderBy('created utc').snapshots(),
                    builder: (context,snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        //listItem = snapshot.data.documents;
                        List<Widget> message_widgets = [];
                        final classes = snapshot.data.documents.reversed;
                        for(var Class in classes){
                          String sender = Class.data['sender'];
                          String announcement = Class.data['Announcement'];
                          String image = Class.data['Aimage'];
                          String imagepath = Class.data['Aimagepath'];
                          String message = Class.data['message'];
                          String date = Class.data['created'];
                          String time = Class.data['time'];
                          if(image!=null){
                            final imagewidget = announcement_image_card(message, sender, imagepath,date,time);
                            message_widgets.add(imagewidget);
                          }
                          else if(announcement != null){
                            final announcementWidget = announcement_card(announcement,sender,date,time);
                            message_widgets.add(announcementWidget);
                          }
                        }
                        return Column(
                          children: message_widgets,
                        );
                      }
                    }),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    child: CircleAvatar(
                      radius: 15.0,
                      backgroundColor: Colors.orangeAccent,
                      child: Icon(Icons.add_photo_alternate,color: Colors.white,),
                    ),
                    onTap: (){
                      showDialog(context: context, builder: (BuildContext context) => Scaffold(

                        backgroundColor: Colors.white70,
                        body: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Stack(
                              overflow: Overflow.visible,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  height: MediaQuery.of(context).size.height * 0.2,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: Colors.white,
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            GestureDetector(
                                                child: Icon(Icons.camera),
                                              onTap: (){
                                                _pickImage(ImageSource.camera);
                                              },
                                            ),
                                            Text("Camera"),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.center,
                                        ),
                                        Column(
                                          children: <Widget>[
                                            GestureDetector(
                                              child: Icon(Icons.filter),
                                              onTap: (){
                                                _pickImage(ImageSource.gallery);
                                              },
                                            ),
                                            Text("Gallery"),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -10,
                                  left: -10,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                      child: CircleAvatar(
                                        radius: 15.0,
                                          child: Icon(Icons.clear))),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));

                    },
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: TextField(
                        controller: tc,
                        onChanged: (value){
                          setState(() {
                            message = value;
                          });
                        },
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: "Type here..",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()async{
                      if(message != null) {
                        tc.clear();

                        setState(() {
                          URL = "${DateTime.now()}+$email";
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

                        await Firestore.instance.collection('classrooms').document(classroomId).collection('contents').document(URL).setData({
                          'sender' : email,
                          'Announcement':message,
                          'created':Cdate,
                          'created utc':DateTime.now(),
                          'Name':URL,
                          'time':time,
                        });



                        setState(() {
                          message = null;
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width *0.15,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(child:Icon(Icons.send,color: Colors.white,)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01,)
          ],
        ),
      ),
    );
  }
}



class image_Card extends StatelessWidget {
  image_Card(this.image,this.message,this.classroomId,this.file,this.time,this.date);
  String image;
  String message;
  String classroomId;
  String file;
  String time;
  String date;
  @override
  Widget build(BuildContext context) {
    if(image == null){
      return Container();
    }
    else{
      return Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
//                height: MediaQuery.of(context).size.height * 0.4,
            child: Card(
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Image.network(
                        image,
                        fit: BoxFit.fill,
                      ),
                    ),
                    onTap: (){
                      showDialog(context: context, builder: (BuildContext context) => Scaffold(
                        appBar: AppBar(
                          title: Text("$message",),
                          backgroundColor: Colors.black,
                        ),
                        backgroundColor: Colors.black,
                        body: Center(
                          child: imageViewer(image),
                        ),
                      ));
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.grey,width: 1.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(message,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.025,
                          ),),
                      ),
                    ),
                  ),
                  Container(
                    child: ListTile(
                      leading:Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                          child: ListTile(leading:Text("$time        $date"),)) ,
                      trailing: GestureDetector(
                        onTap: (){
                          showDialog(context: context, builder: (BuildContext context) => Scaffold(
                            backgroundColor: Colors.white30,
                            body: Center(
                              child: dialogBox(classroomId, file),
                            ),
                          ));
                        },
                        child: Chip(
                          avatar: CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            child: Icon(Icons.clear),
                          ),
                          label: Text('Delete'),
                        ),
                      ),
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


class video_Card extends StatelessWidget {
  video_Card(this.videopath,this.videoTitle,this.videoDescription,this.videoFile,this.classroomId,this.username,this.date,this.time);
  String videopath;
  String videoDescription;
  String videoTitle;
  String videoFile;
  String classroomId;
  String username;
  String date;
  String time;
  VideoPlayerController _controller;





  @override
  Widget build(BuildContext context) {
    _controller= VideoPlayerController.network(videopath);
    //_controller.initialize();
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
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayerApp(videopath,username,classroomId,videoFile)));
              },
              child: Stack(
                children: <Widget>[
                  Container(
                     // child: VideoPlayer(_controller),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height*0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey,
                  ),),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5 ,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(

                        color:Colors.white30,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: MediaQuery.of(context).size.height * 0.05,
                      left: MediaQuery.of(context).size.width * 0.35,
                      child: Icon(Icons.play_circle_outline,size: MediaQuery.of(context).size.height*0.1,)),
                ],

              ),
            ),
//          ChewieListItem(
//            videoPlayerController: VideoPlayerController.network(
//              videopath,
//            ),
//          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width*0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Expanded(child: Text(videoTitle,style: TextStyle(
                               fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.height * 0.03,
                             ),
                               textAlign: TextAlign.start,),),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(child: Text(videoDescription,style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                          ),
                            textAlign: TextAlign.start,),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child:Text("$time"),
                ),
//                FlatButton(
//                  child:Text(""),
//                ),
                FlatButton(
                  child:Text("$date"),
                ),
                FlatButton(
                  child: const Text('Share'),
                  onPressed: () { /* ... */ },
                ),
                FlatButton(
                  child: const Text('Delete'),
                  onPressed: () {
                    showDialog(context: context, builder: (BuildContext context) => Scaffold(
                      backgroundColor: Colors.white30,
                      body: Center(
                        child: dialogBox(classroomId, videoFile),
                      ),
                    ));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


class document_Card extends StatelessWidget {
  document_Card(this.documentTitle,this.documentDesc,this.time,this.date,this.classroomId,this.file);
  String documentTitle;
  String documentDesc;
  String classroomId;
  String file;
  String time;
  String date;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.ltr,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
//                ListTile(
//                  leading:Icon(Icons.picture_as_pdf,color: Colors.red,) ,
//                  title: Text(documentTitle),
//                  //trailing: Text('$date'),
//                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.95,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey.shade200,
                      border: Border.all(color: Colors.grey,width: 1.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.description,
                            size: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Text(documentDesc,
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.height * 0.025,
                            ),),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: ListTile(

                    leading:Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ListTile(leading:Text("$time        $date"),)),
                    trailing: GestureDetector(
                      onTap: (){
                        showDialog(context: context, builder: (BuildContext context) => Scaffold(
                          backgroundColor: Colors.white30,
                          body: Center(
                            child: dialogBox(classroomId, file),
                          ),
                        ));
                      },
                      child: Chip(
                        avatar: CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          child: Icon(Icons.clear),
                        ),
                        label: Text('Delete'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



class announcement_card extends StatelessWidget {
  announcement_card(this.announcementText,this.announcementtitle,this.date,this.time);
  var announcementText;
  String announcementtitle;
  String date;
  String time;
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
                    leading:Icon(Icons.stars,color: Colors.orange,) ,
                    title: Text("$announcementtitle"),
                    trailing: Icon(Icons.more_vert),
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.shade200,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(announcementText,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.025,
                          ),),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                          Text("$date")],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[Text("$time"),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.1,)],),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
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


class announcement_image_card extends StatelessWidget {
  announcement_image_card(this.announcementText,this.announcementtitle,this.image,this.date,this.time);

  var announcementText;
  String announcementtitle;
  String image;
  String date;
  String time;
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
                    leading:Icon(Icons.stars,color: Colors.orange,) ,
                    title: Text(announcementtitle),
                    trailing: Icon(Icons.more_vert),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: (){
                        showDialog(context: context, builder: (BuildContext context) => Scaffold(
                          appBar: AppBar(
                            title: Text("Image",),
                            backgroundColor: Colors.black,
                          ),
                          backgroundColor: Colors.black,
                          body: Center(
                            child: imageViewer(image),
                          ),
                        ));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                            child: Image.network(image,width: MediaQuery.of(context).size.width * 0.7,)),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey.shade200,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(announcementText,
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.height * 0.025,
                          ),),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                          Text("$date")],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[Text("$time"),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.1,)],),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
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





class First extends StatelessWidget {
  First(this.classroomId,this.email,this.username,this.bgcolor);
  Color bgcolor;
  String classroomId;
  String username;
  String email;





  @override
  Widget build(BuildContext context){
    return ListView(
      children: <Widget>[
//        ChewieListItem(
//          videoPlayerController: VideoPlayerController.network(
//            'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
//          ),
//        ),
        Text("this is video")
      ],
    );
  }
}

class Second extends StatelessWidget {
  List ext = ['pdf'];
  @override
  Widget build(BuildContext context){
    return new Container(
        child: new Center(
            child: RaisedButton(
              onPressed:()async{
              },
              child: Text("file"),
            )
        )
    );
  }
}


class Third extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return new Container(
        child: new Center(
            child: new Icon(Icons.local_pizza, size: 150.0, color: Colors.teal)
        )
    );
  }
}

class dialogBox extends StatelessWidget {
  dialogBox(this.classroomId,this.name);
  String classroomId;
  String name;

  finalprocedure()async{
    await Firestore.instance.collection('classrooms').document(classroomId).collection('contents').document(name).delete();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text("Deleting this file",style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.03,
            fontWeight: FontWeight.bold,
          ),),
          Text("Are you sure?",style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.025,
            fontWeight: FontWeight.normal,
          ),),
          ButtonBar(
            children: <Widget>[
              FlatButton(
                child: Text("Cancel"),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Yes"),
                onPressed: ()async{


                  await Firestore.instance.collection('classrooms').document(classroomId).collection('contents').document(name).collection('chats').getDocuments().then((snapshots){
                    for (DocumentSnapshot ds in snapshots.documents){
                      ds.reference.delete();
                    }
                  });

                  finalprocedure();


                  Navigator.pop(context);



                },
              )
            ],
          ),
        ],
      ),
    );
  }
}


class imageViewer extends StatelessWidget {
  imageViewer(this.image);
  String image;
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: AspectRatio(
        aspectRatio:16/9 ,
          child: Image.network(image)),
    );
  }
}
