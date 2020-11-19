import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_orientation/auto_orientation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class VideoPlayerApp extends StatelessWidget {
  VideoPlayerApp(this.videoLink,this.sender,this.ClassroomId,this.videoFile);
  String videoLink;
  String sender;
  String videoFile;String ClassroomId;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player Demo',
      home: VideoPlayerScreen(videoLink,sender,ClassroomId,videoFile),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen(this.videoLink,this.sender,this.ClassroomId,this.videoFile);
  String videoLink;
  String sender;
  String videoFile;String ClassroomId;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState(videoLink,sender,ClassroomId,videoFile);
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  _VideoPlayerScreenState(this.videoLink,this.sender,this.ClassroomId,this.videoFile);
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  Duration position ;
  int atmin;
  int athr;
  int atsec;
  String videoFile;String ClassroomId;

  bool backFromFullScreen = true;
  bool _visible = false;
  double volume = 0.7;
  String videoLink;
  String sender;
  var message;
  var tc = TextEditingController();
  int Cday;
  int Cyear;
  int Cmonth;
  String Cdate;
  int hour;
  int minute;
  String twelve;
  String time;
  int thour;








  @override
  void initState() {



    _controller = VideoPlayerController.network(
      '$videoLink',
    );

    // Initialize the controller and store the Future for later use.

    _initializeVideoPlayerFuture = _controller.initialize();



    // Use the controller to loop the video.
    _controller.setLooping(true);
    _controller.setVolume(volume);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    AutoOrientation.portraitAutoMode();

    super.dispose();

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: backFromFullScreen?
        Column(
          children: <Widget>[
            FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  int possec = _controller.value.position.inSeconds;
                  int posmin= _controller.value.position.inMinutes;
                  int poshr = _controller.value.position.inHours;
                  Duration total = _controller.value.duration;
                  int tmin = total.inMinutes;
                  int thr = total.inHours;
                  int tsec = total.inSeconds;

                  // If the VideoPlayerController has finished initialization, use
                  // the data it provides to limit the aspect ratio of the video.
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Stack(
                      children: <Widget>[
                        VideoPlayer(_controller),
                        Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.07,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.01,
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(1),
                                        color: Colors.white70,
                                      ),
                                      child: Text(poshr>0?"$poshr:$posmin:$possec" : "$posmin:$possec")),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.05,
                                  ),
                                  Flexible(fit:FlexFit.loose,
                                      child: VideoProgressIndicator(_controller,allowScrubbing: true,colors: VideoProgressColors(playedColor: Colors.orangeAccent,backgroundColor: Colors.white70,bufferedColor: Colors.grey),)),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.05,
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(1),
                                        color: Colors.white70,
                                      ),
                                      child: Text(thr>0?"$thr:$tmin:$tsec":"$tmin:$tsec")),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.01,
                                  ),
                                ],
                              ),
                            )),
                        Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.01,
                            left: MediaQuery.of(context).size.width * 0.03,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    // Call setState. This tells Flutter to rebuild the
                                    // UI with the changes.
                                    setState(() {
                                      _visible = !_visible;
                                    });
                                  },
                                  child: Container(
//                                    width: MediaQuery.of(context).size.width * 0.1,
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _visible = !_visible;
                                          });
                                        },
                                        child: Icon(Icons.volume_up,size: MediaQuery.of(context).size.height * 0.04,)),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.2,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      GestureDetector(
                                          onTap:(){
                                            _controller.seekTo(Duration(seconds:_controller.value.position.inSeconds -5));
                                          },
                                          child: Icon(Icons.fast_rewind,size: MediaQuery.of(context).size.height * 0.04,)),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.05,
                                      ),
                                      GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              // If the video is playing, pause it.
                                              if (_controller.value.isPlaying) {
                                                _controller.pause();
                                              } else {
                                                // If the video is paused, play it.
                                                _controller.play();
                                              }
                                            });
                                          },
                                          child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow,size: MediaQuery.of(context).size.height * 0.05,)),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.05,
                                      ),
                                      GestureDetector(
                                          onTap:(){
                                            _controller.seekTo(Duration(seconds:_controller.value.position.inSeconds +5));
                                          },
                                          child: Icon(Icons.fast_forward,size: MediaQuery.of(context).size.height * 0.04,)),
                                    ],
                                  ),
                                ),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.175,),
                                GestureDetector(
                                  onTap:(){
                                    setState(() {
                                      athr=thr;
                                      atmin=tmin;
                                      atsec=tsec;

                                      backFromFullScreen = false;
                                      AutoOrientation.landscapeAutoMode();
                                    });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.1,
                                    decoration: BoxDecoration(
                                      color: Colors.white70,
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[

                                        Icon(Icons.fullscreen,size: MediaQuery.of(context).size.height * 0.04,),

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Positioned(
                          bottom: MediaQuery.of(context).size.height * 0.16,
                          left: -MediaQuery.of(context).size.width * 0.13,
                          child: Container(
//                                    width: MediaQuery.of(context).size.width * 0.1,

                            child: Transform.rotate(
                              angle :4.72,
                              child: AnimatedOpacity(
                                opacity:  _visible? 1.0 : 0.0,
                                duration: Duration(milliseconds: 200),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      inactiveTrackColor: Color(0xFF8D8E98),
                                      activeTrackColor: Colors.orangeAccent,
                                      thumbColor: Colors.orangeAccent,
                                      overlayColor: Color(0x29EB1555),
                                      thumbShape:
                                      RoundSliderThumbShape(enabledThumbRadius: 6.0),
                                      overlayShape:
                                      RoundSliderOverlayShape(overlayRadius: 7.0),
                                    ),
                                    child: Slider(
                                      value: volume,
                                      min: 0.0,
                                      max: 1.0,
                                      onChanged: (double newValue){
                                        setState(() {
                                          volume = newValue;
                                          _controller.setVolume(volume);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      overflow: Overflow.visible,
                    ),
                  );
                } else {
                  // If the VideoPlayerController is still initializing, show a
                  // loading spinner.
                  return Container(
                    height: MediaQuery.of(context).size.height *0.4,
                      child: Center(child: CircularProgressIndicator()));
                }
              },
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.52,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                  stream: Firestore.instance.collection('classrooms').document(ClassroomId).collection('contents').document(videoFile).collection('chats').orderBy('utc').snapshots(),
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
                        String sender1 = Class.data['sender'];
                        String message = Class.data['message'];
                        String time = Class.data['time'];
                        if(sender1 == sender){
                          final studentWidget = student_msg(sender1,message,time);
                          message_widgets.add(studentWidget);
                        }
                        else{
                          final staffWidget = staff_msg(sender1,message,time);
                          message_widgets.add(staffWidget);
                        }

                      }
                      return ListView(
                        children: message_widgets,
                        reverse: true,
                      );
                    }
                  }),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
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
                          hintText: "Feel free to ask ur doubts",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()async{
                      if(message != null) {
                        tc.clear();
                        Cday = DateTime.now().day;
                        Cmonth = DateTime.now().month;
                        Cyear = DateTime.now().year;
                        Cdate = "$Cday-$Cmonth-$Cyear";
                        hour = DateTime.now().hour;
                        minute = DateTime.now().minute;
                        twelve = hour>12 ? "pm":"am";
                        thour = hour>12 ? hour-12 : hour;
                        time = "$thour:$minute $twelve";
                        await Firestore.instance.collection('classrooms')
                            .document(ClassroomId).collection('contents')
                            .document(videoFile).collection('chats').document()
                            .setData({
                          'sender': sender,
                          'message': message,
                          'utc' : DateTime.now(),
                          'date':Cdate,
                          'time' : time,
                        });

                        setState(() {
                          message = null;
                        });

                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width *0.2,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: Center(child:Icon(Icons.send,color: Colors.white,)),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
            : Container(
          color: Colors.black,
          child: Center(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.9,
                    child:Stack(
                      children: <Widget>[
                        VideoPlayer(_controller),
                        Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.1,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.01,
                                  ),

                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.05,
                                  ),
                                  Flexible(fit:FlexFit.loose,
                                      child: VideoProgressIndicator(_controller,allowScrubbing: true,colors: VideoProgressColors(playedColor: Colors.orangeAccent,backgroundColor: Colors.white70,bufferedColor: Colors.grey),)),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.05,
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(1),
                                        color: Colors.white70,
                                      ),
                                      child: Text(athr>0?"$athr:$atmin:$atsec":"$atmin:$atsec")),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.01,
                                  ),
                                ],
                              ),
                            )),
                        Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.01,
                            left: MediaQuery.of(context).size.width * 0.03,
                            child: GestureDetector(
                              onTap: () {
                                // Call setState. This tells Flutter to rebuild the
                                // UI with the changes.
                                setState(() {
                                  _visible = !_visible;
                                });
                              },
                              child: Container(
//                                    width: MediaQuery.of(context).size.width * 0.1,
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _visible = !_visible;
                                      });
                                    },
                                    child: Icon(Icons.volume_up,size: MediaQuery.of(context).size.height * 0.07,)),
                              ),
                            )),
                        Positioned(
                          bottom: MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.width * 0.37,
                          child: Container(
//                                    width: MediaQuery.of(context).size.width * 0.4,
                            decoration: BoxDecoration(
                              color: Colors.white70,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                GestureDetector(
                                    onTap:(){
                                      _controller.seekTo(Duration(seconds:_controller.value.position.inSeconds -5));
                                    },
                                    child: Icon(Icons.fast_rewind,size: MediaQuery.of(context).size.height * 0.07,)),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.05,
                                ),
                                GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        // If the video is playing, pause it.
                                        if (_controller.value.isPlaying) {
                                          _controller.pause();
                                        } else {
                                          // If the video is paused, play it.
                                          _controller.play();
                                        }
                                      });
                                    },
                                    child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow,size: MediaQuery.of(context).size.height * 0.07,)),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.05,
                                ),
                                GestureDetector(
                                    onTap:(){
                                      _controller.seekTo(Duration(seconds:_controller.value.position.inSeconds +5));
                                    },
                                    child: Icon(Icons.fast_forward,size: MediaQuery.of(context).size.height * 0.07,)),
                              ],
                            ),
                          ),

                        ),
                        Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.01,
                            left: MediaQuery.of(context).size.width * 0.85,
                            child: GestureDetector(
                              onTap:(){
                                setState(() {
                                  backFromFullScreen = true;
                                  AutoOrientation.portraitAutoMode();
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Icon(Icons.fullscreen_exit,size: MediaQuery.of(context).size.height * 0.07,),
                              ),
                            )),
                        Positioned(
                          bottom: MediaQuery.of(context).size.height * 0.26,
                          left: -MediaQuery.of(context).size.width * 0.073,
                          child: Container(
//                                    width: MediaQuery.of(context).size.width * 0.1,

                            child: Transform.rotate(
                              angle :11,
                              child: AnimatedOpacity(
                                opacity:  _visible? 1.0 : 0.0,
                                duration: Duration(milliseconds: 200),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      inactiveTrackColor: Color(0xFF8D8E98),
                                      activeTrackColor: Colors.orangeAccent,
                                      thumbColor: Colors.orangeAccent,
                                      overlayColor: Color(0x29EB1555),
                                      thumbShape:
                                      RoundSliderThumbShape(enabledThumbRadius: 7.0),
                                      overlayShape:
                                      RoundSliderOverlayShape(overlayRadius: 9.0),
                                    ),
                                    child: Slider(
                                      value: volume,
                                      min: 0.0,
                                      max: 1.0,
                                      onChanged: (double newValue){
                                        setState(() {
                                          volume = newValue;
                                          _controller.setVolume(volume);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      overflow: Overflow.visible,
                    ),),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class staff_msg extends StatelessWidget {
  staff_msg(this.sender,this.message,this.time);
  String sender;
  String message;
  String time;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:5.0,bottom: 5.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                Container(
                  color: Colors.grey.shade300,
                    child: Text("$sender"),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              children: <Widget>[
                SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15.0),bottomRight: Radius.circular(15.0),bottomLeft: Radius.circular(15.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Padding(
                    padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 8.0,bottom: 8.0),
                    child: Text("$message",style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.height*0.027,
                    ),),
                  ),
                ),

              ],
            ),
            Row(
              children: <Widget>[
                SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                Text("$time",style: TextStyle(color: Colors.grey.shade600,fontSize: 12.0),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class student_msg extends StatelessWidget {
  student_msg(this.sender,this.message,this.time);
  String sender;
  String message;
  String time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  color: Colors.grey.shade300,
                    child: Text("$sender")),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02,),

              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),bottomRight: Radius.circular(15.0),bottomLeft: Radius.circular(15.0)),
                    color: Colors.orangeAccent,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orangeAccent,
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Padding(
                    padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 8.0,bottom: 8.0),
                    child: Text("$message",style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height*0.027,
                    ),),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text("$time",style: TextStyle(color: Colors.grey.shade600,fontSize: 12.0),),
                SizedBox(width: MediaQuery.of(context).size.width * 0.04,),

              ],
            ),
          ],
        ),
      ),
    );
  }
}



