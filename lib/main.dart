import 'dart:ui';
import 'package:eclass/screens/example.dart';
import 'package:eclass/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'styles.dart';


void main() => runApp(MaterialApp(
  home:login_page(),
));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Align(
                  alignment: downRight,
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: secondaryColor,
                    ),
                    child:Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 10.0),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ) ,
                  ),
                ),

                Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[

                        Container(
                          child: Image(
                            image: AssetImage('images/home.png'),
                          ),
                        ),
                        Text(
                          "E-Class",
                          style: TextStyle(
                            fontFamily: 'lemonada',
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),

                    Divider(
                      color: primaryColor,
                      thickness: 2.0,
                      indent: 40.0,
                      endIndent: 40.0,

                    ),

//                    Column(
//
//                      children: <Widget>[
//
//                        Padding(
//                          padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 20.0),
//
//                          child: Container(
//
//                            child: Text(
//                              "E-Classroom is a guided online classroom wherein teachers & students can log in from anywhere and anytime and do their classwork. ",
//                              style: TextStyle(
//                                fontFamily: 'marienda',
//                                fontSize: 20.0,
//                                fontWeight: FontWeight.normal,
//                              ),
//                              textAlign: TextAlign.justify,),),
//                        ),
//
//                      ],
//                    ),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=>signup_page()));
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: secondaryColor,
                        ),
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 10.0),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ) ,
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => login_page()));
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: primaryColor,
                        ),
                        child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0,vertical: 10.0),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ) ,
                      ),
                    ),
                  ],
                ),

                Text(
                  "Copytrights Portion",
                  style: TextStyle(
                    fontFamily: 'marienda',
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
      );

  }
}
