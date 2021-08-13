import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/data/data.dart';
import 'package:restrauntapp/screens/detailscreen.dart';
import 'package:restrauntapp/screens/landingpage.dart';
import 'package:restrauntapp/widgets/snackbar.dart';

class CartScreens extends StatefulWidget {
  const CartScreens({Key? key}) : super(key: key);

  @override
  _CartScreensState createState() => _CartScreensState();
}

class _CartScreensState extends State<CartScreens> {
  @override
  void initState() {
    checkingForBioMetrics();
    super.initState();
  }

  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool authenticated = false;
  bool hasauth = false;
  Future<bool> checkingForBioMetrics() async {
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    print(canCheckBiometrics);
    if (canCheckBiometrics) {
      setState(() {
        hasauth = true;
      });
    } else {
      setState(() {
        hasauth = false;
      });
    }
    return canCheckBiometrics;
  }

  Future<void> _authenticateMe() async {
    try {
      authenticated = await _localAuthentication.authenticate(
        localizedReason: "Authenticate for Testing",
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } catch (e) {
      print(e);
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    num allPrice = 0;

    var sum = 0;

    for (var i = 0; i < cart.length; i++) {
      allPrice = sum += cart[i].price.toInt() * cart[i].quantity;
    }
    List cartdone = cart.map((e) => e.itemID).toList();
    List cartquantity = cart.map((e) => e.quantity).toList();

    isSeen.value = true;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).maybePop();
                    },
                    child: Hero(
                      tag: 'Back',
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          CupertinoIcons.arrow_right,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.white,
            ),
            Expanded(
                child: cart.length == 0
                    ? SvgPicture.asset(
                        'assets/images/undraw_coffee_break_j3of.svg',
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) => Divider(
                              color: Colors.transparent,
                            ),
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          return AnimationLimiter(
                            child: AnimationLimiter(
                              child: AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 500),
                                delay: Duration(milliseconds: 200),
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                    child: Dismissible(
                                      movementDuration:
                                          Duration(milliseconds: 500),
                                      key: UniqueKey(),
                                      confirmDismiss: (direction) async {
                                        var dismissWidget =
                                            cart.elementAt(index);

                                        return await showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                            insetPadding: EdgeInsets.all(20),
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: mainColor,
                                                width: 2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                                                        'هل انت متأكد؟',
                                                        style: TextStyle(
                                                            color: mainColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Divider(
                                                        color:
                                                            Colors.transparent,
                                                      ),
                                                      Text(
                                                        'هل تريد حذف من سلتك ${dismissWidget.name}',
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
                                                          primary: itemColor,
                                                          onPrimary:
                                                              Colors.black12,
                                                          elevation: 0,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Center(
                                                          child: Text(
                                                            'ألغاء',
                                                            style: TextStyle(
                                                              color: mainColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          Future.delayed(Duration(
                                                                  milliseconds:
                                                                      500))
                                                              .then((_) {
                                                            setState(() {
                                                              cart.remove(
                                                                  dismissWidget);
                                                            });

                                                            Navigator.pop(
                                                                context);

                                                            showFlash(
                                                                context:
                                                                    context,
                                                                duration:
                                                                    const Duration(
                                                                        seconds:
                                                                            2),
                                                                persistent:
                                                                    true,
                                                                builder: (_,
                                                                    controller) {
                                                                  return Flash(
                                                                    margin: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            20),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    controller:
                                                                        controller,
                                                                    backgroundColor:
                                                                        mainColor,
                                                                    barrierBlur:
                                                                        13.0,
                                                                    barrierColor:
                                                                        Colors
                                                                            .black38,
                                                                    barrierDismissible:
                                                                        true,
                                                                    behavior:
                                                                        FlashBehavior
                                                                            .floating,
                                                                    position:
                                                                        FlashPosition
                                                                            .top,
                                                                    child: FlashBar(
                                                                        icon: Icon(Icons.info_outline, color: Colors.white),
                                                                        content: Text(
                                                                          "لقد  حذفت ${dismissWidget.name}",
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: Colors.white,
                                                                              fontFamily: 'Cairo'),
                                                                        ),
                                                                        primaryAction: TextButton(
                                                                            onPressed: () {
                                                                              bool exists = cart.any((file) => file.name == dismissWidget.name);

                                                                              if (exists) {
                                                                              } else {
                                                                                setState(() {
                                                                                  cart.add(dismissWidget);
                                                                                });
                                                                              }
                                                                            },
                                                                            child: Text(
                                                                              'ارجاع المنتج',
                                                                              style: TextStyle(fontSize: 13, color: Colors.white),
                                                                            ))),
                                                                  );
                                                                });
                                                          });
                                                        },
                                                        child: Center(
                                                          child: Text(
                                                            'تأكيد',
                                                            style: TextStyle(
                                                                color:
                                                                    itemColor),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailScreen(
                                                          isLiked: cart[index]
                                                              .isLiked,
                                                          itemID: cart[index]
                                                              .itemID,
                                                          description:
                                                              cart[index]
                                                                  .description,
                                                          image:
                                                              cart[index].image,
                                                          name:
                                                              cart[index].name,
                                                          quantity: cart[index]
                                                              .quantity,
                                                          price: cart[index]
                                                              .price)));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: mainColor, width: 2),
                                            color: itemColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          height: 102,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    height: 80,
                                                    width: 80,
                                                    imageUrl: cart[index].image,
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
                                                  ),
                                                ),
                                              ),
                                              VerticalDivider(
                                                color: Colors.transparent,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        cart[index].name,
                                                        style: TextStyle(
                                                          color: mainColor,
                                                        ),
                                                      ),
                                                      Text(
                                                        '${cart[index].price.toString()} ريال',
                                                        style: TextStyle(
                                                          color: mainColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  print('e');
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (cart[index]
                                                                  .quantity <
                                                              5) {
                                                            setState(() {
                                                              cart[index]
                                                                  .quantity++;
                                                            });
                                                          }
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(3),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    mainColor,
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Icon(
                                                            Icons.add,
                                                            size: 15,
                                                            color: mainColor,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        cart[index]
                                                            .quantity
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: mainColor,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (cart[index]
                                                                  .quantity >
                                                              1) {
                                                            setState(() {
                                                              cart[index]
                                                                  .quantity--;
                                                            });
                                                          }
                                                          if (cart[index]
                                                                  .quantity ==
                                                              1) {
                                                            setState(() {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        Dialog(
                                                                  insetPadding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              20),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    side:
                                                                        BorderSide(
                                                                      color:
                                                                          mainColor,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15),
                                                                  ),
                                                                  elevation: 0,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  child:
                                                                      Container(
                                                                    height: 300,
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            20,
                                                                        vertical:
                                                                            30),
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                            itemColor,
                                                                        shape: BoxShape
                                                                            .rectangle,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        Column(
                                                                          children: [
                                                                            Text(
                                                                              'هل انت متأكد؟',
                                                                              style: TextStyle(color: mainColor, fontWeight: FontWeight.bold),
                                                                            ),
                                                                            Divider(
                                                                              color: Colors.transparent,
                                                                            ),
                                                                            Text(
                                                                              'هل تريد حذف من سلتك ${cart[index].name}',
                                                                              style: TextStyle(
                                                                                color: mainColor,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Divider(
                                                                          color:
                                                                              Colors.transparent,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                primary: itemColor,
                                                                                onPrimary: Colors.black12,
                                                                                elevation: 0,
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                ),
                                                                              ),
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Center(
                                                                                child: Text(
                                                                                  'ألغاء',
                                                                                  style: TextStyle(
                                                                                    color: mainColor,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(10),
                                                                                ),
                                                                              ),
                                                                              onPressed: () {
                                                                                var element = cart.elementAt(index);

                                                                                setState(() {
                                                                                  cart.removeAt(index);
                                                                                });

                                                                                Navigator.pop(context);

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
                                                                                            icon: Icon(Icons.info_outline, color: Colors.white),
                                                                                            content: Text(
                                                                                              "لقد  حذفت ${element.name}",
                                                                                              style: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'Cairo'),
                                                                                            ),
                                                                                            primaryAction: TextButton(
                                                                                                onPressed: () {
                                                                                                  bool exists = cart.any((file) => file.name == element.name);

                                                                                                  if (exists) {
                                                                                                  } else {
                                                                                                    setState(() {
                                                                                                      cart.add(element);
                                                                                                    });
                                                                                                  }
                                                                                                },
                                                                                                child: Text(
                                                                                                  'ارجاع المنتج',
                                                                                                  style: TextStyle(fontSize: 13, color: Colors.white),
                                                                                                ))),
                                                                                      );
                                                                                    });
                                                                              },
                                                                              child: Center(
                                                                                child: Text(
                                                                                  'تأكيد',
                                                                                  style: TextStyle(color: itemColor),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            });
                                                          }
                                                        },
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(3),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    mainColor,
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
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
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: itemColor,
                    border: Border.all(color: mainColor, width: 2),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Center(
                    child: Text(
                      allPrice.toInt().toString() + ' ريال',
                      style: TextStyle(
                          color: mainColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                VerticalDivider(color: Colors.transparent),
                Expanded(
                    child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (cart.length == 0) {
                      snackBarWidget(
                          context,
                          'لا يمكنك اتمام الطلب والعربة فارغة',
                          Icons.error,
                          Colors.white);
                    } else {
                      if (hasauth) {
                        await _authenticateMe();
                        print(cartdone.toString());
                        if (authenticated) {
                          cart.clear();
                          List<num> prices = [];
                          cart.forEach((element) {
                            prices.add(element.price);
                          });

                          FirebaseFirestore.instance.collection('orders').add({
                            'userId': FirebaseAuth.instance.currentUser!.uid,
                            'fullPrice': allPrice,
                            'items': cartdone,
                            'itemsQuantity': cartquantity,
                            'placedDate': DateTime.now()
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LandingPage()));
                          snackBarWidget(context, 'تم الطلب بنجاح', Icons.check,
                              Colors.white);
                        } else {
                          snackBarWidget(context, 'لم يتم الطلب بنجاح',
                              Icons.error, Colors.white);
                        }
                      } else {
                        cart.clear();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LandingPage()));
                        snackBarWidget(context, 'تم الطلب بنجاح', Icons.check,
                            Colors.white);
                      }
                    }
                  },
                  child: Center(
                    child: Text(
                      'الذهاب إلى الدفع',
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
