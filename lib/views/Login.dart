import 'dart:convert';

import 'package:aaishani_store_user_app/bloc/LoginBloc.dart';
import 'package:aaishani_store_user_app/dbClient/operations_profile.dart';
import 'package:aaishani_store_user_app/models/Model_Login.dart';
import 'package:aaishani_store_user_app/models/profileDataModel.dart';
import 'package:aaishani_store_user_app/utilities/FirebaseMessagingServices.dart';
import 'package:aaishani_store_user_app/utilities/utils.dart';
import 'package:aaishani_store_user_app/views/UserRegistration.dart';
import 'package:aaishani_store_user_app/views/landingScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final storage = FlutterSecureStorage();

  TextEditingController _loginIDController = TextEditingController();
  TextEditingController _loginPassword = TextEditingController();

  Model_Login modelLogin = Model_Login();

  final FocusNode nodeLoginId = FocusNode();
  final FocusNode nodePassword = FocusNode();
  final FocusNode loginButton = FocusNode();

  bool _obscureTextConfirm = true;
  bool visibleTextLogInId = false;
  bool visibleTextLoginPassword = false;

  String errorTextLogInId = "";
  String errorTextLoginPassword = "";

  void _toggleConfirm() {
    setState(() {
      _obscureTextConfirm = !_obscureTextConfirm;
    });
  }

  Widget _buildLoginId() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "LogIn ID",
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyleWithBorder,
          height: 45.0,
          child: TextField(
            onChanged: loginBloc.getUserName,
            controller: _loginIDController,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10)
            ],
            style: TextStyle(color: Colors.grey[700], fontFamily: "Gothic"),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.person,
                color: Color(0xFF85CE16),
              ),
              hintText: "Mobile No",
              hintStyle: TextStyle(
                  color: Colors.grey, fontSize: 14.0, fontFamily: "Gothic"),
            ),
            focusNode: nodeLoginId,
            onSubmitted: (value) {
              FocusScope.of(context).requestFocus(nodePassword);
            },
            textInputAction: TextInputAction.next,
          ),
        ),
        Visibility(
            visible: visibleTextLogInId,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  errorTextLogInId,
                  style: TextStyle(
                      fontFamily: "Gothicb",
                      fontSize: 12.0,
                      color: Colors.red[700]),
                ))),
      ],
    );
  }

  Widget _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Password",
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyleWithBorder,
          height: 45.0,
          child: TextField(
            onChanged: loginBloc.getPassword,
            controller: _loginPassword,
            obscureText: _obscureTextConfirm,
            style: TextStyle(color: Colors.grey[700], fontFamily: "Gothic"),
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.vpn_key,
                color: Color(0xFF85CE16),
              ),
              hintText: "Password",
              hintStyle: TextStyle(
                  color: Colors.grey, fontSize: 14.0, fontFamily: "Gothic"),
              suffixIcon: GestureDetector(
                  onTap: () {
                    _toggleConfirm();
                  },
                  child: _obscureTextConfirm
                      ? Icon(Icons.visibility_off, color: Colors.grey)
                      : Icon(Icons.visibility, color: Color(0xFF85CE16))),
            ),
            focusNode: nodePassword,
            onSubmitted: (value) {
              FocusScope.of(context).requestFocus(loginButton);
            },
            textInputAction: TextInputAction.done,
          ),
        ),
        Visibility(
            visible: visibleTextLoginPassword,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  errorTextLoginPassword,
                  style: TextStyle(
                      fontFamily: "Gothicb",
                      fontSize: 12.0,
                      color: Colors.red[700]),
                ))),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print("Forgot password button pressed"),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          "Forgot Pasword",
          style: kLabelStyle,
        ),
      ),
    );
  }

  bool _rememberMe = false;

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 25.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Color(0xFF85CE16)),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.white,
              activeColor: Color(0xFF659c11),
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontFamily: 'Gothic',
                fontSize: 14.0),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 3.0,
        onPressed: () {
          validateFields();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xFF85CE16),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: "Gothic",
          ),
        ),
        focusNode: loginButton,
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (c, a1, a2) => UserRegistration(),
            transitionsBuilder: (c, anim, a2, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: Duration(milliseconds: 1000),
          ),
        );
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14.0,
                fontFamily: "Gothic",
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 14.0,
                fontFamily: "Gothic",
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return null;
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/bglogin.png"),
                    //image: AssetImage("assets/images/bgsplashgreen.png"),
                    //image: AssetImage("assets/images/bgthreegreen.png"),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter),
              ),
            ),
            Container(
              height: double.infinity,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Log In",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Gothic",
                          fontSize: 30.0),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    _buildLoginId(),
                    SizedBox(
                      height: 30.0,
                    ),
                    _buildPassword(),
                    _buildForgotPassword(),
                    SizedBox(
                      height: 80.0,
                    ),
                    _buildLoginBtn(),
                    SizedBox(
                      height: 50.0,
                    ),
                    _buildSignupBtn(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  validateFields() {
    //First Name Validation
    if (_loginIDController.text.isEmpty) {
      setState(() {
        errorTextLogInId = "Please enter LogIn id";
        visibleTextLogInId = true;
        FocusScope.of(context).requestFocus(nodeLoginId);
      });
      return;
    } else {
      setState(() {
        errorTextLogInId = "";
        visibleTextLogInId = false;
      });
    }

    if (_loginPassword.text.isEmpty) {
      setState(() {
        errorTextLoginPassword = "Please enter password";
        visibleTextLoginPassword = true;
        FocusScope.of(context).requestFocus(nodePassword);
      });
      return;
    } else {
      setState(() {
        errorTextLoginPassword = "";
        visibleTextLoginPassword = false;
      });
    }

    requestLogin();
  }

  requestLogin() async {
    modelLogin = await loginBloc.requestLogin();
    if (modelLogin.statusCode == "200") {
      if (modelLogin.state == "success") {
        await storage.write(key: "token", value: modelLogin.token);
        ProfileData profileData = ProfileData(
            mid: modelLogin.mid,
            name: modelLogin.name,
            contact: modelLogin.contact,
            email: modelLogin.email,
            addresses: json.encode(modelLogin.addresses));
        OperationsProfile operationsProfile = OperationsProfile();
        operationsProfile.insertProfileData(profileData);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FirebaseMessagingService()),
        );
        loginBloc.close();
      } else {
        if (modelLogin.msg == "Invalid Credentials !") {
          Fluttertoast.showToast(msg: "Invalid Credentials");
        } else {
          Fluttertoast.showToast(msg: "Contact not registered");
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: "Something is not right, Please try again...");
    }
    print("Model Login Data " + modelLogin.state.toString());
  }
}
