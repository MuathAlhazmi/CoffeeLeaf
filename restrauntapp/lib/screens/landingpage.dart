import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/main.dart';
import 'package:restrauntapp/screens/login.dart';
import 'package:restrauntapp/widgets/snackbar.dart';

class LandingPage extends StatefulWidget {
  final bool? signingout;
  const LandingPage({this.signingout});
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    if (widget.signingout ?? false) {
      FirebaseAuth.instance.signOut();
      snackBarWidget(
          context, 'تم تسجيل الخروج بنجاج', Icons.check, Colors.white);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.white,
      child: SafeArea(
        child: Container(
          color: Colors.white,
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
                        elevation: 10,
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
              Divider(
                color: Colors.transparent,
              ),
              Divider(
                color: Colors.transparent,
              ),
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
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
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
                ],
              ),
              Divider(
                color: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

printUrl() async {
  Reference ref = FirebaseStorage.instance.ref().child("ورقة القهوة (1).png");
  var url = await ref.getDownloadURL();
  print(url);
  return url;
}

printUrl1() async {
  Reference ref =
      FirebaseStorage.instance.ref().child("Untitled design (2).png");
  var url = await ref.getDownloadURL();
  print(url);
  return url;
}
