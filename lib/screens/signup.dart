import 'package:eclass/screens/home.dart';
import 'package:eclass/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:eclass/styles.dart';
import 'package:eclass/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';



class signup_page extends StatefulWidget {
  @override
  _signup_pageState createState() => _signup_pageState();
}

class _signup_pageState extends State<signup_page> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  SharedPreferences prefs;
  String email_value;
  String password_value;
  String username_value;
  String c_password_value;
  FirebaseUser currentUser;

  @override
  Widget build(BuildContext context) {

    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body:ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            color:primaryColor,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      color: primaryColor,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Text(
                            'Sign Up',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'lemonada',
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment(1.0,1.0),
//                      height: MediaQuery.of(context).size.height *0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(60.0),topRight: Radius.circular(60.0)),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 30.0),

                            //username
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                label("Username"),
                                SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: kBoxDecorationStyle,
                                  height: 60.0,
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    style: textFieldStyle,
                                    decoration: textFieldInputDecoration_username,
                                    onChanged: (value){
                                      username_value = value;
                                    },
                                  ),
                                ),
                              ],
                            ),



                            SizedBox(height: 30.0),

                            //email
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                label("Email"),
                                SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: kBoxDecorationStyle,
                                  height: 60.0,
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    style: textFieldStyle,
                                    decoration: textFieldInputDecoration_email,
                                    onChanged: (value){
                                      email_value = value;
                                    },
                                  ),
                                ),
                              ],
                            ),


                            SizedBox(height: 30.0),

                            //password
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                label("Password"),
                                SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: kBoxDecorationStyle,
                                  height: 60.0,
                                  child: TextField(
                                    obscureText: true,
                                    keyboardType: TextInputType.emailAddress,
                                    style: textFieldStyle,
                                    decoration: textFieldInputDecoration_password,
                                    onChanged: (value){
                                      password_value =value;
                                    },
                                  ),
                                ),
                              ],
                            ),


                            SizedBox(height: 30.0,),

                            //confirm-password
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                label("Confirm Password"),
                                SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  decoration: kBoxDecorationStyle,
                                  height: 60.0,
                                  child: TextField(
                                    onChanged: (value){
                                      c_password_value = value;
                                    },
                                    obscureText: true,
                                    keyboardType: TextInputType.emailAddress,
                                    style: textFieldStyle,
                                    decoration: textFieldInputDecoration_confirmPassword,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 50.0,),

                            //Sign up button
                            GestureDetector(
                                onTap: ()async{
                                  setState(() {
                                    showSpinner=true;
                                  });
                                  try{
                                    final newuser = await _auth.createUserWithEmailAndPassword(email: email_value, password: password_value);
                                    if(newuser != null){
                                      final QuerySnapshot result =
                                      await Firestore.instance.collection('users').where('email', isEqualTo: email_value).getDocuments();
                                      final List<DocumentSnapshot> documents = result.documents;
                                      if (documents.length == 0) {
                                        // Update data to server if new user
                                        Firestore.instance.collection('users').document(email_value).setData({
                                          'username': username_value,
//                                          'photoUrl': firebaseUser.photoUrl,
                                          'email': email_value,
//                                          'createdAt': DateTime.now().millisecondsSinceEpoch.toString(),
//                                          'chattingWith': null
                                        });

                                        // Write data to local
//                                        currentUser = newuser;
//                                        await prefs.setString('email', email_value);
//                                        await prefs.setString('username', username_value);
//                                        await prefs.setString('photoUrl', currentUser.photoUrl);
                                      } else {
//                                        // Write data to local
//                                        await prefs.setString('id', documents[0]['id']);
//                                        await prefs.setString('nickname', documents[0]['nickname']);
//                                        await prefs.setString('photoUrl', documents[0]['photoUrl']);
//                                        await prefs.setString('aboutMe', documents[0]['aboutMe']);
                                      }






                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Home_page(email_value,username_value)));
                                    }
                                    setState(() {
                                      showSpinner=false;
                                    });
                                  }
                                  catch(e){
                                    print(e);
                                  }
                                },
                                child: SubmitButtons("Sign Up",signUpButtonStyle)),

                            SizedBox(height: 20.0,),

                            FlatButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => login_page()));
                              },
                              child: Text("Already have an account",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 20.0,
                                ),),
                            ),

                            SizedBox(height: 20.0,),

//                            FlatButton(
//                              onPressed: ()async{
//
//                                GoogleSignInAccount googleUser = await googleSignIn.signIn();
//                                GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//                                final AuthCredential credential = GoogleAuthProvider.getCredential(
//                                  accessToken: googleAuth.accessToken,
//                                  idToken: googleAuth.idToken,
//                                );
//                                FirebaseUser firebaseUser = (await _auth.signInWithCredential(credential)).user;
//                              },
//                              child: Text("SignIn with Google",
//                                style: TextStyle(
//                                  color: primaryColor,
//                                  fontSize: 20.0,
//                                ),),
//                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}