import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/screens/favourites.dart';
import 'package:restrauntapp/screens/landingpage.dart';
import 'package:restrauntapp/screens/orders.dart';
import 'package:restrauntapp/screens/profile.dart';
import 'package:restrauntapp/screens/tablebooking.dart';
import 'package:restrauntapp/widgets/settinglist.dart';

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
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'اهلا بك',
                          style: TextStyle(
                              color: mainColor, fontWeight: FontWeight.bold),
                        ),
                        VerticalDivider(
                          color: Colors.transparent,
                          width: 7,
                        ),
                        Text(
                          (snapshot.data as dynamic)['firstname'] ?? '',
                          style: TextStyle(
                            color: mainColor,
                          ),
                        ),
                        VerticalDivider(
                          color: Colors.transparent,
                          width: 5,
                        ),
                        Text(
                          (snapshot.data as dynamic)['lastname'] ?? '',
                          style: TextStyle(
                            color: mainColor,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                }),
            Divider(
              color: Colors.transparent,
            ),
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileInfo(
                                firstname: firstname,
                                lastname: lastname,
                                number: number,
                                email: email)));
                  },
                  iconData: CupertinoIcons.person,
                  title: 'تعديل معلوماتي',
                ),
                SettingsList(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TableBooking(
                                  image:
                                      'https://images.unsplash.com/photo-1502749793729-68bfc5666aaa?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=3300&q=80',
                                  title: 'هل تريد حجز طاولة؟',
                                  sub: 'اضغط هنا لكي تحجز الآن',
                                )));
                  },
                  iconData: CupertinoIcons.clock,
                  title: 'حجز طاولة',
                ),
                SettingsList(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PreviousOrders()));
                  },
                  iconData: CupertinoIcons.bag,
                  title: 'طلباتي السابقة',
                ),
                SettingsList(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FavouritesPage()));
                  },
                  iconData: CupertinoIcons.heart,
                  title: 'المفضلات',
                ),
                SettingsList(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LandingPage(
                                  signingout: true,
                                )),
                        (route) => false);
                  },
                  iconData: Icons.logout,
                  title: 'تسجيل الخروج',
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
