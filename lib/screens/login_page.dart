import 'package:eclass/main.dart';
import 'package:eclass/screens/example.dart';
import 'package:eclass/screens/home.dart';
import 'package:eclass/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eclass/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


Alignment topRight = Alignment(0.9, -1.0);


class login_page extends StatefulWidget {
  @override
  _login_pageState createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email_value;
  String password_value;
  GoogleSignIn googleSignIn = GoogleSignIn();

//  Future<FirebaseUser> googleSignInMethod() async{
//    GoogleSignInAccount googleUser =await googleSignIn.signIn();
//    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//                              FirebaseUser user = await auth2.signInWithGoogle(
//                                accessToken: googleAuth.accessToken,
//                                idToken : googleAuth.idToken
//                              );
//  }






//  signInWithGoogle() async{
//    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
//    final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
//    final AuthResult authResult = await _auth.signInWithCredential(credential);
//    final FirebaseUser user = authResult.user;
//    String data = user.displayName;
//    print("$data");
//  }


  @override
  Widget build(BuildContext context) {

    var mWidth = MediaQuery.of(context).size.width;
    var mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body:ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[




                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  color: primaryColor,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Text(
                          'Sign In',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'lemonada',
                            fontSize: MediaQuery.of(context).size.height * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: MediaQuery.of(context).size.height * 0.02,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),






                Container(
                  color: primaryColor,
                  child: Container(
                    alignment: Alignment(1.0,1.0),
//                  height: MediaQuery.of(context).size.height *0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(60.0),topRight: Radius.circular(60.0)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 30.0),
                          Container(
                            width: double.infinity,
                            height: 150.0,
                            child: Image.asset('images/log-pic.jpg'),
                          ),
                          SizedBox(height: 30.0),





                          //email_textfield
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              label("E-Mail Id"),
                              SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: kBoxDecorationStyle,
                                height: 60.0,
                                child: TextField(
                                  onChanged: (value){
                                    email_value = value;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  style: textFieldStyle,
                                  decoration: textFieldInputDecoration_email,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.0,),






                          //password_textfield
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
                                  onChanged: (value){
                                    password_value=value;
                                  },
                                  obscureText: true,
                                  keyboardType: TextInputType.emailAddress,
                                  style: textFieldStyle,
                                  decoration: textFieldInputDecoration_password,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30.0,),







                          //Login button
                          Builder(
                            builder:(context)=> GestureDetector(
                                onTap: ()async{
                                  setState(() {
                                    showSpinner=true;
                                  });
                                  try{
                                    final user =await _auth.signInWithEmailAndPassword(email: email_value, password: password_value);
                                    if(user != null){

                                      final QuerySnapshot result =
                                      await Firestore.instance.collection('users').where('email', isEqualTo: email_value).getDocuments();
                                      final List<DocumentSnapshot> documents = result.documents;
                                      final doc_username = documents[0]['username'];

                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_page(email_value,doc_username)));
                                    }
                                    setState(() {
                                      showSpinner=false;
                                    });
                                  }
                                  catch(e){
                                    setState(() {
                                      showSpinner=false;
                                    });
                                    final snackBar = SnackBar(
                                      content: Text('Invalid Email-Id or Password',style: TextStyle(fontSize: 20.0),),
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
                                child: SubmitButtons("Login",loginButtonStyle)),
                          ),
                          SizedBox(height: 20.0,),







                          //forgot password
                          FlatButton(
                            child: Text("Forgot Password?",
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 20.0,
                              ),),
                          ),

                          SizedBox(height: 20.0,),

                          //create a new account button
                          GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => signup_page()));
                              },
                              child: SubmitButtons("Create a new account",signUpButtonStyle)),






                          SizedBox(height: 20.0,),
                          GestureDetector(
                            onTap: ()async{
//                              GoogleSignInAccount googleUser =await googleSignIn.signIn();
//                              GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//                              FirebaseUser user = await _auth.signInWithGoogle(
//                                accessToken: googleAuth.accessToken,
//                                idToken : googleAuth.idToken
//                              );

//                              Firestore.instance.collection('users').document(email_value).setData({
//                                'username': '',
////
//                                'email': '',
////
//                              });
                            //signInWithGoogle();

                            },
                            child: ListTile(
                              trailing: Icon(Icons.g_translate),
                              title: Text("Google SignIn"),
                            ),
                          ),
                        ],
                      ),
                    ),
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


