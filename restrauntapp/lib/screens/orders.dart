import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/data/data.dart';
import 'package:restrauntapp/screens/detailscreen.dart';

class PreviousOrders extends StatefulWidget {
  const PreviousOrders({Key? key}) : super(key: key);

  @override
  _PreviousOrdersState createState() => _PreviousOrdersState();
}

class _PreviousOrdersState extends State<PreviousOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Divider(),
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
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('orders')
                    .where('userId',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    if (!snapshot.data!.docs.isEmpty) {
                      return ListView(
                          children: getExpenseItems(snapshot, context));
                    } else {
                      return Center(
                        child: Text(
                          'لا يوجد أي تقييمات',
                          style: TextStyle(
                              color: mainColor, fontWeight: FontWeight.bold),
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
        ),
      ),
    );
  }
}

getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot, context) {
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
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: mainColor, width: 2),
            ),
            isScrollControlled: true,
            context: context,
            builder: (context) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return SafeArea(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  padding: EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Expanded(
                        child: ListView.separated(
                            separatorBuilder: (context, index) => Divider(
                                  color: Colors.transparent,
                                ),
                            itemCount: trueornot.length,
                            itemBuilder: (context, index) {
                              return AnimationLimiter(
                                child: AnimationLimiter(
                                  child: AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 500),
                                    delay: Duration(milliseconds: 200),
                                    child: ScaleAnimation(
                                      child: FadeInAnimation(
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailScreen(
                                                            itemID: trueornot[
                                                                    index]
                                                                .itemID,
                                                            description:
                                                                trueornot[index]
                                                                    .description,
                                                            image: trueornot[
                                                                    index]
                                                                .image,
                                                            name:
                                                                trueornot[index]
                                                                    .name,
                                                            quantity:
                                                                trueornot[index]
                                                                    .quantity,
                                                            price:
                                                                trueornot[index]
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 10),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        height: 80,
                                                        width: 80,
                                                        imageUrl:
                                                            trueornot[index]
                                                                .image,
                                                        progressIndicatorBuilder:
                                                            (context, url,
                                                                    downloadProgress) =>
                                                                CupertinoActivityIndicator(
                                                                    radius: 10),
                                                        errorWidget: (context,
                                                                url, error) =>
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
                                                              .symmetric(
                                                          vertical: 10),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            trueornot[index]
                                                                .name,
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
                                                    prices[index].toString(),
                                                    style: TextStyle(
                                                      color: mainColor,
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
                  ]),
                ),
              );
            }),
          );
        },
        child: new Container(
          height: 100,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: mainColor, width: 2),
            color: itemColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(doc['fullPrice'].toString() + ' ريال'),
              Text(
                  "${datetime.year.toString()}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString()}"),
            ],
          ),
        ),
      ),
    );
  }).toList();
}
