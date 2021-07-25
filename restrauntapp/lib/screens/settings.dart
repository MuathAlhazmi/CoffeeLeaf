import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restrauntapp/screens/landingpage.dart';
import 'package:restrauntapp/screens/profile.dart';
import 'package:restrauntapp/widgets/settinglist.dart';
import 'package:restrauntapp/widgets/snackbar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late String firstname;
  late String email;
  String? number;
  late String lastname;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Container(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (FirebaseAuth.instance.currentUser == null) {
                      return Container();
                    } else {
                      firstname = (snapshot.data as dynamic)['firstname'] ?? '';
                      lastname = (snapshot.data as dynamic)['lastname'] ?? '';
                      email = (snapshot.data as dynamic)['email'] ?? '';
                      if (!Platform.isIOS) {
                        number = (snapshot.data as dynamic)['number'] ?? '';
                      }

                      return Container();
                    }
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                SettingsList(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    snackBarWidget(context, 'تم تسجيل الخروج بنجاج',
                        Icons.check, Colors.white);
                    setState(() {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LandingPage()));
                    });
                  },
                  iconData: Icons.logout,
                  title: 'تسجيل الخروج',
                ),
                Divider(
                  color: Colors.transparent,
                ),
                SettingsList(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileInfo(
                                firstname: firstname,
                                lastname: lastname,
                                number: number,
                                email: email)));
                  },
                  iconData: Icons.info,
                  title: 'تعديل معلوماتي',
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
