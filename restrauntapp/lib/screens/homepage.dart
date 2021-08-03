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
import 'package:restrauntapp/screens/tablebooking.dart';
import 'package:restrauntapp/widgets/carousel.dart';

class HomePage extends StatefulWidget {
  bool enabled;
  HomePage({Key? key, required this.enabled});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    List<Widget> carouselWidgets = [
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TableBooking(
                        image:
                            'https://images.unsplash.com/photo-1502749793729-68bfc5666aaa?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=3300&q=80',
                        title: 'هل تريد حجز طاولة؟',
                        sub: 'اضغط هنا لكي تحجز الآن',
                      )));
        },
        child: CarouselWidget(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: mainColor.withOpacity(.3),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FittedBox(
                          child: Text(
                            'هل تريد حجز طاولة؟',
                            style: Theme.of(context).textTheme.headline5!.apply(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: FittedBox(
                            child: Text(
                              'اضغط هنا لكي تحجز الآن',
                              style:
                                  Theme.of(context).textTheme.subtitle1!.apply(
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
          imageUrl:
              'https://images.unsplash.com/photo-1502749793729-68bfc5666aaa?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=3300&q=80',
          title: 'هل تريد حجز طاولة؟',
        ),
      ),
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
                      contentTitle: infoModels[1].contentTitle,
                      iconDataList: infoModels[1].iconDataList)));
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
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: mainColor.withOpacity(.3),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FittedBox(
                          child: Text(
                            infoModels[1].title,
                            style: Theme.of(context).textTheme.headline5!.apply(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: FittedBox(
                            child: Text(
                              infoModels[1].sub,
                              style:
                                  Theme.of(context).textTheme.subtitle1!.apply(
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
                      contentTitle: infoModels[0].contentTitle,
                      iconDataList: infoModels[0].iconDataList)));
        },
        child: CarouselWidget(
          title: infoModels[0].title,
          imageUrl: infoModels[0].image,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: mainColor.withOpacity(.3),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FittedBox(
                          child: Text(
                            infoModels[0].title,
                            style: Theme.of(context).textTheme.headline5!.apply(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: FittedBox(
                            child: Text(
                              infoModels[0].sub,
                              style:
                                  Theme.of(context).textTheme.subtitle1!.apply(
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
    ];
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            elevation: 10,
            shadowColor: mainColor,
            leadingWidth: 65,
            leading: Hero(
              tag: 'Back',
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
                      duration: Duration(milliseconds: 100),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          height: kToolbarHeight,
                          imageUrl: snapshot.data.toString(),
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) => Container(),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          fit: BoxFit.contain,
                        ),
                      ),
                    );
                  } else {
                    return Container();
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
                              (context, url, downloadProgress) => Container(),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          fit: BoxFit.contain,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
          ),
        ];
      },
      body: Container(
        color: itemColor,
        width: double.infinity,
        child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Divider(
            color: Colors.transparent,
          ),
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
                      carouselController: _controller,
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                        viewportFraction: 0.7,
                        height: 220.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 500),
                        autoPlayCurve: Curves.easeInOut,
                        pauseAutoPlayOnTouch: true,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            pageIndex = index;
                          });
                        },
                      ),
                      items: carouselWidgets),
                ),
          Divider(
            color: Colors.transparent,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: carouselWidgets.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(
                  entry.key,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                ),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: 20.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: mainColor
                          .withOpacity(pageIndex == entry.key ? 0.9 : 0.5)),
                ),
              );
            }).toList(),
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
              // child: widget.enabled
              //     ? Shimmering(enabled: widget.enabled)
              child: widget.enabled
                  ? Shimmering(enabled: widget.enabled)
                  : Column(children: [
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
                          itemBuilder: (context, index) => AnimationLimiter(
                            child: AnimationLimiter(
                              child: AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 500),
                                delay: Duration(milliseconds: 200),
                                child: ScaleAnimation(
                                  child: FadeInAnimation(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: mainColor, width: 2),
                                        color: itemColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailScreen(
                                                          isLiked: items[index]
                                                              .isLiked,
                                                          itemID: items[index]
                                                              .itemID,
                                                          description:
                                                              items[index]
                                                                  .description,
                                                          price: items[index]
                                                              .price,
                                                          image: items[index]
                                                              .image,
                                                          name:
                                                              items[index].name,
                                                          quantity: items[index]
                                                              .quantity)));
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                                child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                imageUrl: items[index].image,
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
                                              items[index].name,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Text(
                                                  '${items[index].price.toString()} ريال'),
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
                        ),
                      ),
                    ]),
            ),
          )
        ]),
      ),
    );
  }
}