//class Login extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home:login_card()
//    );
//  }
//}
//
//class login_card extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body:GestureDetector(
//        onTap: () => FocusScope.of(context).unfocus(),
//        child: Container(
//          color:primaryColor,
//          height: double.infinity,
//          child: SingleChildScrollView(
//            physics: AlwaysScrollableScrollPhysics(),
//            child: SafeArea(
//              child: Column(
//                children: <Widget>[
//                  Container(
//                    height: MediaQuery.of(context).size.height * 0.1,
//                    color: primaryColor,
//                    width: MediaQuery.of(context).size.width,
//                    child: Padding(
//                      padding: EdgeInsets.only(top:5.0,bottom: 10.0),
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          Text(
//                            'Sign In',
//                            textAlign: TextAlign.start,
//                            style: TextStyle(
//                              color: Colors.white,
//                              fontFamily: 'OpenSans',
//                              fontSize: 40.0,
//                              fontWeight: FontWeight.bold,
//                            ),
//                          ),
//                          Text(
//                            'Welcome Back',
//                            style: TextStyle(
//                              color: Colors.white,
//                              fontFamily: 'OpenSans',
//                              fontSize: 20.0,
//                              fontWeight: FontWeight.bold,
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                  Container(
//                    alignment: Alignment(1.0,1.0),
//                    height: MediaQuery.of(context).size.height *0.9,
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.only(topLeft: Radius.circular(60.0),topRight: Radius.circular(60.0)),
//                      color: Colors.white,
//                    ),
//                    child: Padding(
//                      padding: EdgeInsets.all(20.0),
//                      child: Column(
//                        children: <Widget>[
//                          SizedBox(height: 30.0),
//                          Container(
//                            width: double.infinity,
//                            height: 150.0,
//                            child: Image.asset('images/log-pic.jpg'),
//                          ),
//                          SizedBox(height: 30.0),
//
//                          //email_textfield
//                          Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              label("Username"),
//                              SizedBox(height: 10.0),
//                              Container(
//                                alignment: Alignment.centerLeft,
//                                decoration: kBoxDecorationStyle,
//                                height: 60.0,
//                                child: TextField(
//                                  keyboardType: TextInputType.emailAddress,
//                                  style: textFieldStyle,
//                                  decoration: textFieldInputDecoration_username,
//                                ),
//                              ),
//                            ],
//                          ),
//                          SizedBox(height: 30.0,),
//
//                          //password_textfield
//                          Column(
//                            crossAxisAlignment: CrossAxisAlignment.start,
//                            children: <Widget>[
//                              label("Password"),
//                              SizedBox(height: 10.0),
//                              Container(
//                                alignment: Alignment.centerLeft,
//                                decoration: kBoxDecorationStyle,
//                                height: 60.0,
//                                child: TextField(
//                                  obscureText: true,
//                                  keyboardType: TextInputType.emailAddress,
//                                  style: textFieldStyle,
//                                  decoration: textFieldInputDecoration_password,
//                                ),
//                              ),
//                            ],
//                          ),
//                          SizedBox(height: 30.0,),
//
//                          //Login button
//                          GestureDetector(
//                              onTap: (){
//                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_page()));
//                              },
//                              child: SubmitButtons("Login",loginButtonStyle)),
//                          SizedBox(height: 20.0,),
//
//                          //forgot password
//                          FlatButton(
//                            child: Text("Forgot Password?",
//                              style: TextStyle(
//                                color: primaryColor,
//                                fontSize: 20.0,
//                              ),),
//                          ),
//
//                          SizedBox(height: 20.0,),
//
//                          //create a new account button
//                          GestureDetector(
//                              onTap: (){
//                                Navigator.push(context, MaterialPageRoute(builder: (context) => signup_page()));
//                              },
//                              child: SubmitButtons("Create a new account",signUpButtonStyle)),
//                        ],
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}



