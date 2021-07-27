import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/data/data.dart';
import 'package:restrauntapp/screens/cart.dart';
import 'package:restrauntapp/screens/homepage.dart';
import 'package:restrauntapp/screens/landingpage.dart';
import 'package:restrauntapp/screens/search.dart';
import 'package:restrauntapp/screens/settings.dart';
import 'package:restrauntapp/widgets/navbar.dart';
import 'package:shimmer/shimmer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ar'),
        ],
        title: 'Shimmer',
        routes: <String, WidgetBuilder>{
          'loading': (_) => LoadingListPage(),
        },
        theme: ThemeData(
          primarySwatch: colorCustom,
          fontFamily: 'Cairo',
        ),
        home: LandingPage());
  }
}

class LoadingListPage extends StatefulWidget {
  @override
  _LoadingListPageState createState() => _LoadingListPageState();
}

class _LoadingListPageState extends State<LoadingListPage> {
  bool enabled = true;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 6), () {
      setState(() {
        enabled = false;
      });
    });
    super.initState();
  }

  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
            0.1,
            0.9
          ],
              colors: [
            currentIndex1 == 0 ? mainColor : Colors.white,
            mainColor
          ])),
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: CustomBottomNavigationBar(
            currentIndex: currentIndex1,
            onChange: (index) {
              setState(() {
                currentIndex1 = index;
              });
            },
            children: [
              CustomBottomNavigationItem(
                  icon: CupertinoIcons.home, color: Colors.white),
              CustomBottomNavigationItem(
                  icon: CupertinoIcons.search, color: Colors.white),
              CustomBottomNavigationItem(
                  icon: CupertinoIcons.person_circle, color: Colors.white),
              CustomBottomNavigationItem(
                  icon: CupertinoIcons.cart, color: Colors.white),
            ],
          ),
          body: currentIndex1 == 0
              ? HomePage(
                  enabled: enabled,
                )
              : currentIndex1 == 1
                  ? SearchPage(
                      enabled: enabled,
                    )
                  : currentIndex1 == 2
                      ? SettingsPage()
                      : CartScreens(),
        ),
      ),
    );
  }
}

printUrl1() async {
  Reference ref = FirebaseStorage.instance.ref().child("Untitled design.png");
  var url = await ref.getDownloadURL();
  print(url);

  return url;
}

class Shimmering extends StatelessWidget {
  final bool enabled;
  const Shimmering({Key? key, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color(0xFFE4E4E4),
      highlightColor: Color(0xFFD3D3D3),
      enabled: enabled,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.7),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => AnimationLimiter(
          child: AnimationConfiguration.staggeredGrid(
            columnCount: 3,
            position: index,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Text(''),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmeringCarousel extends StatelessWidget {
  final bool enabled;
  const ShimmeringCarousel({Key? key, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Color(0xFFE4E4E4),
      highlightColor: Color(0xFFD3D3D3),
      enabled: enabled,
      child: CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 0.7,
            height: 220.0,
            autoPlay: true,
            enlargeCenterPage: true,
            autoPlayInterval: Duration(seconds: 3),
            autoPlayAnimationDuration: Duration(milliseconds: 500),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {},
          ),
          items: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                                child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(''),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ]),
    );
  }
}
