import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/data/data.dart';
import 'package:restrauntapp/models/models.dart';
import 'package:restrauntapp/screens/cart.dart';
import 'package:restrauntapp/widgets/snackbar.dart';

class DetailScreen extends StatefulWidget {
  final String description;
  final String name;
  final String image;
  final String itemID;
  final num price;
  int quantity;
  DetailScreen(
      {required this.image,
      required this.itemID,
      required this.description,
      required this.name,
      required this.quantity,
      required this.price});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ScrollController _scrollController = ScrollController();

  final TextEditingController review = TextEditingController();
  int star = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: mainColor,
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              color: mainColor,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'SAR ${widget.price}',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
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
                        child: Material(
                          elevation: 10,
                          shadowColor: mainColor,
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: itemColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 15,
                              color: mainColor,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        widget.quantity.toString(),
                        style: TextStyle(
                          color: itemColor,
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
                        child: Material(
                          elevation: 10,
                          shadowColor: mainColor,
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: itemColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Icons.remove,
                              size: 15,
                              color: mainColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
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
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: itemColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add_shopping_cart,
                        color: mainColor,
                        size: 18,
                      ),
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
                      leadingWidth: 65,
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).maybePop();
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              CupertinoIcons.arrow_right,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Scaffold(
                                    body: CartScreens(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
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
                            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
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
                        background: Hero(
                            tag: widget.name,
                            child: CachedNetworkImage(
                              imageUrl: widget.image,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CupertinoActivityIndicator(radius: 10),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                              fit: BoxFit.cover,
                            )),
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
                                return GestureDetector(
                                  onTap: () {
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
                                                          color: mainColor,
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
                                                                    itemColor,
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
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          'اضغط هنا لتقرأ المزيد',
                                          style: TextStyle(
                                              color: itemColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Divider(
                                          color: Colors.transparent,
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              '(${snapshot.data!.docs.length})  ${average.toInt().toString()} ',
                                              style: TextStyle(
                                                  color: itemColor,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Directionality(
                                              textDirection: TextDirection.ltr,
                                              child: RatingBar(
                                                  initialRating:
                                                      average.toDouble(),
                                                  ignoreGestures: true,
                                                  glowColor: mainColor,
                                                  ratingWidget: RatingWidget(
                                                    empty: Icon(
                                                        CupertinoIcons.star,
                                                        color: itemColor),
                                                    half: Icon(
                                                        CupertinoIcons
                                                            .star_lefthalf_fill,
                                                        color: itemColor),
                                                    full: Icon(
                                                        CupertinoIcons
                                                            .star_fill,
                                                        color: itemColor),
                                                  ),
                                                  onRatingUpdate: (rating) {}),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(10),
                        shadowColor: mainColor,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            widget.description,
                            style: TextStyle(
                              color: itemColor,
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
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
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 0,
                                      backgroundColor: Colors.transparent,
                                      child: Material(
                                        color: Colors.transparent,
                                        shadowColor: mainColor,
                                        elevation: 20,
                                        child: BackdropFilter(
                                          filter: ImageFilter.blur(
                                              sigmaX: 10, sigmaY: 10),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Container(
                                              height: 300,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 30),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: mainColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          'هل اتت متأكد؟',
                                                          style: TextStyle(
                                                              color: itemColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Divider(
                                                          color: Colors
                                                              .transparent,
                                                        ),
                                                        Text(
                                                          'هل تريد حذق تقييمك السابق؟',
                                                          style: TextStyle(
                                                            color: itemColor,
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
                                                          GestureDetector(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20,
                                                                      vertical:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    mainColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  'ألغاء',
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        itemColor,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () async {
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
                                                                  .delete();
                                                              Navigator.pop(
                                                                  context);
                                                              showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  context:
                                                                      context,
                                                                  elevation:
                                                                      100,
                                                                  builder:
                                                                      (context) {
                                                                    return Padding(
                                                                      padding: EdgeInsets.symmetric(
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
                                                                            padding:
                                                                                MediaQuery.of(context).viewInsets,
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              children: [
                                                                                Directionality(
                                                                                  textDirection: TextDirection.ltr,
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
                                                                                  color: Colors.transparent,
                                                                                ),
                                                                                Container(
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    color: CupertinoColors.tertiarySystemFill,
                                                                                  ),
                                                                                  child: TextField(
                                                                                    keyboardType: TextInputType.multiline,
                                                                                    maxLines: null,
                                                                                    style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                                                                                    controller: review,
                                                                                    cursorColor: mainColor,
                                                                                    decoration: InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 10), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.transparent, width: 2)), disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.transparent, width: 2)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: mainColor, width: 2)), focusColor: mainColor, hoverColor: mainColor, border: InputBorder.none, labelText: 'تقييم', hintText: 'اكتب تقييمك هنا', hintStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12), labelStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12), floatingLabelBehavior: FloatingLabelBehavior.never),
                                                                                  ),
                                                                                ),
                                                                                Divider(
                                                                                  color: Colors.transparent,
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    Expanded(
                                                                                      child: GestureDetector(
                                                                                        onTap: () async {
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
                                                                                        child: Container(
                                                                                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                                                                          decoration: BoxDecoration(
                                                                                            color: mainColor,
                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                          ),
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              'تقييم المنتج',
                                                                                              style: TextStyle(
                                                                                                color: Colors.white,
                                                                                              ),
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
                                                                      horizontal:
                                                                          20,
                                                                      vertical:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    itemColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  'تأكيد',
                                                                  style: TextStyle(
                                                                      color:
                                                                          mainColor),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ]),
                                                  ]),
                                            ),
                                          ),
                                        ),
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
                                                          child:
                                                              GestureDetector(
                                                            onTap: () async {
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
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20,
                                                                      vertical:
                                                                          5),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    mainColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                              ),
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
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                  color: mainColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    'تقييم المنتج',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
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
                        height: 150,
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(10),
                          shadowColor: mainColor,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: mainColor,
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
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: ScaleAnimation(
                                        child: FadeInAnimation(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailScreen(
                                                              itemID: displayItems[
                                                                      index]
                                                                  .itemID,
                                                              description:
                                                                  displayItems[
                                                                          index]
                                                                      .description,
                                                              image:
                                                                  displayItems[
                                                                          index]
                                                                      .image,
                                                              name:
                                                                  displayItems[
                                                                          index]
                                                                      .name,
                                                              quantity:
                                                                  displayItems[
                                                                          index]
                                                                      .quantity,
                                                              price:
                                                                  displayItems[
                                                                          index]
                                                                      .price)));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: itemColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              height: 150,
                                              width: 90,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Expanded(
                                                      child: CachedNetworkImage(
                                                    imageUrl:
                                                        displayItems[index]
                                                            .image,
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
                                                        '${displayItems[index].price.toString()} SAR'),
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
                          full:
                              Icon(CupertinoIcons.star_fill, color: mainColor),
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
