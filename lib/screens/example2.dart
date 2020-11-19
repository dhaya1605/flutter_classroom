import 'package:flutter/material.dart';
import 'notes_own_classroom_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'chewie_video.dart';
import 'dart:async';
import 'dart:io';
import 'package:eclass/imagepickerPage.dart';




class example2 extends StatefulWidget {
  @override
  _example2State createState() => _example2State();
}

class _example2State extends State<example2> {
  String username ='dhaya';
  String email = 'dhaya2000@icloud.com';
  String classroomId = 'EOMQ1';
  File _imageFile;
  bool isVideo = false;

  VideoPlayerController _controller;
  String _retrieveDataError;



  Future<void> _playVideo(File file) async {
    if (file != null && mounted) {
      await _disposeVideoController();
      _controller = VideoPlayerController.file(file);
      await _controller.setVolume(1.0);
      await _controller.initialize();
      await _controller.setLooping(false);
      await _controller.play();
      setState(() {});
    }
  }


  Future<void> _disposeVideoController() async {
    if (_controller != null) {
      await _controller.dispose();
      _controller = null;
    }
  }



  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    if (_controller != null) {
      await _controller.setVolume(0.0);
    }
    if (isVideo) {
      final File file = await ImagePicker.pickVideo(
          source: source, maxDuration: const Duration(seconds: 10));
      await _playVideo(file);
    }
  }



  Future<void> _pickVideo(ImageSource source) async{
    File selectedImage =await ImagePicker.pickVideo(source: source);
    setState(() {
      _imageFile =selectedImage;
    });
    if(_imageFile !=null){
      _imagePageNavigation(context);
    }
  }

  _imagePageNavigation(BuildContext context)async{
//    final String imagepath = await Navigator.push(context, MaterialPageRoute(builder: (context)=>imagepickerPage(image,classroomId,email)));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          onPressed: () {
            isVideo = false;
            _onImageButtonPressed(ImageSource.gallery, context: context);
          },
          heroTag: 'image0',
          tooltip: 'Pick Image from gallery',
          child: const Icon(Icons.photo_library),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: () {
              isVideo = true;
              _onImageButtonPressed(ImageSource.camera);
            },
            heroTag: 'video1',
            tooltip: 'Take a Video',
            child: const Icon(Icons.videocam),
          ),
        ),
      ],
    ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: <Widget>[
//              StreamBuilder(
//                  stream: Firestore.instance.collection('users').document(email).collection('own_class').snapshots(),
//                  builder: (context,snapshot) {
//                    if (!snapshot.hasData) {
//                      return Center(
//                        child: CircularProgressIndicator(),
//                      );
//                    } else {
//                      //listItem = snapshot.data.documents;
//                      List<Widget> classes_widgets = [];
//                      final classes = snapshot.data.documents;
//                      for(var Class in classes){
//                        String classroom_name = Class.data['classroom_name'];
//                        String classroom_id = Class.data['classroom_id'];
//                        String classroom_author = username;
//                        final classCardWidget = classes_card(username: classroom_author,class_id: classroom_id,class_name: classroom_name,email:email);
//                        classes_widgets.add(classCardWidget);
//                      }
//                      return Column(
//                        children: classes_widgets,
//                      );
//                    }
//                  }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


