import 'package:eclass/assignment_details_pages/assignment_submissionList.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class assignment_details extends StatefulWidget {
  assignment_details(this.ATitle,this.classroomId);
  String classroomId;
  String ATitle;
  @override
  _assignment_detailsState createState() => _assignment_detailsState(ATitle,classroomId);
}

class _assignment_detailsState extends State<assignment_details> {
  _assignment_detailsState(this.ATitle,this.classroomid);
  String classroomid;
  String ATitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(

          label:Text("submissions"),
          icon:Icon(Icons.insert_drive_file),
        onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>assignment_submissionList(classroomid,ATitle)));
        },

      ),
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
                          stream: Firestore.instance.collection('classrooms').document(classroomid).collection('assignments').document(ATitle).snapshots(),
                          builder: (context,snapshot) {
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
                              final descWidget = contents('Assignment Description',desc);

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
                          stream: Firestore.instance.collection('classrooms').document(classroomid).collection('assignments').document(ATitle).snapshots(),
                          builder: (context,snapshot) {
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

                              final contentWidget = contents('Assignment Questions',content);

                              message_widgets.add(contentWidget);

                              return Column(
                                children: message_widgets,
                              );
                            }
                          }),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class contents extends StatelessWidget {
  contents(this.type,this.content);
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
                  Text("$content",style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height *0.03,
                  ),),
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
          borderRadius: BorderRadius.circular(10.0),
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