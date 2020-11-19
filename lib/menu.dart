import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eclass/styles.dart';
import 'screens/home.dart';
import 'screens/login_page.dart';
import 'screens/own_classrooms.dart';
import 'screens/profile.dart';

class menu extends StatelessWidget {
  const menu({
    Key key,
    this.username,
    this.email,
    this.loggedInUser,
    this.colour,
    @required FirebaseAuth auth,

  }) : _auth = auth, super(key: key);

  final String username;
  final String email;

  final FirebaseUser loggedInUser;
  final FirebaseAuth _auth;
  final bool colour;


  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: 'More',
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>info(email)));
            },
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              currentAccountPicture: CircleAvatar(
                radius: 50.0,
                child: ClipOval(
                    child: Text("D",
                      style: TextStyle(
                        color: Colors.white,
                      ),)
                ),
                backgroundColor: colour?primaryColor:secondaryColor,
              ),
              accountName: Padding(
                padding: const EdgeInsets.only(top:24.0,left: 10.0),
                child: Text("$username",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    fontFamily: 'lemonada',
                    color: Colors.black,
                  ),),
              ),
              accountEmail: Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: Text("$email",//loggedInUser.email,
                  style: TextStyle(
                    fontSize: 13.0,
                    fontFamily: 'lemonada',
                    color: Colors.black,
                  ),),
              ),
            ),
          ),
          ListTile(
            title: Text("Home"),
            subtitle: Text("Classes you have Joined"),
            trailing: Icon(Icons.home,color: colour?primaryColor:secondaryColor,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_page(email,username)));
            },
          ),
          Divider(),
          ListTile(
            title: Text("Classrooms"),
            subtitle: Text("You have Created"),
            trailing: Icon(Icons.laptop,color: colour?primaryColor:secondaryColor,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>own_classroom(username,email)));
            },
          ),
          Divider(),
          ListTile(
            title: Text("Settings"),
            trailing: Icon(Icons.settings,color:colour? primaryColor:secondaryColor,),
          ),
          Divider(),
          ListTile(
            title: Text("Log Out"),
            trailing: Icon(Icons.power_settings_new,color:colour? primaryColor:secondaryColor,),
            onTap: (){
              _auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}