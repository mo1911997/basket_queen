import 'package:aaishani_store_user_app/bloc/UserRegestrationBloc.dart';
import 'package:aaishani_store_user_app/models/Model_MobileVerification.dart';
import 'package:aaishani_store_user_app/models/Model_UserRegistration.dart';
import 'package:aaishani_store_user_app/utilities/utils.dart';
import 'package:aaishani_store_user_app/views/landingScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:string_validator/string_validator.dart';

class UserRegistration extends StatefulWidget {
  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  Model_UserRegistration modelUserRegistration = Model_UserRegistration();
  Model_MobileVerification model_mobileVerification = Model_MobileVerification();
  bool visibleTextFirstName = false;
  bool visibleTextLastName = false;
  bool visibleTextEmailId = false;
  bool visibleTextMobileNo = false;
  bool visibleTextPassword = false;
  bool visibleTextConfirmPassword = false;
  bool visibleTextOTP = false;

  TextEditingController _controllerFirstName = TextEditingController();
  TextEditingController _controllerLastName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerMobile = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerConfirmPassword = TextEditingController();
  TextEditingController _controllerOTP = TextEditingController();

  bool isSubmitted = false;

  String errorTextFirstName = "";
  String errorTextLastName = "";
  String errorTextEmailId = "";
  String errorTextMobileNo = "";
  String errorTextPassword = "";
  String errorTextConfirmPassword = "";
  String errorTextOTP = "";
  String mobileNo = "";

  final formKey = GlobalKey<FormState>();
  final formKeyVerification = GlobalKey<FormState>();

  final FocusNode nodeFirstName = FocusNode();
  final FocusNode nodeLastName = FocusNode();
  final FocusNode nodeEmailid = FocusNode();
  final FocusNode nodeMobileNo = FocusNode();
  final FocusNode nodePassword = FocusNode();
  final FocusNode nodeConfirmPassword = FocusNode();
  final FocusNode nodeBtnSubmit = FocusNode();
  final FocusNode nodeOTP = FocusNode();
  final FocusNode nodeBtnVerify = FocusNode();

  bool _obscureTextConfirm = true;

  void _toggleConfirm() {
    setState(() {
      _obscureTextConfirm = !_obscureTextConfirm;
    });
  }

