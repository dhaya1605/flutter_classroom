import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eclass/styles.dart';
import 'package:eclass/menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:full_screen_menu/full_screen_menu.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:eclass/imagepickerPage.dart';
import 'package:video_player/video_player.dart';
import 'notes_own_classroom_page.dart';
import 'chewie_video.dart';






class own_classroom_page extends StatefulWidget {
  own_classroom_page(this.bgColor,this.email,this.username,this.classroomId);
  Color bgColor;
  String classroomId;
  String username;
  String email;


  @override
  _own_classroom_pageState createState() => _own_classroom_pageState(bgColor,email,username,classroomId);
}

class _own_classroom_pageState extends State<own_classroom_page> {
  _own_classroom_pageState(this.bgColor,this.email,this.username,this.classroomId);
  Color bgColor;
  String classroomId;
  String username;
  String email;
  String newMessage;
  File _imageFile;
  String public_imagepath;
  String imageDownloadUrl;
  final _auth = FirebaseAuth.instance;


  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://e-class-4abc6.appspot.com/');

  StorageUploadTask _uploadTask;

  File image;

  void _settingModalBottomSheetForPhoto(context){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc){
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.filter),
                    title: new Text('Upload from Gallery'),
                    onTap: () => {
                      _pickImage(ImageSource.gallery),

                    },
                ),
                new ListTile(
                    leading: new Icon(Icons.add_photo_alternate),
                    title: new Text('Capture a Photo'),
                    onTap: () => {
                      _pickImage(ImageSource.camera),
                    }
                ),
                new ListTile(
                  leading: new Icon(Icons.videocam),
                  title: new Text('Upload a Video'),
                  onTap: () => {
                    _pickVideo(ImageSource.camera),
                  },
                ),
              ],
            ),
          );
        }
    );
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
//            Navigator.push(context, MaterialPageRoute(builder: (context)=>own_notes_page(classroomId,email,username,bgColor)));
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

  _imagePageNavigation(BuildContext context)async{
    final String imagepath = await Navigator.push(context, MaterialPageRoute(builder: (context)=>imagepickerPage(_imageFile,classroomId,email)));

  }

  _videoPageNavigation(BuildContext context)async{
    final String videopath = await Navigator.push(context, MaterialPageRoute(builder: (context)=>videopickerpage(_imageFile,classroomId,email)));

  }

//  storingImagePath(String imagepath)async{
//    if(imagepath !=null){
//      await Firestore.instance.collection('classrooms').document(classroomId).collection('contents').document().setData({
//        'sender' :email,
//        'message' : "new message",
//        'image' : public_imagepath,
//      });
//    }
//  }

  void showCenterShortToast() {
    Fluttertoast.showToast(
        msg: "Updated",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1);
  }

//  Future imageDownloadLink()async{
//    String imageAddress = await _storage.ref().child(public_imagepath).getDownloadURL();
//    setState(() {
//      imageDownloadUrl = imageAddress;
//    });
//  }

  Future<void> _pickImage(ImageSource source) async{
    File selectedImage =await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile =selectedImage;
    });
    if(_imageFile !=null){
      _imagePageNavigation(context);
    }
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
    var mWidth = MediaQuery.of(context).size.width;
    var mHeight =MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Theory of Computation",style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: (){
              showFullScreenMenu(context);
            },
          ),
        ],
        backgroundColor: bgColor,
        iconTheme: new IconThemeData(color: Colors.white),
      ),
