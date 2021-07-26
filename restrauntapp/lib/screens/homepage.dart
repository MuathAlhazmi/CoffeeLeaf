import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/data/data.dart';
import 'package:restrauntapp/main.dart';
import 'package:restrauntapp/screens/cart.dart';
import 'package:restrauntapp/screens/detailscreen.dart';
import 'package:restrauntapp/screens/info.dart';
import 'package:restrauntapp/widgets/carousel.dart';

class HomePage extends StatefulWidget {
  bool enabled;
  HomePage({Key? key, required this.enabled});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverSafeArea(
            sliver: SliverAppBar(
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
              expandedHeight: MediaQuery.of(context).size.height * 0.2,
              floating: false,
              pinned: true,
              centerTitle: true,
              title: FutureBuilder(
                  future: printUrl1(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return AnimatedOpacity(
                        opacity: innerBoxIsScrolled ? 1 : 0,
                        duration: Duration(milliseconds: 500),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            height: kToolbarHeight,
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
                        ),
                      );
                    } else {
                      return CupertinoActivityIndicator();
                    }
                  }),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: FutureBuilder(
                    future: printUrl1(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            height: 100,
                            width: 100,
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
            ),
          ),
        ];
      },
      body: Container(
        color: itemColor,
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            widget.enabled
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ShimmeringCarousel(
                      enabled: widget.enabled,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 0.7,
                          height: 220.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 500),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          pauseAutoPlayOnTouch: true,
                          aspectRatio: 2.0,
                          onPageChanged: (index, reason) {},
                        ),
                        items: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoPage(
                                          content: infoModels[1].content,
                                          image: infoModels[1].image,
                                          title: infoModels[1].title,
                                          sub: infoModels[1].sub,
                                          contentTitle:
                                              infoModels[1].contentTitle,
                                          iconDataList:
                                              infoModels[1].iconDataList)));
                            },
                            child: CarouselWidget(
                              title: infoModels[1].title,
                              imageUrl: infoModels[1].image,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: mainColor.withOpacity(.3),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            FittedBox(
                                              child: Text(
                                                infoModels[1].title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .apply(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: FittedBox(
                                                child: Text(
                                                  infoModels[1].sub,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1!
                                                      .apply(
                                                        color: Colors.white,
                                                      ),
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoPage(
                                          content: infoModels[0].content,
                                          image: infoModels[0].image,
                                          title: infoModels[0].title,
                                          sub: infoModels[0].sub,
                                          contentTitle:
                                              infoModels[0].contentTitle,
                                          iconDataList:
                                              infoModels[0].iconDataList)));
                            },
                            child: CarouselWidget(
                              title: infoModels[0].title + 'Hero',
                              imageUrl: infoModels[0].image,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5, sigmaY: 5),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: mainColor.withOpacity(.3),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            FittedBox(
                                              child: Text(
                                                infoModels[0].title,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .apply(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: FittedBox(
                                                child: Text(
                                                  infoModels[0].sub,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1!
                                                      .apply(
                                                        color: Colors.white,
                                                      ),
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
                        ]),
                  ),
            Divider(
              color: Colors.transparent,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: TextFieldWidget(
            //           labeltext: 'البحث',
            //           textController: search,
            //           hinttext: 'قم بالبحث هنا',
            //           onchanged: (text) {
            //             searchResult.clear();
            //             if (text.isEmpty) {
            //               setState(() {});
            //               return;
            //             }
            //             if (searchResult.length == 0) {}
            //             items.forEach((item) {
            //               if (item.name.contains(text)) searchResult.add(item);
            //             });

            //             setState(() {});
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                  ),
                  decoration: BoxDecoration(
                    color: itemColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: widget.enabled
                      ? Shimmering(enabled: widget.enabled)
                      : Column(
                          children: [
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio: 0.7),
                                // physics: NeverScrollableScrollPhysics(),
                                itemCount: items.length,
                                itemBuilder: (context, index) =>
                                    AnimationLimiter(
                                  child: AnimationConfiguration.staggeredGrid(
                                    columnCount: 3,
                                    position: index,
                                    child: Container(
                                      height: 100,
                                      padding: EdgeInsets.all(7),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: mainColor,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: itemColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailScreen(
                                                            itemID: items[index]
                                                                .itemID,
                                                            description: items[
                                                                    index]
                                                                .description,
                                                            price: items[index]
                                                                .price,
                                                            image: items[index]
                                                                .image,
                                                            name: items[index]
                                                                .name,
                                                            quantity: items[
                                                                    index]
                                                                .quantity)));
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                  child: Hero(
                                                tag: items[index].name,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        items[index].image,
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
                                              )),
                                              Text(
                                                items[index].name,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Directionality(
                                                textDirection:
                                                    TextDirection.ltr,
                                                child: Text(
                                                    '${items[index].price.toString()} SAR'),
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
                          ],
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
