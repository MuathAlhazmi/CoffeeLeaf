import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/main.dart';
import 'package:restrauntapp/screens/login.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Divider(
              color: Colors.transparent,
            ),
            FutureBuilder(
                future: printUrl1(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Material(
                      color: Colors.transparent,
                      elevation: 20,
                      shadowColor: mainColor,
                      borderRadius: BorderRadius.circular(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          height: 120,
                          width: 120,
                          imageUrl: snapshot.data.toString(),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CupertinoActivityIndicator(radius: 10),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else {
                    return CupertinoActivityIndicator();
                  }
                }),
            Expanded(
              child: FutureBuilder(
                  future: printUrl(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: snapshot.data.toString(),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CupertinoActivityIndicator(radius: 10),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          fit: BoxFit.contain,
                        ),
                      );
                    } else {
                      return CupertinoActivityIndicator();
                    }
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (Platform.isIOS) {
                        if (FirebaseAuth.instance.currentUser != null) {
                          print(FirebaseAuth.instance.currentUser!.uid);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoadingListPage(),
                              ));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => DetailScreen(
                          //             description: items[0].description,
                          //             price: items[0].price,
                          //             image: items[0].image,
                          //             name: items[0].name,
                          //             quantity: items[0].quantity)));
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreenIOS(),
                            ),
                          );
                        }
                      } else {
                        if (FirebaseAuth.instance.currentUser != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoadingListPage(),
                              ));
                          // Navigator.push(
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'ابدأ بالطلب',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.transparent,
            ),
          ],
        ),
      ),
    ));
  }
}

printUrl() async {
  Reference ref = FirebaseStorage.instance.ref().child("mockuper.png");
  var url = await ref.getDownloadURL();
  print(url);
  return url;
}

printUrl1() async {
  Reference ref = FirebaseStorage.instance.ref().child("Untitled design.png");
  var url = await ref.getDownloadURL();
  print(url);
  return url;
}