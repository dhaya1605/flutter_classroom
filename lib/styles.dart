import 'package:flutter/material.dart';
import 'main.dart';


const primaryColor = Color(0xffaf69a3);
const secondaryColor = Color(0xff828fe5);
Alignment downRight = Alignment(0.9, 1.0);



class textBar extends StatelessWidget {
  textBar(this.hint,this.color,this.password);
  String hint;
  Color color;
  bool password;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
        child: TextField(
          onChanged: (value){

          },
          textAlign: TextAlign.center,
          obscureText: password,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: color),
          ),
        ),
      ),
    );
  }
}

class label extends StatelessWidget {
  label(this.lName);
  String lName;

  @override
  Widget build(BuildContext context) {
    return Text(
      lName,
      style: kLabelStyle,
    );
  }
}

class SubmitButtons extends StatelessWidget {
  SubmitButtons(this.name,this.style);
  String name;
  final style;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: style,
        height: 60.0,
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        )
    );
  }
}

final kHintTextStyle = TextStyle(
  color: primaryColor,
  fontFamily: 'OpenSans',
);

final submitHintStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: primaryColor,
  fontWeight: FontWeight.bold,
  fontFamily: 'lemonada',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: primaryColor,
      blurRadius: 10.0,
      offset: Offset(0, 2),
    ),
  ],
);

final loginButtonStyle = BoxDecoration(
  color: primaryColor,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: primaryColor,
      blurRadius: 10.0,
      offset: Offset(0, 2),
    ),
  ],
);

final signUpButtonStyle = BoxDecoration(
  color: secondaryColor,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: secondaryColor,
      blurRadius: 10.0,
      offset: Offset(0, 2),
    ),
  ],
);

//Widget buildEmailTF() {
//  return Column(
//    crossAxisAlignment: CrossAxisAlignment.start,
//    children: <Widget>[
//      Text(
//        'Email',
//        style: kLabelStyle,
//      ),
//      SizedBox(height: 10.0),
//      Container(
//        alignment: Alignment.centerLeft,
//        decoration: kBoxDecorationStyle,
//        height: 60.0,
//        child: TextField(
//          keyboardType: TextInputType.emailAddress,
//          style: TextStyle(
//            color: Colors.black,
//            fontFamily: 'OpenSans',
//          ),
//          decoration: InputDecoration(
//            border: InputBorder.none,
//            contentPadding: EdgeInsets.only(top: 14.0),
//            prefixIcon: Icon(
//              Icons.email,
//              color: primaryColor,
//            ),
//            hintText: 'Enter your Email',
//            hintStyle: kHintTextStyle,
//          ),
//        ),
//      ),
//    ],
//  );
//}
//
//Widget buildPasswordTF() {
//  return Column(
//    crossAxisAlignment: CrossAxisAlignment.start,
//    children: <Widget>[
//      Text(
//        'Password',
//        style: kLabelStyle,
//      ),
//      SizedBox(height: 10.0),
//      Container(
//        alignment: Alignment.centerLeft,
//        decoration: kBoxDecorationStyle,
//        height: 60.0,
//        child: TextField(
//          obscureText: true,
//          style: TextStyle(
//            color: Colors.black,
//            fontFamily: 'OpenSans',
//          ),
//          decoration: InputDecoration(
//            border: InputBorder.none,
//            contentPadding: EdgeInsets.only(top: 14.0),
//            prefixIcon: Icon(
//              Icons.lock,
//              color: primaryColor,
//            ),
//            hintText: 'Enter your Password',
//            hintStyle: kHintTextStyle,
//          ),
//        ),
//      ),
//    ],
//  );
//}
//
//Widget Login_Button(){
//  return SubmitButtons("Login",loginButtonStyle);
//}



//Widget SignUp_Button(){
//  return Container(
//      alignment: Alignment.center,
//      decoration: signUpButtonStyle,
//      height: 60.0,
//      child: Text(
//        "Sign Up",
//        textAlign: TextAlign.center,
//        style: TextStyle(
//          color: Colors.white,
//          fontSize: 17.0,
//          fontWeight: FontWeight.bold,
//        ),
//      )
//  );
//}

final textFieldStyle = TextStyle(
color: Colors.black,
fontFamily: 'OpenSans',
);

final textFieldInputDecoration_email = InputDecoration(
  border: InputBorder.none,
  contentPadding: EdgeInsets.only(top: 14.0),
  prefixIcon: Icon(
    Icons.email,
    color: primaryColor,
  ),
  hintText: 'Enter your Email',
  hintStyle: kHintTextStyle,
);

final textFieldInputDecoration_password = InputDecoration(
  border: InputBorder.none,
  contentPadding: EdgeInsets.only(top: 14.0),
  prefixIcon: Icon(
    Icons.lock,
    color: primaryColor,
  ),
  hintText: 'Enter your Password',
  hintStyle: kHintTextStyle,
);

final textFieldInputDecoration_username = InputDecoration(
  border: InputBorder.none,
  contentPadding: EdgeInsets.only(top: 14.0),
  prefixIcon: Icon(
    Icons.account_circle,
    color: primaryColor,
  ),
  hintText: 'Enter your Name',
  hintStyle: kHintTextStyle,
);

final textFieldInputDecoration_confirmPassword = InputDecoration(
  border: InputBorder.none,
  contentPadding: EdgeInsets.only(top: 14.0),
  prefixIcon: Icon(
    Icons.lock,
    color: primaryColor,
  ),
  hintText: 'Re-enter the password',
  hintStyle: kHintTextStyle,
);


List<List> gradienColor = [
  [const Color(0xFF000046), const Color(0xFF1CB5E0)],
  [const Color(0xFFf09819), const Color(0xFFedde5d)],
  [const Color(0xFFB2FEFA), const Color(0xFF0ED2F7)],
  [const Color(0xFF1d976c), const Color(0xFF93f9b9)],
  [const Color(0xFFD66D75), const Color(0xFFE29587)],
  [const Color(0xFF20002c), const Color(0xFFcbb4d4)],
  [const Color(0xFF093637), const Color(0xFF44A08D)],
  [const Color(0xFFff5f6d), const Color(0xFFffc371)],
  [const Color(0xFFfbd3e9), const Color(0xFFbb377d)],
  [const Color(0xFF33ccff), const Color(0xFFffccff)],
  [const Color(0xFFb993d6), const Color(0xFF8ca6db)],
  [const Color(0xFF616161), const Color(0xFF9bc5c3)],
  [const Color(0xFF603813), const Color(0xFFb29f94)],
  [const Color(0xFFf12711), const Color(0xFFf5af19)],
];