//      drawer: Drawer(
//        semanticLabel: 'More',
//        child: ListView(
//          children: <Widget>[
//            UserAccountsDrawerHeader(
//              decoration: BoxDecoration(
//                color: Colors.white,
//              ),
//              currentAccountPicture: CircleAvatar(
//                radius: 50.0,
//                child: ClipOval(
//                    child: Text("T",
//                      style: TextStyle(
//                        color: Colors.white,
//                      ),)
//                ),
//                backgroundColor: bgColor,
//              ),
//              accountName: Padding(
//                padding: const EdgeInsets.only(top:20.0,left:8.0),
//                child: Text("Theory of Computation",
//                  style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                    fontSize: 20.0,
//                    fontFamily: 'lemonada',
//                    color: Colors.black,
//                  ),),
//              ),
//              accountEmail: Padding(
//                padding: const EdgeInsets.only(left:10.0),
//                child: Text("Room-Id",//loggedInUser.email,
//                  style: TextStyle(
//                    fontSize: 13.0,
//                    fontFamily: 'lemonada',
//                    color: Colors.black,
//                  ),),
//              ),
//            ),
//            ListTile(
//              title: Text("Staff"),
//              subtitle: Text("StaffName"),
//              trailing: Icon(Icons.person,color: bgColor,),
//              onTap: (){
////                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_page()));
//              },
//            ),
//            Divider(),
//            ListTile(
//              title: Text("Class Strength"),
//              subtitle: Text("50"),
//              trailing: Icon(Icons.supervisor_account,color: bgColor,),
//              onTap: (){
////                Navigator.push(context, MaterialPageRoute(builder: (context)=>own_classroom()));
//              },
//            ),
//            Divider(),
//            ListTile(
//              title: Text("Share"),
//              subtitle: Text("Your Room-Id"),
//              trailing: Icon(Icons.share,color: bgColor,),
//            ),
//            Divider(),
//          ],
//        ),
//      ),


      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom:10.0),
        child: SpeedDial(
          child: Icon(Icons.add),
          backgroundColor: bgColor,
          closeManually: true,
          children: [
            SpeedDialChild(
              child: Icon(Icons.message),
              label: 'Add a message',
              onTap: (){
                showDialog(
                  context: context,
                  builder:(BuildContext context)=>Container(
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      content: Container(
                        height: MediaQuery.of(context).size.width * 0.5,
                        width: MediaQuery.of(context).size.height * 0.8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text("Message to the students",
                              style: TextStyle(
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                                fontWeight: FontWeight.bold,
                                color: secondaryColor,
                              ),),
                            Container(
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
                                            newMessage=value;
                                          });

                                        },
                                        textAlign: TextAlign.center,
                                        maxLines: null,
                                        decoration: InputDecoration(
                                          hintText: "Type here......",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            RaisedButton(
                              onPressed: () async{
                                await Firestore.instance.collection('classrooms').document(classroomId).collection('contents').document().setData({
                                  'sender' : email,
                                  'message':newMessage,
                                });
                                showCenterShortToast();
                              },
                              color: secondaryColor,
                              textColor: Colors.white,
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Text("Send"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.note_add),
              label: 'Add a Document',
              onTap: (){
//                _settingModalBottomSheet(context);
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.add_photo_alternate),
              label: 'Add a Photo',
              onTap: (){
                _settingModalBottomSheetForPhoto(context);
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.video_library),
              label: 'Add a Video',
              onTap: (){},
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
//          Expanded(
//            child: ListView(
//              children: <Widget>[
//                SizedBox(
//                  height: MediaQuery.of(context).size.height * 0.05,
//                ),
//                StreamBuilder(
//                    stream: Firestore.instance.collection('classrooms').document(classroomId).collection('contents').snapshots(),
//                    builder: (context,snapshot) {
//                      if (!snapshot.hasData) {
//                        return Center(
//                          child: CircularProgressIndicator(),
//                        );
//                      } else {
//                        //listItem = snapshot.data.documents;
//                        List<Widget> message_widgets = [];
//                        final classes = snapshot.data.documents;
//                        for(var Class in classes){
//                          String sender = Class.data['sender'];
//                          String message = Class.data['message'];
//                          String imageFile = Class.data['image'];
//                          String imagePath = Class.data['imagepath'];
//                          String videoFile = Class.data['video'];
//                          String videoPath = Class.data['videopath'];
//                          if(imageFile != null && videoFile == null) {
//
//
//                            final imageWidget = image_Card(imagePath,message);
//                            message_widgets.add(imageWidget);
//
//
//                          }
//                          else if(videoPath != null){
//                            final videoWidget = video_Card(videoPath);
//                            message_widgets.add(videoWidget);
//                          }
//                          else{
//                            final classCardWidget = classes_card(username: sender,class_id: message,);
//                            message_widgets.add(classCardWidget);
//                          }
//
//                        }
//                        return Column(
//                          children: message_widgets,
//                        );
//                      }
//                    }),
//                SizedBox(
//                  height: MediaQuery.of(context).size.height * 0.05,
//                ),],
//            ),
//          ),
        ],
      ),
    );
  }
}



class classes_card extends StatelessWidget {
  const classes_card({
    Key key,
    @required this.username,
    @required this.class_id,
    @required this.class_name,
  }) : super(key: key);

  final String username;
  final String class_name;
  final String class_id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
            ),
            Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    color:gradienColor[4][0],
//                        gradient: LinearGradient(
//                            begin: Alignment.topLeft,
//                            end: Alignment.bottomRight,
//                            colors: [gradienColor[4][0],gradienColor[4][1]]),
                    borderRadius: BorderRadius.only( topRight: Radius.circular(20.0),bottomLeft:Radius.circular(20.0),bottomRight: Radius.circular(20.0), ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:20.0,horizontal: 20.0),
                  child: Text(class_id,style: TextStyle(color: Colors.white),),
                ),
                ),
              ],
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


class image_Card extends StatelessWidget {
  image_Card(this.image,this.message);
  String image;
  String message;
  @override
  Widget build(BuildContext context) {
    if(image == null){
      return Container();
    }
    else{
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width: MediaQuery.of(context).size.width * 0.05,),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color:gradienColor[4][0],
                borderRadius: BorderRadius.only( topRight: Radius.circular(20.0),bottomLeft:Radius.circular(20.0),bottomRight: Radius.circular(20.0), ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                    offset: Offset(0, 1),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(image),
                  fit: BoxFit.cover
                )
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        )
      ],
    );}
  }
}


class video_Card extends StatelessWidget {
  video_Card(this.videopath);
  String videopath;
  @override
  Widget build(BuildContext context) {
    return Container(
      child:ChewieListItem(
        videoPlayerController: VideoPlayerController.network(
          videopath,
        ),
      ),
    );
  }
}
