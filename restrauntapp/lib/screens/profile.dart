import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/main.dart';
import 'package:restrauntapp/widgets/textfield.dart';

class ProfileInfo extends StatefulWidget {
  String firstname;
  String lastname;
  String email;

  String? number;

  ProfileInfo(
      {required this.firstname,
      required this.lastname,
      this.number,
      required this.email});

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  TextEditingController firstnameT = TextEditingController();
  TextEditingController emailT = TextEditingController();
  TextEditingController numberT = TextEditingController();
  TextEditingController lastnameT = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var height = MediaQuery.of(context).size.height;
    if (width > 500) {
      width = 500;
    }
    if (height > 600) {
      height = 600;
    }
    setState(() {
      emailT.text = widget.email;
      if (!Platform.isIOS) {
        numberT.text = widget.number!;
      }
      firstnameT.text = widget.firstname;
      lastnameT.text = widget.lastname;
    });

    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(color: Colors.black),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Divider(
                color: Colors.transparent,
              ),
              Hero(
                tag: 'firstName',
                child: TextFieldWidget(
                  onchanged: (string) {},
                  textController: firstnameT,
                  labeltext: 'الاسم الاول',
                  hinttext: 'محمد',
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Divider(
                color: Colors.transparent,
              ),
              TextFieldWidget(
                onchanged: (string) {},
                textController: lastnameT,
                labeltext: 'الاسم الثاني',
                hinttext: 'سليمان',
              ),
              Divider(
                color: Colors.transparent,
              ),
              Divider(
                color: Colors.transparent,
              ),
              Hero(
                tag: 'email',
                child: TextFieldWidget(
                  onchanged: (string) {},
                  textController: emailT,
                  labeltext: 'البريد الالكتروني',
                  hinttext: 'example@gmail.com',
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Divider(
                color: Colors.transparent,
              ),
              Container(
                child: !Platform.isIOS
                    ? Hero(
                        tag: 'number',
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Material(
                            type: MaterialType.transparency,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CupertinoColors.tertiarySystemFill,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              height: 40,
                              child: TextField(
                                enabled: false,
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 12,
                                    color: CupertinoColors.placeholderText),
                                controller: numberT,
                                cursorColor: mainColor,
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    focusColor: mainColor,
                                    hoverColor: mainColor,
                                    border: InputBorder.none,
                                    labelText: 'رقم جوالك',
                                    hintText: '0123456789',
                                    hintStyle: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 12,
                                        color: CupertinoColors.secondaryLabel),
                                    labelStyle: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontSize: 12,
                                        color: CupertinoColors.secondaryLabel),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Divider(
                color: Colors.transparent,
              ),
              Container(
                height: 40,
                width: width * 0.4,
                child: Material(
                  color: mainColor,
                  elevation: 30,
                  borderRadius: BorderRadius.circular(10),
                  shadowColor: Colors.white,
                  child: TextButton(
                    child: Text(
                      'تحديث',
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 12,
                          color: Colors.white),
                    ),
                    onPressed: () async {
                      if (Platform.isIOS) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          'firstname': firstnameT.text,
                          'lastname': lastnameT.text,
                          'email': emailT.text,
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoadingListPage()));
                      } else {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({
                          'firstname': firstnameT.text,
                          'lastname': lastnameT.text,
                          'email': emailT.text,
                          'phonenumber': numberT.text,
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoadingListPage()));
                      }
                    },
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
