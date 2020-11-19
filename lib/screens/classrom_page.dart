import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eclass/styles.dart';
import 'package:eclass/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';
import 'package:eclass/contents/videoContents.dart';
import 'package:eclass/joined_class_tasks/assginments&quiz.dart';
import 'profile.dart';


class classroom_page extends StatefulWidget {
  classroom_page(this.bgColor,this.classroomId,this.staffName,this.username,this.classroomname,this.email);
  Color bgColor;
  String classroomId;
  String staffName;
  String username;
  String email;
  String classroomname;
  @override
  _classroom_pageState createState() => _classroom_pageState(bgColor,classroomId,staffName,username,classroomname,email);
}

class _classroom_pageState extends State<classroom_page> with SingleTickerProviderStateMixin{
  _classroom_pageState(this.bgColor,this.classroomId,this.staffName,this.username,this.classroomName,this.email);
  Color bgColor;
  String classroomId;
  String staffName;
  String username;
  String email;
  String classroomName;
  final _auth = FirebaseAuth.instance;
  TabController tcontroller;

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





  @override
  Widget build(BuildContext context) {
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight =MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: new AppBar(title: new Text("$classroomName"), backgroundColor: bgColor,
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
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>assignmentsList(classroomId,email)));
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
//                                    Row(
//                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                      children: <Widget>[
//                                        Container(
//                                          child: Center(
//                                            child: Column(
//                                              children: <Widget>[
//                                                GestureDetector(
//                                                  child: Icon(Icons.people),
//                                                  onTap: (){
////                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Students_list(classroomId)));
//                                                  },
//                                                ),
//                                                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
//                                                Text("Students"),
//                                              ],
//                                              mainAxisAlignment: MainAxisAlignment.center,
//                                            ),
//                                          ),
//                                          width: MediaQuery.of(context).size.width*0.3,
//                                        ),
//                                        Container(
//                                          child: Center(
//                                            child: Column(
//                                              children: <Widget>[
//                                                GestureDetector(
//                                                  child: Icon(Icons.video_call),
//                                                  onTap: (){
//
//                                                  },
//                                                ),
//                                                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
//
//                                                Text("Live Class"),
//                                              ],
//                                              mainAxisAlignment: MainAxisAlignment.center,
//                                            ),
//                                          ),
//                                          width: MediaQuery.of(context).size.width*0.3,
//
//                                        ),
//                                      ],
//                                    ),
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
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>student_classroom_info(classroomId)));
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
              new announcements(classroomId),
              new videos(classroomId, username),
              new documents(classroomId),

            ]
        )
    );
  }
}


class announcements extends StatefulWidget {
  announcements(this.classroomId);
  String classroomId;
  @override
  _announcementsState createState() => _announcementsState(classroomId);
}

class _announcementsState extends State<announcements> {
  _announcementsState(this.classroomId);
  String classroomId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
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
                      if(message_widgets.length<1){
                        return Center(child: Text("No Announcements yet"));

                      }
                      return Column(
                        children: message_widgets,
                      );
                    }
                  }),
            )));
  }
}


class videos extends StatefulWidget {
  videos(this.classroomId,this.username);
  String classroomId;
  String username;
  @override
  _videosState createState() => _videosState(classroomId,username);
}

class _videosState extends State<videos> {
  _videosState(this.classroomId,this.username);
  String classroomId;
  String username;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              child: StreamBuilder(
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
            )));
  }
}



class documents extends StatefulWidget {
  documents(this.classroomId);
  String classroomId;
  @override
  _documentsState createState() => _documentsState(classroomId);
}

class _documentsState extends State<documents> {
  _documentsState(this.classroomId);
  String classroomId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
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
            )));
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
          borderRadius: BorderRadius.circular(10.0),
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
//                  ListTile(
//                    leading:Icon(Icons.picture_as_pdf,color: Colors.red,) ,
//                    title: Text(documentTitle),
//                  ),
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
                Center(
                  child: Container(
                    child: ListTile(
                      leading:Text("$time") ,
                      trailing: Text("$date"),

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
                      leading:Text("$time") ,
                      trailing: Text("$date"),
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
    return Center(
      child: Container(
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
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.2,
                      child: Container(
                         // child: VideoPlayer(_controller),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height*0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.grey,
                        ),),
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width ,
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
                  width: MediaQuery.of(context).size.width*0.8,
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
                    child: const Text(''),
                  ),
                  FlatButton(
                    child: const Text('Share'),
                    onPressed: () { /* ... */ },
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



