import 'dart:ui';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/data/data.dart';
import 'package:restrauntapp/screens/cart.dart';
import 'package:restrauntapp/screens/homepage.dart';
import 'package:restrauntapp/screens/landingpage.dart';
import 'package:restrauntapp/screens/search.dart';
import 'package:restrauntapp/screens/settings.dart';
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
        home: AnimatedSplashScreen(
          curve: Curves.easeInOut,
          animationDuration: Duration(seconds: 2),
          duration: 3000,
          splash: Material(
            color: Colors.transparent,
            elevation: 20,
            shadowColor: mainColor,
            borderRadius: BorderRadius.circular(20),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
          ),
          nextScreen: LandingPage(),
          splashTransition: SplashTransition.slideTransition,
          backgroundColor: itemColor,
          pageTransitionType: PageTransitionType.rightToLeft,
          centered: true,
        ));
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
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          enabled = false;
        });
      }
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
            currentIndex1 == 0 ? itemColor : Colors.white,
          ])),
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: DotNavigationBar(
            borderRadius: 20,
            duration: Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            paddingR: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            itemPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            boxShadow: [
              BoxShadow(
                color: mainColor.withOpacity(.7),
                offset: Offset(4, 8), // Shadow position
                spreadRadius: 0,
                blurRadius: 20,
              )
            ],
            backgroundColor: mainColor,
            currentIndex: currentIndex1,
            dotIndicatorColor: itemColor,
            onTap: (index) {
              if (index == 0) {
                // showNotification();
                setState(() {
                  currentIndex1 = index;
                });
              }
              setState(() {
                currentIndex1 = index;
              });
            },
            items: [
              DotNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  unselectedColor: itemColor.withOpacity(.5),
                  selectedColor: itemColor),
              DotNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.search,
                  ),
                  unselectedColor: itemColor.withOpacity(.5),
                  selectedColor: itemColor),
              DotNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.person_circle,
                  ),
                  unselectedColor: itemColor.withOpacity(.5),
                  selectedColor: itemColor),
              DotNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.cart,
                  ),
                  unselectedColor: itemColor.withOpacity(.5),
                  selectedColor: itemColor),
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
                      ? Container(
                          child: SettingsPage(),
                          color: Colors.white,
                        )
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
          child: AnimationLimiter(
            child: AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              delay: Duration(milliseconds: 200),
              child: ScaleAnimation(
                child: FadeInAnimation(
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
