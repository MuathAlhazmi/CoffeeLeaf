import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:like_button/like_button.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/data/data.dart';
import 'package:restrauntapp/models/models.dart';
import 'package:restrauntapp/screens/cart.dart';
import 'package:restrauntapp/widgets/searchwidget.dart';
import 'package:restrauntapp/widgets/snackbar.dart';

class DetailScreen extends StatefulWidget {
  final String description;
  final String name;
  final String image;
  bool isLiked;
  final String itemID;
  final num price;
  int quantity;
  DetailScreen(
      {required this.image,
      required this.itemID,
      required this.isLiked,
      required this.description,
      required this.name,
      required this.quantity,
      required this.price});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final key = GlobalKey<LikeButtonState>();
  ScrollController _scrollController = ScrollController();
  final TextEditingController searchtext = TextEditingController();
  List<Item> searchItems = [];
  final TextEditingController review = TextEditingController();
  int star = 0;

  @override
  Widget build(BuildContext context) {
    print(widget.isLiked);
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
            currentIndex1 == 0 ? mainColor : itemColor,
            currentIndex1 == 0 ? itemColor : itemColor,
          ])),
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: mainColor, width: 2),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 2,
                          color: mainColor,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: itemColor,
                      onPrimary: Colors.black12,
                    ),
                    onPressed: () {
                      if (!favourite
                          .any((element) => element.name == widget.name)) {
                        snackBarWidget(context, 'تم الاضافة في المعجابات بنجاح',
                            Icons.check, Colors.white);
                        setState(() {
                          favourite.add(Item(
                              isLiked: widget.isLiked,
                              itemID: widget.itemID,
                              description: widget.description,
                              image: widget.image,
                              name: widget.name,
                              quantity: widget.quantity,
                              price: widget.price));
                        });
                      } else {
                        snackBarWidget(context, 'تم الحذف من المعجابات بنجاح',
                            Icons.check, Colors.white);
                        setState(() {
                          favourite.removeWhere(
                              (element) => element.name == widget.name);
                        });
                      }
                    },
                    child: Icon(
                        favourite.any((element) => element.name == widget.name)
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: mainColor)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: mainColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: itemColor,
                    onPrimary: Colors.black12,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: mainColor, width: 2),
                      ),
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return SafeArea(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: SearchWidget(
                                      search: searchtext,
                                      enabled: false,
                                      items: items
                                          .where((element) =>
                                              element.price == widget.price)
                                          .toList(),
                                      searchResult: searchItems),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  },
                  child: Text(
                    ' ${widget.price} ريال',
                    style: TextStyle(
                      fontSize: 15,
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: 85,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (widget.quantity < 5) {
                            setState(() {
                              widget.quantity++;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            border: Border.all(color: mainColor, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 15,
                            color: mainColor,
                          ),
                        ),
                      ),
                      Text(
                        widget.quantity.toString(),
                        style: TextStyle(
                          color: mainColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (widget.quantity > 0) {
                            setState(() {
                              widget.quantity--;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            border: Border.all(color: mainColor, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            Icons.remove,
                            size: 15,
                            color: mainColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    elevation: 0,
                    primary: itemColor,
                    onPrimary: Colors.black12,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: mainColor, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (cart.any((element) => element.name == widget.name)) {
                      snackBarWidget(
                          context,
                          '${widget.name} متوفر في سلتك من قبل',
                          Icons.error,
                          Colors.white);
                    } else {
                      if (widget.quantity == 0) {
                        snackBarWidget(context, 'ان الكمية المدخلة غير صحيح',
                            Icons.error, Colors.white);
                      } else {
                        showFlash(
                            context: context,
                            duration: const Duration(seconds: 2),
                            persistent: true,
                            builder: (_, controller) {
                              return Flash(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                borderRadius: BorderRadius.circular(20),
                                controller: controller,
                                backgroundColor: mainColor,
                                barrierBlur: 13.0,
                                barrierColor: Colors.black38,
                                barrierDismissible: true,
                                behavior: FlashBehavior.floating,
                                position: FlashPosition.top,
                                child: FlashBar(
                                  icon: Icon(Icons.check, color: Colors.white),
                                  content: Text(
                                    'تم اضافة ${widget.quantity.toString()} ${widget.name} الى سلة التسوق',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                  primaryAction: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Scaffold(
                                              body: CartScreens(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'الذهاب إلى السلة',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.white),
                                      )),
                                ),
                              );
                            });
                        setState(() {
                          cart.add(Item(
                              isLiked: widget.isLiked,
                              itemID: widget.itemID,
                              description: widget.description,
                              image: widget.image,
                              name: widget.name,
                              quantity: widget.quantity,
                              price: widget.price));
                        });
                      }
                    }
                  },
                  child: Center(
                    child: Icon(
                      Icons.add_shopping_cart,
                      color: mainColor,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: itemColor,
          body: Container(
            child: SafeArea(
              child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      leadingWidth: 75,
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Hero(
                          tag: 'Back',
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              fixedSize: Size(50, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).maybePop();
                            },
                            child: Icon(
                              CupertinoIcons.arrow_right,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        Hero(
                          tag: 'Cart',
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                fixedSize: Size(50, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      body: CartScreens(),
                                    ),
                                  ),
                                );
                              },
                              child: Icon(
                                CupertinoIcons.shopping_cart,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                      automaticallyImplyLeading: false,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                      expandedHeight: MediaQuery.of(context).size.height * 0.4,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        title: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                color: mainColor.withOpacity(.7),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    widget.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        centerTitle: true,
                        background: CachedNetworkImage(
                          imageUrl: widget.image,
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
                      elevation: 20,
                      shadowColor: mainColor,
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(children: [
                      Divider(
                        color: Colors.transparent,
                      ),
                      StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('reviews')
                              .where(
                                'itemName',
                                isEqualTo: widget.itemID,
                              )
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              if (!snapshot.data!.docs.isEmpty) {
                                final sum = snapshot.data!.docs
                                    .map((doc) => doc['star'])
                                    .toList();
                                var average = sum.reduce((a, b) => a + b) /
                                    snapshot.data!.docs.length;
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    onPrimary: Colors.white38,
                                    primary: itemColor,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: mainColor, width: 2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(10)),
                                        ),
                                        isScrollControlled: true,
                                        context: context,
                                        elevation: 100,
                                        builder: (context) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 30, horizontal: 20),
                                            child: Container(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.7,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: mainColor,
                                                              width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        width: double.infinity,
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              'التقييمات',
                                                              style: TextStyle(
                                                                color:
                                                                    mainColor,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  StreamBuilder(
                                                                stream: FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'reviews')
                                                                    .where(
                                                                        'itemName',
                                                                        isEqualTo:
                                                                            widget.itemID)
                                                                    .snapshots(),
                                                                builder: (context,
                                                                    AsyncSnapshot<
                                                                            QuerySnapshot>
                                                                        snapshot) {
                                                                  if (snapshot
                                                                      .hasData) {
                                                                    if (!snapshot
                                                                        .data!
                                                                        .docs
                                                                        .isEmpty) {
                                                                      return ListView(
                                                                          children:
                                                                              getExpenseItems(snapshot));
                                                                    } else {
                                                                      return Center(
                                                                        child:
                                                                            Text(
                                                                          'لا يوجد أي تقييمات',
                                                                          style: TextStyle(
                                                                              color: itemColor,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      );
                                                                    }
                                                                  } else {
                                                                    return CupertinoActivityIndicator();
                                                                  }
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            '(${snapshot.data!.docs.length})  ${average.toInt().toString()} ',
                                            style: TextStyle(
                                                color: mainColor,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Directionality(
                                            textDirection: TextDirection.ltr,
                                            child: RatingBar(
                                                itemSize: 30,
                                                initialRating:
                                                    average.toDouble(),
                                                ignoreGestures: true,
                                                glowColor: mainColor,
                                                ratingWidget: RatingWidget(
                                                  empty: Icon(
                                                      CupertinoIcons.star,
                                                      color: mainColor),
                                                  half: Icon(
                                                      CupertinoIcons
                                                          .star_lefthalf_fill,
                                                      color: mainColor),
                                                  full: Icon(
                                                      CupertinoIcons.star_fill,
                                                      color: mainColor),
                                                ),
                                                onRatingUpdate: (rating) {}),
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        color: Colors.transparent,
                                      ),
                                      Text(
                                        'اضغط هنا لتقرأ المزيد',
                                        style: TextStyle(
                                          color: mainColor,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            } else {
                              return CupertinoActivityIndicator();
                            }
                          }),
                      Divider(
                        color: Colors.transparent,
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
                              onPressed: () async {
                                bool docexists = await FirebaseFirestore
                                    .instance
                                    .collection('reviews')
                                    .doc(
                                        FirebaseAuth.instance.currentUser!.uid +
                                            widget.itemID)
                                    .get()
                                    .then((value) => value.exists);
                                if (docexists) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      insetPadding: EdgeInsets.all(20),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: mainColor,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      child: Container(
                                        height: 300,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 30),
                                        decoration: BoxDecoration(
                                            color: itemColor,
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    'هل انت متأكد؟',
                                                    style: TextStyle(
                                                        color: mainColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Divider(
                                                    color: Colors.transparent,
                                                  ),
                                                  Text(
                                                    'هل تريد حذق تقييمك السابق؟',
                                                    style: TextStyle(
                                                      color: mainColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                color: Colors.transparent,
                                              ),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors.white,
                                                        onPrimary:
                                                            Colors.black12,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20,
                                                                vertical: 5),
                                                        child: Center(
                                                          child: Text(
                                                            'ألغاء',
                                                            style: TextStyle(
                                                              color: mainColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        elevation: 0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                'reviews')
                                                            .doc(FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid +
                                                                widget.itemID)
                                                            .delete();
                                                        Navigator.pop(context);
                                                        showModalBottomSheet(
                                                            isScrollControlled:
                                                                true,
                                                            context: context,
                                                            elevation: 100,
                                                            builder: (context) {
                                                              return Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            30,
                                                                        horizontal:
                                                                            20),
                                                                child:
                                                                    Container(
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Padding(
                                                                      padding: MediaQuery.of(
                                                                              context)
                                                                          .viewInsets,
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.min,
                                                                        children: [
                                                                          Directionality(
                                                                            textDirection:
                                                                                TextDirection.ltr,
                                                                            child: RatingBar(
                                                                                initialRating: star.toDouble(),
                                                                                glowColor: mainColor,
                                                                                ratingWidget: RatingWidget(
                                                                                  empty: Icon(CupertinoIcons.star, color: mainColor),
                                                                                  half: Icon(CupertinoIcons.star_lefthalf_fill, color: mainColor),
                                                                                  full: Icon(CupertinoIcons.star_fill, color: mainColor),
                                                                                ),
                                                                                onRatingUpdate: (rating) {
                                                                                  setState(() {
                                                                                    star = rating.toInt();
                                                                                  });
                                                                                }),
                                                                          ),
                                                                          Divider(
                                                                            color:
                                                                                Colors.transparent,
                                                                          ),
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              color: CupertinoColors.tertiarySystemFill,
                                                                            ),
                                                                            child:
                                                                                TextField(
                                                                              keyboardType: TextInputType.multiline,
                                                                              maxLines: null,
                                                                              style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                                                                              controller: review,
                                                                              cursorColor: mainColor,
                                                                              decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 10), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.transparent, width: 2)), disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.transparent, width: 2)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: mainColor, width: 2)), focusColor: mainColor, hoverColor: mainColor, border: InputBorder.none, labelText: 'تقييم', hintText: 'اكتب تقييمك هنا', hintStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12), labelStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12), floatingLabelBehavior: FloatingLabelBehavior.never),
                                                                            ),
                                                                          ),
                                                                          Divider(
                                                                            color:
                                                                                Colors.transparent,
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: ElevatedButton(
                                                                                  style: ElevatedButton.styleFrom(
                                                                                    primary: mainColor,
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(10),
                                                                                    ),
                                                                                  ),
                                                                                  onPressed: () async {
                                                                                    var nameFunc = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) => value['firstname']);

                                                                                    String name = nameFunc;
                                                                                    await FirebaseFirestore.instance.collection('reviews').doc(FirebaseAuth.instance.currentUser!.uid + widget.itemID).set({
                                                                                      'username': name,
                                                                                      'itemName': widget.itemID,
                                                                                      'content': review.text.trim(),
                                                                                      'star': star
                                                                                    });

                                                                                    snackBarWidget(context, 'تم التقييم بنجاح', Icons.check, Colors.white);
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: Center(
                                                                                    child: Text(
                                                                                      'تقييم المنتج',
                                                                                      style: TextStyle(
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                      },
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20,
                                                                vertical: 5),
                                                        child: Center(
                                                          child: Text(
                                                            'تأكيد',
                                                            style: TextStyle(
                                                                color:
                                                                    itemColor),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ]),
                                            ]),
                                      ),
                                    ),
                                  );
                                } else {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      elevation: 100,
                                      builder: (context) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 30, horizontal: 20),
                                          child: Container(
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding: MediaQuery.of(context)
                                                    .viewInsets,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Directionality(
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      child: RatingBar(
                                                          initialRating:
                                                              star.toDouble(),
                                                          glowColor: mainColor,
                                                          ratingWidget:
                                                              RatingWidget(
                                                            empty: Icon(
                                                                CupertinoIcons
                                                                    .star,
                                                                color:
                                                                    mainColor),
                                                            half: Icon(
                                                                CupertinoIcons
                                                                    .star_lefthalf_fill,
                                                                color:
                                                                    mainColor),
                                                            full: Icon(
                                                                CupertinoIcons
                                                                    .star_fill,
                                                                color:
                                                                    mainColor),
                                                          ),
                                                          onRatingUpdate:
                                                              (rating) {
                                                            setState(() {
                                                              star = rating
                                                                  .toInt();
                                                            });
                                                          }),
                                                    ),
                                                    Divider(
                                                      color: Colors.transparent,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: CupertinoColors
                                                            .tertiarySystemFill,
                                                      ),
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                        maxLines: null,
                                                        style: TextStyle(
                                                            fontFamily: 'Cairo',
                                                            fontSize: 12),
                                                        controller: review,
                                                        cursorColor: mainColor,
                                                        decoration: InputDecoration(
                                                            contentPadding:
                                                                EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        10),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        10),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                    width: 2)),
                                                            disabledBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        10),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .transparent,
                                                                    width: 2)),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(10),
                                                                borderSide: BorderSide(color: mainColor, width: 2)),
                                                            focusColor: mainColor,
                                                            hoverColor: mainColor,
                                                            border: InputBorder.none,
                                                            labelText: 'تقييم',
                                                            hintText: 'اكتب تقييمك هنا',
                                                            hintStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                                                            labelStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                                                            floatingLabelBehavior: FloatingLabelBehavior.never),
                                                      ),
                                                    ),
                                                    Divider(
                                                      color: Colors.transparent,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          5),
                                                              onPrimary: Colors
                                                                  .white38,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              var nameFunc = await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'users')
                                                                  .doc(FirebaseAuth
                                                                      .instance
                                                                      .currentUser!
                                                                      .uid)
                                                                  .get()
                                                                  .then((value) =>
                                                                      value[
                                                                          'firstname']);

                                                              String name =
                                                                  nameFunc;
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'reviews')
                                                                  .doc(FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid +
                                                                      widget
                                                                          .itemID)
                                                                  .set({
                                                                'username':
                                                                    name,
                                                                'itemName':
                                                                    widget
                                                                        .itemID,
                                                                'content':
                                                                    review.text
                                                                        .trim(),
                                                                'star': star
                                                              });

                                                              snackBarWidget(
                                                                  context,
                                                                  'تم التقييم بنجاح',
                                                                  Icons.check,
                                                                  Colors.white);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Center(
                                                              child: Text(
                                                                'تقييم المنتج',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }
                              },
                              child: Center(
                                child: Text(
                                  'تقييم المنتج',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          widget.description,
                          style: TextStyle(
                            color: mainColor,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'اسحب لترى جميع المنتجات',
                            style: TextStyle(
                              color: mainColor,
                            ),
                          ),
                          VerticalDivider(color: Colors.transparent),
                          Icon(
                            Icons.arrow_forward,
                            color: mainColor,
                          ),
                        ],
                      ),
                      Container(
                        height: 150,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  VerticalDivider(
                                    color: Colors.transparent,
                                  ),
                              itemCount: items.length - 1,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                List<Item> displayItems = items
                                    .where((element) =>
                                        element.name != widget.name)
                                    .toList();
                                return AnimationLimiter(
                                  child: AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 500),
                                    child: ScaleAnimation(
                                      child: FadeInAnimation(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => DetailScreen(
                                                        isLiked:
                                                            displayItems[index]
                                                                .isLiked,
                                                        itemID:
                                                            displayItems[index]
                                                                .itemID,
                                                        description:
                                                            displayItems[index]
                                                                .description,
                                                        image:
                                                            displayItems[index]
                                                                .image,
                                                        name:
                                                            displayItems[index]
                                                                .name,
                                                        quantity:
                                                            displayItems[index]
                                                                .quantity,
                                                        price:
                                                            displayItems[index]
                                                                .price)));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: mainColor,
                                                width: 2,
                                              ),
                                              color: itemColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            height: 150,
                                            width: 90,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                    child: CachedNetworkImage(
                                                  imageUrl:
                                                      displayItems[index].image,
                                                  progressIndicatorBuilder: (context,
                                                          url,
                                                          downloadProgress) =>
                                                      CupertinoActivityIndicator(
                                                          radius: 10),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(
                                                    Icons.error,
                                                    color: Colors.white,
                                                  ),
                                                  fit: BoxFit.cover,
                                                )),
                                                Text(
                                                  displayItems[index].name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  child: Text(
                                                      '${displayItems[index].price.toString()} ريال'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs
        .map(
          (doc) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
            child: new Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: mainColor, width: 2),
                color: itemColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(children: [
                Row(
                  children: [
                    FittedBox(child: Text(doc['username'])),
                    VerticalDivider(color: Colors.transparent),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: RatingBar(
                          initialRating: (doc["star"] as int).toDouble(),
                          ignoreGestures: true,
                          glowColor: mainColor,
                          ratingWidget: RatingWidget(
                            empty: Icon(CupertinoIcons.star, color: mainColor),
                            half: Icon(CupertinoIcons.star_lefthalf_fill,
                                color: mainColor),
                            full: Icon(CupertinoIcons.star_fill,
                                color: mainColor),
                          ),
                          onRatingUpdate: (rating) {}),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Text(doc["content"]),
              ]),
            ),
          ),
        )
        .toList();
  }
}
