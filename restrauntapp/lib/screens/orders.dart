import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:local_auth/local_auth.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/data/data.dart';
import 'package:restrauntapp/main.dart';
import 'package:restrauntapp/screens/detailscreen.dart';
import 'package:restrauntapp/widgets/snackbar.dart';
import 'package:timelines/timelines.dart';

class PreviousOrders extends StatefulWidget {
  const PreviousOrders({Key? key}) : super(key: key);

  @override
  _PreviousOrdersState createState() => _PreviousOrdersState();
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

class _PreviousOrdersState extends State<PreviousOrders> {
  @override
  void initState() {
    checkingForBioMetrics();
    super.initState();
  }

  bool descending = true;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    TabBar(
                      enableFeedback: true,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator:
                          CircleTabIndicator(color: mainColor, radius: 4),
                      isScrollable: true,
                      indicatorColor: mainColor,
                      unselectedLabelStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold),
                      labelStyle: TextStyle(
                          color: mainColor,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold),
                      labelColor: mainColor,
                      unselectedLabelColor: mainColor.withOpacity(.4),
                      tabs: [
                        Tab(
                          text: "الطلبات",
                        ),
                        Tab(
                          text: "الطلبات الملغية",
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (descending) {
                              descending = false;
                              snackBarWidget(
                                  context,
                                  'تم تصفية الطلبات من الاقدم إلى الأجدد',
                                  Icons.check,
                                  Colors.white);
                            } else {
                              descending = true;
                              snackBarWidget(
                                  context,
                                  'تم تصفية الطلبات من الاجدد إلى الاقدم',
                                  Icons.check,
                                  Colors.white);
                            }
                          });
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            CupertinoIcons.sort_up_circle,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(children: [
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('orders')
                          .where('userId',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .orderBy(
                            'placedDate',
                            descending: descending,
                          )
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if (!snapshot.data!.docs.isEmpty) {
                            return ListView(
                                children: getExpenseItems(
                                    snapshot,
                                    context,
                                    hasauth,
                                    false,
                                    _localAuthentication,
                                    authenticated));
                          } else {
                            return Center(
                              child: Text(
                                'لا يوجد أي  طلبات',
                                style: TextStyle(
                                    color: mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }
                        } else {
                          return CupertinoActivityIndicator();
                        }
                      },
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('canceledOrders')
                          .where('userId',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .orderBy(
                            'placedDate',
                            descending: descending,
                          )
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if (!snapshot.data!.docs.isEmpty) {
                            return ListView(
                                children: getExpenseItems(
                                    snapshot,
                                    context,
                                    hasauth,
                                    true,
                                    _localAuthentication,
                                    authenticated));
                          } else {
                            return Center(
                              child: Text(
                                'لا يوجد أي  طلبات ملغية',
                                style: TextStyle(
                                    color: mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }
                        } else {
                          return CupertinoActivityIndicator();
                        }
                      },
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot, context, hasauth,
    canceled, _localAuthentication, authenticated) {
  return snapshot.data!.docs.map((doc) {
    List trueornot = [];
    DateTime datetime = doc['placedDate'].toDate();

    (doc['items'] as List).forEach((element1) {
      List where =
          items.where((element) => element.itemID == element1).toList();
      where.forEach((element2) {
        trueornot.add(element2);
      });
    });
    List prices = [];

    (doc['itemsQuantity'] as List).forEach((element1) {
      prices.add(element1);
    });
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
      child: Container(
        height: 180,
        child: Stack(
          children: [
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              shadowColor: Colors.white,
              elevation: 10,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: mainColor, width: 2),
                  color: itemColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              doc['fullPrice'].toString() + ' ريال',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                              ),
                            ),
                            Divider(color: Colors.transparent),
                            Text(
                              " ${datetime.hour.toString()}:${datetime.minute.toString()}   ${datetime.year.toString()}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString()}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: itemColor,
                                onPrimary: Colors.black12,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: mainColor, width: 2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () async {
                                Future<void> _authenticateMe() async {
                                  try {
                                    authenticated =
                                        await _localAuthentication.authenticate(
                                      localizedReason:
                                          "Authenticate for Testing",
                                      useErrorDialogs: true,
                                      stickyAuth: true,
                                    );
                                  } catch (e) {
                                    print(e);
                                  }
                                }

                                if (hasauth) {
                                  await _authenticateMe();
                                  if (authenticated) {
                                    cart.clear();
                                    List<num> prices = [];
                                    cart.forEach((element) {
                                      prices.add(element.price);
                                    });

                                    FirebaseFirestore.instance
                                        .collection('orders')
                                        .add({
                                      'userId': FirebaseAuth
                                          .instance.currentUser!.uid,
                                      'fullPrice': doc['fullPrice'],
                                      'items': doc['items'],
                                      'itemsQuantity': doc['itemsQuantity'],
                                      'placedDate': DateTime.now()
                                    });
                                    snackBarWidget(context, 'تم الطلب بنجاح',
                                        Icons.check, Colors.white);
                                  } else {
                                    snackBarWidget(
                                        context,
                                        'لم يتم الطلب بنجاح',
                                        Icons.error,
                                        Colors.white);
                                  }
                                } else {
                                  cart.clear();
                                  snackBarWidget(context, 'تم الطلب بنجاح',
                                      Icons.check, Colors.white);
                                }
                              },
                              child: Center(
                                child: Text(
                                  'إعادة الطلب',
                                  style: TextStyle(
                                    color: mainColor,
                                  ),
                                ),
                              ),
                            ),
                            VerticalDivider(
                              color: Colors.transparent,
                            ),
                            canceled
                                ? Text(
                                    'ملغية',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  )
                                : Text(
                                    'جار المعالجة',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: mainColor,
                                    ),
                                  ),
                          ],
                        )
                      ]),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 45,
                width: MediaQuery.of(context).size.width * 0.45,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'التفاصيل',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPressed: () {
                          final _processes = [
                            'جار المعالجة',
                            'تم التأكيد',
                            'تحت الاعداد',
                            'تم الاستلام',
                          ];

                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: mainColor, width: 2),
                            ),
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              List<_TimelineStatus> data = [
                                _TimelineStatus.inProgress,
                                _TimelineStatus.todo,
                                _TimelineStatus.todo,
                                _TimelineStatus.todo
                              ];

                              return SafeArea(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 10,
                                  ),
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        canceled
                                            ? Container()
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'اسحب لترى جميع المراحل',
                                                    style: TextStyle(
                                                      color: mainColor,
                                                    ),
                                                  ),
                                                  VerticalDivider(
                                                      color:
                                                          Colors.transparent),
                                                  Icon(
                                                    Icons.arrow_forward,
                                                    color: mainColor,
                                                  ),
                                                ],
                                              ),
                                        Container(
                                          height: 80,
                                          child: canceled
                                              ? Container()
                                              : Timeline.tileBuilder(
                                                  theme: TimelineThemeData(
                                                    direction: Axis.horizontal,
                                                    nodePosition: 0,
                                                    color: Color(0xffc2c5c9),
                                                    connectorTheme:
                                                        ConnectorThemeData(
                                                      thickness: 3.0,
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      top: 20.0),
                                                  builder: TimelineTileBuilder
                                                      .connected(
                                                    indicatorBuilder:
                                                        (context, index) {
                                                      return DotIndicator(
                                                          size: 25,
                                                          color: data[index]
                                                                  .isInProgress
                                                              ? mainColor
                                                              : data[index].done
                                                                  ? mainColor
                                                                  : null,
                                                          child: data[index]
                                                                  .isInProgress
                                                              ? CupertinoTheme(
                                                                  data: CupertinoThemeData(
                                                                      brightness:
                                                                          Brightness
                                                                              .dark),
                                                                  child:
                                                                      CupertinoActivityIndicator(
                                                                    radius: 8,
                                                                  ))
                                                              : null);
                                                    },
                                                    connectorBuilder: (_, index,
                                                        connectorType) {
                                                      var color;
                                                      if (index + 1 <
                                                          data.length - 1) {
                                                        color = data[index]
                                                                        .done &&
                                                                    data[index +
                                                                            1]
                                                                        .isInProgress ||
                                                                data[index]
                                                                        .done &&
                                                                    data[index +
                                                                            1]
                                                                        .done
                                                            ? mainColor
                                                            : null;
                                                      }
                                                      return SolidLineConnector(
                                                        indent: connectorType ==
                                                                ConnectorType
                                                                    .start
                                                            ? 0
                                                            : 2.0,
                                                        endIndent:
                                                            connectorType ==
                                                                    ConnectorType
                                                                        .end
                                                                ? 0
                                                                : 2.0,
                                                        color: color,
                                                      );
                                                    },
                                                    contentsBuilder: (_,
                                                            index) =>
                                                        Text(_processes[index]),
                                                    itemExtentBuilder: (_, __) {
                                                      return 100;
                                                    },
                                                    itemCount: data.length,
                                                  ),
                                                ),
                                        ),
                                        Divider(
                                          color: Colors.transparent,
                                        ),
                                        Expanded(
                                            child: ListView.separated(
                                                separatorBuilder: (context,
                                                        index) =>
                                                    Divider(
                                                      color: Colors.transparent,
                                                    ),
                                                itemCount: trueornot.length,
                                                itemBuilder: (context, index) {
                                                  return AnimationLimiter(
                                                    child: AnimationLimiter(
                                                      child:
                                                          AnimationConfiguration
                                                              .staggeredList(
                                                        position: index,
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    500),
                                                        delay: Duration(
                                                            milliseconds: 200),
                                                        child: ScaleAnimation(
                                                          child:
                                                              FadeInAnimation(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            DetailScreen(
                                                                              itemID: trueornot[index].itemID,
                                                                              description: trueornot[index].description,
                                                                              image: trueornot[index].image,
                                                                              name: trueornot[index].name,
                                                                              quantity: trueornot[index].quantity,
                                                                              price: trueornot[index].price,
                                                                              isLiked: trueornot[index].isLiked,
                                                                            )));
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      20,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color:
                                                                          mainColor,
                                                                      width: 2),
                                                                  color:
                                                                      itemColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                ),
                                                                height: 102,
                                                                child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(vertical: 10),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            height:
                                                                                80,
                                                                            width:
                                                                                80,
                                                                            imageUrl:
                                                                                trueornot[index].image,
                                                                            progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                                                CupertinoActivityIndicator(radius: 10),
                                                                            errorWidget: (context, url, error) =>
                                                                                Icon(
                                                                              Icons.error,
                                                                              color: Colors.white,
                                                                            ),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      VerticalDivider(
                                                                        color: Colors
                                                                            .transparent,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(vertical: 10),
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              Text(
                                                                                trueornot[index].name,
                                                                                style: TextStyle(
                                                                                  color: mainColor,
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                '${trueornot[index].price.toString()} ريال',
                                                                                style: TextStyle(
                                                                                  color: mainColor,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        prices[index]
                                                                            .toString(),
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              mainColor,
                                                                        ),
                                                                      ),
                                                                    ]),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              canceled
                                                  ? Expanded(
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          elevation: 0,
                                                          primary: itemColor,
                                                          onPrimary:
                                                              Colors.black12,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color:
                                                                    mainColor,
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .doc(
                                                                  'canceledOrders/${doc.id}')
                                                              .delete();
                                                          snackBarWidget(
                                                              context,
                                                              'تم حذف الطلب بنجاح',
                                                              Icons.check,
                                                              Colors.white);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('حذف الطلب',
                                                            style: TextStyle(
                                                                color:
                                                                    mainColor)),
                                                      ),
                                                    )
                                                  : Expanded(
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          elevation: 0,
                                                          primary: itemColor,
                                                          onPrimary:
                                                              Colors.black12,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color:
                                                                    mainColor,
                                                                width: 2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        onPressed: () async {
                                                          showDialog(
                                                            context: context,
                                                            builder:
                                                                (context) =>
                                                                    Dialog(
                                                              insetPadding:
                                                                  EdgeInsets
                                                                      .all(20),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                side:
                                                                    BorderSide(
                                                                  color:
                                                                      mainColor,
                                                                  width: 2,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              ),
                                                              elevation: 0,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              child: Container(
                                                                height: 300,
                                                                padding: EdgeInsets
                                                                    .symmetric(
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
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                        Divider(
                                                                          color:
                                                                              Colors.transparent,
                                                                        ),
                                                                        Text(
                                                                          'هل تريد الغاء هذا الطلب؟',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                mainColor,
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
                                                                        ElevatedButton(
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            primary:
                                                                                itemColor,
                                                                            onPrimary:
                                                                                Colors.black12,
                                                                            elevation:
                                                                                0,
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
                                                                              'ألغاء',
                                                                              style: TextStyle(
                                                                                color: mainColor,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        ElevatedButton(
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            shape:
                                                                                RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                            ),
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            Future<void>
                                                                                _authenticateMe() async {
                                                                              try {
                                                                                authenticated = await _localAuthentication.authenticate(
                                                                                  localizedReason: "Authenticate for Testing",
                                                                                  useErrorDialogs: true,
                                                                                  stickyAuth: true,
                                                                                );
                                                                              } catch (e) {
                                                                                print(e);
                                                                              }
                                                                            }

                                                                            if (hasauth) {
                                                                              await _authenticateMe();
                                                                              if (authenticated) {
                                                                                await FirebaseFirestore.instance.collection('canceledOrders').add({
                                                                                  'userId': FirebaseAuth.instance.currentUser!.uid,
                                                                                  'fullPrice': doc['fullPrice'],
                                                                                  'items': doc['items'],
                                                                                  'itemsQuantity': doc['itemsQuantity'],
                                                                                  'placedDate': doc['placedDate']
                                                                                });

                                                                                await FirebaseFirestore.instance.doc('orders/${doc.id}').delete();
                                                                                snackBarWidget(context, 'تم إلغاء الطلب بنجاح', Icons.check, Colors.white);
                                                                                Navigator.pushReplacement(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                      builder: (context) => LoadingListPage(),
                                                                                    ));
                                                                              } else {
                                                                                snackBarWidget(context, 'لا يمكنك إلغاء الطلب الآن', Icons.error, Colors.white);
                                                                                Navigator.pop(context);
                                                                              }
                                                                            } else {
                                                                              await FirebaseFirestore.instance.doc('orders/${doc.id}').delete();

                                                                              snackBarWidget(context, 'تم إلغاء الطلب بنجاح', Icons.check, Colors.white);
                                                                              Navigator.pushReplacement(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                    builder: (context) => LoadingListPage(),
                                                                                  ));
                                                                            }
                                                                          },
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Text(
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
                                                        },
                                                        child: Text(
                                                            'الغاء الطلب',
                                                            style: TextStyle(
                                                                color:
                                                                    mainColor)),
                                                      ),
                                                    ),
                                            ]),
                                      ]),
                                ),
                              );
                            }),
                          );
                        },
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
  }).toList();
}

enum _TimelineStatus {
  done,
  sync,
  inProgress,
  todo,
}

extension on _TimelineStatus {
  bool get isInProgress => this == _TimelineStatus.inProgress;
  bool get done => this == _TimelineStatus.done;
}