  _buildFirstName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("First Name", style: kLabelStyleGreen),
        SizedBox(
          height: 5.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 5.0,
                offset: Offset(1, 3),
              ),
            ],
          ),
          height: 45.0,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 0.0),
            child: Container(
              margin: EdgeInsets.only(bottom: 5.0),
              child: TextFormField(
                controller: _controllerFirstName,
                onChanged: userRegistrationBloc.getFirstName,
                focusNode: nodeFirstName,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(nodeLastName);
                },
                textInputAction: TextInputAction.next,
                inputFormatters: [LengthLimitingTextInputFormatter(15)],
                style: TextStyle(color: Colors.grey[700], fontFamily: "Gothic"),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "First Name",
                  hintStyle: TextStyle(
                      color: Colors.grey, fontSize: 14.0, fontFamily: "Gothic"),
                ),
              ),
            ),
          ),
        ),
        Visibility(
            visible: visibleTextFirstName,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  errorTextFirstName,
                  style: TextStyle(
                      fontFamily: "Gothicb",
                      fontSize: 10.0,
                      color: Colors.red[700]),
                ))),
      ],
    );
  }

  _buildLastName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Last Name",
          style: kLabelStyleGreen,
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 5.0,
                offset: Offset(1, 3),
              ),
            ],
          ),
          height: 45.0,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: TextFormField(
              controller: _controllerLastName,
              onChanged: userRegistrationBloc.getLastName,
              focusNode: nodeLastName,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(nodeEmailid);
              },
              textInputAction: TextInputAction.next,
              inputFormatters: [LengthLimitingTextInputFormatter(15)],
              style: TextStyle(color: Colors.grey[700], fontFamily: "Gothic"),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Last Name",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontFamily: "Gothic")),
            ),
          ),
        ),
        Visibility(
            visible: visibleTextLastName,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  errorTextLastName,
                  style: TextStyle(
                      fontFamily: "Gothicb",
                      fontSize: 10.0,
                      color: Colors.red[700]),
                ))),
      ],
    );
  }

  _buildEmailId() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Email id",
          style: kLabelStyleGreen,
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 5.0,
                offset: Offset(1, 3),
              ),
            ],
          ),
          height: 45.0,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: TextFormField(
              controller: _controllerEmail,
              onChanged: userRegistrationBloc.getEmailId,
              focusNode: nodeEmailid,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(nodeMobileNo);
              },
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.grey[700], fontFamily: "Gothic"),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Email id(Optional)",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontFamily: "Gothic")),
            ),
          ),
        ),
        Visibility(
            visible: visibleTextEmailId,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  errorTextEmailId,
                  style: TextStyle(
                      fontFamily: "Gothicb",
                      fontSize: 10.0,
                      color: Colors.red[700]),
                ))),
      ],
    );
  }

  _buildMobileNo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Mobile no", style: kLabelStyleGreen),
        SizedBox(
          height: 5.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 5.0,
                offset: Offset(1, 3),
              ),
            ],
          ),
          height: 45.0,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: TextFormField(
              controller: _controllerMobile,
              enableInteractiveSelection: false,
              onChanged: userRegistrationBloc.getMobileNo,
              focusNode: nodeMobileNo,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(nodePassword);
              },
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10)
              ],
              style: TextStyle(color: Colors.grey[700], fontFamily: "Gothic"),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Mobile no",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontFamily: "Gothic")),
            ),
          ),
        ),
        Visibility(
            visible: visibleTextMobileNo,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  errorTextMobileNo,
                  style: TextStyle(
                      fontFamily: "Gothicb",
                      fontSize: 10.0,
                      color: Colors.red[700]),
                ))),
      ],
    );
  }

  _buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Password", style: kLabelStyleGreen),
        SizedBox(
          height: 5.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 5.0,
                offset: Offset(1, 3),
              ),
            ],
          ),
          height: 45.0,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: TextFormField(
              controller: _controllerPassword,
              onChanged: userRegistrationBloc.getPassword,
              focusNode: nodePassword,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(nodeConfirmPassword);
              },
              textInputAction: TextInputAction.next,
              inputFormatters: [LengthLimitingTextInputFormatter(15)],
              style: TextStyle(color: Colors.grey[700], fontFamily: "Gothic"),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Password",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontFamily: "Gothic")),
            ),
          ),
        ),
        Visibility(
            visible: visibleTextPassword,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  errorTextPassword,
                  style: TextStyle(
                      fontFamily: "Gothicb",
                      fontSize: 10.0,
                      color: Colors.red[700]),
                ))),
      ],
    );
  }

  _buildConfirmPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Confirm Password", style: kLabelStyleGreen),
        SizedBox(
          height: 5.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 5.0,
                offset: Offset(1, 3),
              ),
            ],
          ),
          height: 45.0,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: TextFormField(
              controller: _controllerConfirmPassword,
              focusNode: nodeConfirmPassword,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(nodeBtnSubmit);
              },
              textInputAction: TextInputAction.next,
              inputFormatters: [LengthLimitingTextInputFormatter(15)],
              style: TextStyle(color: Colors.grey[700], fontFamily: "Gothic"),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Confirm Password",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                      fontFamily: "Gothic")),
            ),
          ),
        ),
        Visibility(
            visible: visibleTextConfirmPassword,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  errorTextConfirmPassword,
                  style: TextStyle(
                      fontFamily: "Gothicb",
                      fontSize: 10.0,
                      color: Colors.red[700]),
                ))),
      ],
    );
  }

  Widget _buildSubmitBtn() {
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
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        child: Text(
          'SUBMIT',
          style: TextStyle(
            color: Color(0xFF85CE16),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: "Gothicb",
          ),
        ),
      ),
    );
  }

  Widget _buildMobileVerification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(children: <Widget>[
          Text("We have sent 6 digit OTP on ",
              style: kLabelStyleGreen),
          Text(mobileNo,
              style: TextStyle(
                  color: Color(0xFF679e13),
                  fontFamily: 'Gothicb',
                  fontSize: 16.0
              )),
        ]),
        SizedBox(
          height: 5.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 5.0,
                offset: Offset(1, 3),
              ),
            ],
          ),
          height: 45.0,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 0.0),
            child: Container(
              margin: EdgeInsets.only(bottom: 5.0),
              child: TextFormField(
                controller: _controllerOTP,
                onChanged: userRegistrationBloc.getOTP,
                focusNode: nodeOTP,
                onFieldSubmitted: (value) {
                  FocusScope.of(context).requestFocus(nodeBtnVerify);
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(),
                inputFormatters: [LengthLimitingTextInputFormatter(6)],
                style: TextStyle(color: Colors.grey[700], fontFamily: "Gothic"),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter OTP",
                  hintStyle: TextStyle(
                      color: Colors.grey, fontSize: 14.0, fontFamily: "Gothic"),
                ),
              ),
            ),
          ),
        ),
        Visibility(
            visible: visibleTextOTP,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  errorTextOTP,
                  style: TextStyle(
                      fontFamily: "Gothicb",
                      fontSize: 10.0,
                      color: Colors.red[700]),
                ))),
      ],
    );
  }

  Widget _buildVerify() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 3.0,
        onPressed: () {
          verify();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        child: Text(
          'Verify',
          style: TextStyle(
            color: Color(0xFF85CE16),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: "Gothicb",
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isSubmitted
            ? Stack(children: <Widget>[
                Container(
                  color: Color(0xFF85CE16),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 80.0),
                    child: Form(
                      key: formKeyVerification,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Verify your Mobile no",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Gothic",
                                fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Card(
                            color: Colors.white,
                            elevation: 3.0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                              child: Column(children: <Widget>[
                                _buildMobileVerification(),
                                SizedBox(
                                  height: 20.0,
                                ),
                              ]),
                            ),
                          ),
                          _buildVerify(),
                        ],
                      ),
                    ),
                  ),
                )
              ])
            : Stack(children: <Widget>[
                Container(
                  color: Color(0xFF85CE16),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 50.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Registration",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Gothic",
                                fontSize: 30.0),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Card(
                            color: Colors.white,
                            elevation: 3.0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                              child: Column(children: <Widget>[
                                _buildFirstName(),
                                SizedBox(
                                  height: 20.0,
                                ),
                                _buildLastName(),
                                SizedBox(
                                  height: 20.0,
                                ),
                                _buildEmailId(),
                                SizedBox(
                                  height: 20.0,
                                ),
                              ]),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Card(
                            elevation: 3.0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20.0),
                              child: Column(
                                children: <Widget>[
                                  _buildMobileNo(),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  _buildPassword(),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  _buildConfirmPassword(),
                                ],
                              ),
                            ),
                          ),
                          _buildSubmitBtn(),
                        ],
                      ),
                    ),
                  ),
                )
              ]));
  }

  requestSignUp() async {
    modelUserRegistration =
        await userRegistrationBloc.requestUserRegistration();
    if (modelUserRegistration.statusCode == '200') {
      print("userRegistrationBloc.mobileNo.value" +
          userRegistrationBloc.mobileNo.value);
      if (modelUserRegistration.state == "success") {
        Fluttertoast.showToast(
            msg: "Account created successfully",
            toastLength: Toast.LENGTH_LONG);
        setState(() {
          mobileNo = userRegistrationBloc.mobileNo.value;
          isSubmitted = true;
        });
      } else {
        Fluttertoast.showToast(msg: modelUserRegistration.msg);
        setState(() {
          mobileNo = userRegistrationBloc.mobileNo.value;
          isSubmitted = true;
        });
      }
    } else {
      Fluttertoast.showToast(
          msg: "Something is not right, Please try again...");
    }
    print("Model User Registration Data " +
        modelUserRegistration.state.toString());
  }

  validateFields() {
    //First Name Validation
    if (_controllerFirstName.text.isEmpty) {
      setState(() {
        errorTextFirstName = "Please enter your first name";
        visibleTextFirstName = true;
        FocusScope.of(context).requestFocus(nodeFirstName);
      });
      return;
    } else {
      setState(() {
        errorTextFirstName = "";
        visibleTextFirstName = false;
      });
    }

    //Last Name Validation
    if (_controllerLastName.text.isEmpty) {
      setState(() {
        errorTextLastName = "Please enter your last name";
        visibleTextLastName = true;
        FocusScope.of(context).requestFocus(nodeLastName);
      });
      return;
    } else {
      setState(() {
        errorTextLastName = "";
        visibleTextLastName = true;
      });
    }

    //Email id Validation
    if (_controllerEmail.text.isNotEmpty && !isEmail(_controllerEmail.text)) {
      setState(() {
        errorTextEmailId = "Please enter valid email id";
        visibleTextEmailId = true;
        FocusScope.of(context).requestFocus(nodeEmailid);
      });
      return;
    } else {
      errorTextEmailId = "";
      visibleTextEmailId = false;
    }

    //Mobile no validation
    if (_controllerMobile.text.isEmpty || _controllerMobile.text.length != 10) {
      setState(() {
        errorTextMobileNo = "Please enter Valid Mobile no";
        visibleTextMobileNo = true;
        FocusScope.of(context).requestFocus(nodeMobileNo);
      });
      return;
    } else {
      setState(() {
        errorTextMobileNo = "";
        visibleTextMobileNo = false;
      });
    }

    //Password Validation
    if (_controllerPassword.text.isEmpty ||
        _controllerPassword.text.length < 5) {
      setState(() {
        errorTextPassword = "Password should have at least 5 character";
        visibleTextPassword = true;
        FocusScope.of(context).requestFocus(nodePassword);
      });
      return;
    } else {
      errorTextPassword = "";
      visibleTextPassword = false;
    }

    //ConfirmPassowrd validation
    if (_controllerConfirmPassword.text != _controllerPassword.text) {
      setState(() {
        errorTextConfirmPassword = "Password did not match";
        visibleTextConfirmPassword = true;
        FocusScope.of(context).requestFocus(nodeConfirmPassword);
      });
      return;
    } else {
      errorTextConfirmPassword = "";
      visibleTextConfirmPassword = false;
    }

    print(" requestSignUp() called");
    if (userRegistrationBloc.emailId.value == null) {
      userRegistrationBloc.emailId.value = "";
    }
    requestSignUp();
  }

  void verify() {
    if(_controllerOTP.text.isEmpty)
      {
        setState(() {
          errorTextOTP = "Please enter valid OTP";
          visibleTextOTP = true;
          FocusScope.of(context).requestFocus(nodeOTP);
        });
        return;
      } else {
      errorTextOTP = "";
      visibleTextOTP = false;
    }

    requestVerifyOTP();

  }

  void requestVerifyOTP() async {
    model_mobileVerification =await userRegistrationBloc.mobileVerification();

    if(model_mobileVerification.statusCode=='200')
      {
        if(model_mobileVerification.state=="success")
          {
            Fluttertoast.showToast(
                msg: "Mobile no verified successfully",
                toastLength: Toast.LENGTH_LONG);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=> landingScreen()));
          }
        else
          {
            Fluttertoast.showToast(msg: model_mobileVerification.msg);
          }
      }
    else {
      Fluttertoast.showToast(
          msg: "Something is not right, Please try again...");
    }
    print("Model Mobileverification Data " +
        model_mobileVerification.state.toString());
  }
}
