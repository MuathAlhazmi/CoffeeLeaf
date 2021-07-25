import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/data/data.dart';
import 'package:restrauntapp/models/models.dart';
import 'package:restrauntapp/screens/cart.dart';
import 'package:restrauntapp/widgets/snackbar.dart';

class DetailScreen extends StatefulWidget {
  final String? description;
  final String name;
  final String image;
  final num price;
  int quantity;
  DetailScreen(
      {required this.image,
      this.description,
      required this.name,
      required this.quantity,
      required this.price});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          color: mainColor,
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 90,
        child: SafeArea(
          top: false,
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
                      snackBarWidget(
                          context,
                          'تم اضافة ${widget.quantity.toString()} ${widget.name} الى سلة التسوق',
                          Icons.check,
                          Colors.white);
                      setState(() {
                        cart.add(Item(
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
      ),
      backgroundColor: itemColor,
      body: Container(
        child: SafeArea(
          child: NestedScrollView(
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
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          decoration: BoxDecoration(
                            color: mainColor.withOpacity(.7),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Text(
                            widget.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13.0,
                            ),
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
                        widget.description ?? '',
                        style: TextStyle(
                          color: itemColor,
                        ),
                      ),
                    ),
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
                                  .where(
                                      (element) => element.name != widget.name)
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
                                                  builder: (context) =>
                                                      DetailScreen(
                                                          description:
                                                              displayItems[
                                                                      index]
                                                                  .description,
                                                          image: displayItems[
                                                                  index]
                                                              .image,
                                                          name: displayItems[
                                                                  index]
                                                              .name,
                                                          quantity:
                                                              displayItems[
                                                                      index]
                                                                  .quantity,
                                                          price: displayItems[
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
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                  child: Hero(
                                                tag: displayItems[index].name,
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
                                                ),
                                              )),
                                              Text(
                                                displayItems[index].name,
                                                overflow: TextOverflow.ellipsis,
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
    );
  }
}
