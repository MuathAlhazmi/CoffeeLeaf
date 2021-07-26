import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              ],
            ),
            Divider(
              color: Colors.white,
            ),
            Expanded(
                child: ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.transparent,
                        ),
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                      itemID: cart[index].itemID,
                                      description: cart[index].description,
                                      image: cart[index].image,
                                      name: cart[index].name,
                                      quantity: cart[index].quantity,
                                      price: cart[index].price)));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          height: 90,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    height: 80,
                                    width: 80,
                                    imageUrl: cart[index].image,
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        CupertinoActivityIndicator(radius: 10),
                                    errorWidget: (context, url, error) => Icon(
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        cart[index].name,
                                        style: TextStyle(
                                          color: itemColor,
                                        ),
                                      ),
                                      Text(
                                        'SAR ${cart[index].price.toString()}',
                                        style: TextStyle(
                                          color: itemColor,
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
                                      horizontal: 15, vertical: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (cart[index].quantity < 5) {
                                            setState(() {
                                              cart[index].quantity++;
                                            });
                                          }
                                        },
                                        child: Material(
                                          elevation: 10,
                                          shadowColor: mainColor,
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              color: itemColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                                        cart[index].quantity.toString(),
                                        style: TextStyle(
                                          color: itemColor,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (cart[index].quantity > 1) {
                                            setState(() {
                                              cart[index].quantity--;
                                            });
                                          }
                                          if (cart[index].quantity == 1) {
                                            setState(() {
                                              showDialog(
                                                context: context,
                                                builder: (context) => Dialog(
                                                  insetPadding:
                                                      EdgeInsets.all(20),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  elevation: 0,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    shadowColor: mainColor,
                                                    elevation: 20,
                                                    child: BackdropFilter(
                                                      filter: ImageFilter.blur(
                                                          sigmaX: 10,
                                                          sigmaY: 10),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Container(
                                                          height: 300,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                  vertical: 30),
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .rectangle,
                                                              color: mainColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
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
                                                                        color:
                                                                            itemColor,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  Divider(
                                                                    color: Colors
                                                                        .transparent,
                                                                  ),
                                                                  Text(
                                                                    'هل تريد حذف من سلتك ${cart[index].name}',
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          itemColor,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Divider(
                                                                color: Colors
                                                                    .transparent,
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
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              20,
                                                                          vertical:
                                                                              5),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            mainColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
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
                                                                    onTap: () {
                                                                      var element =
                                                                          cart.elementAt(
                                                                              index);

                                                                      setState(
                                                                          () {
                                                                        cart.removeAt(
                                                                            index);
                                                                      });

                                                                      Navigator.pop(
                                                                          context);

                                                                      showFlash(
                                                                          context:
                                                                              context,
                                                                          duration: const Duration(
                                                                              seconds:
                                                                                  2),
                                                                          persistent:
                                                                              true,
                                                                          builder:
                                                                              (_, controller) {
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
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              20,
                                                                          vertical:
                                                                              5),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color:
                                                                            itemColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          'تأكيد',
                                                                          style:
                                                                              TextStyle(color: mainColor),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                          }
                                        },
                                        child: Material(
                                          elevation: 10,
                                          shadowColor: mainColor,
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              color: itemColor,
                                              borderRadius:
                                                  BorderRadius.circular(5),
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
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () async {
                    if (hasauth) {
                      await _authenticateMe();
                      if (authenticated) {
                        cart.clear();
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
                      snackBarWidget(
                          context, 'تم الطلب بنجاح', Icons.check, Colors.white);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'الذهاب إلى الدفع',
                        style: TextStyle(
                          color: Colors.white,
                        ),
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
}
