import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/data/data.dart';
import 'package:restrauntapp/helpers/responsive.dart';
import 'package:restrauntapp/models/models.dart';
import 'package:restrauntapp/screens/detailscreen.dart';
import 'package:restrauntapp/widgets/textfield.dart';

class FavouritesPage extends StatefulWidget {
  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  final TextEditingController search = TextEditingController();
  List<Item> searchResult = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                Row(
                  children: [
                    Expanded(
                      child: TextFieldWidget(
                        labeltext: 'البحث',
                        textController: search,
                        hinttext: 'قم بالبحث هنا',
                        onchanged: (text) {
                          searchResult.clear();
                          if (text.isEmpty) {
                            setState(() {});
                            return;
                          }
                          if (searchResult.length == 0) {}
                          favourite.forEach((item) {
                            if (item.name.contains(text))
                              searchResult.add(item);
                          });

                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Expanded(
                  child: search.text.isEmpty
                      ? favourite.isEmpty
                          ? Container(
                              child: Center(
                                child: Text(
                                  'لا يوجد أي  منتج في المفضلات',
                                  style: TextStyle(
                                      color: mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(7),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio:
                                            Responsive.isDesktop(context)
                                                ? 1.4
                                                : Responsive.isTablet(context)
                                                    ? 1.2
                                                    : 0.7),
                                itemCount: favourite.length,
                                itemBuilder: (context, index) =>
                                    AnimationLimiter(
                                  child: AnimationLimiter(
                                    child: AnimationLimiter(
                                      child:
                                          AnimationConfiguration.staggeredList(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        delay: Duration(milliseconds: 200),
                                        child: ScaleAnimation(
                                          child: FadeInAnimation(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: mainColor,
                                                  width: 2,
                                                ),
                                                color: itemColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => DetailScreen(
                                                              isLiked:
                                                                  favourite[index]
                                                                      .isLiked,
                                                              itemID:
                                                                  favourite[index]
                                                                      .itemID,
                                                              description:
                                                                  favourite[index]
                                                                      .description,
                                                              price:
                                                                  favourite[index]
                                                                      .price,
                                                              image: favourite[
                                                                      index]
                                                                  .image,
                                                              name: favourite[
                                                                      index]
                                                                  .name,
                                                              quantity: favourite[
                                                                      index]
                                                                  .quantity)));
                                                },
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Expanded(
                                                        child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            favourite[index]
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
                                                    )),
                                                    Text(
                                                      favourite[index].name,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Directionality(
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      child: Text(
                                                          '${favourite[index].price.toString()} ريال'),
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
                            )
                      : searchResult.isEmpty
                          ? Container(
                              child: Center(
                                child: Text(
                                  'لا يوجد أي  منتج في المفضلات',
                                  style: TextStyle(
                                      color: mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(7),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        childAspectRatio:
                                            Responsive.isDesktop(context)
                                                ? 1.4
                                                : Responsive.isTablet(context)
                                                    ? 1.2
                                                    : 0.7),
                                // physics: NeverScrollableScrollPhysics(),
                                itemCount: searchResult.length,
                                itemBuilder: (context, index) =>
                                    AnimationLimiter(
                                  child: AnimationLimiter(
                                    child: AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      delay: Duration(milliseconds: 200),
                                      child: ScaleAnimation(
                                        child: FadeInAnimation(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: mainColor,
                                                width: 2,
                                              ),
                                              color: itemColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => DetailScreen(
                                                            isLiked:
                                                                searchResult[index]
                                                                    .isLiked,
                                                            itemID:
                                                                searchResult[index]
                                                                    .itemID,
                                                            description:
                                                                searchResult[index]
                                                                    .description,
                                                            price:
                                                                searchResult[index]
                                                                    .price,
                                                            image: searchResult[
                                                                    index]
                                                                .image,
                                                            name: searchResult[
                                                                    index]
                                                                .name,
                                                            quantity:
                                                                searchResult[
                                                                        index]
                                                                    .quantity)));
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Expanded(
                                                      child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          searchResult[index]
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
                                                  )),
                                                  Text(
                                                    searchResult[index].name,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Directionality(
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    child: Text(
                                                        '${searchResult[index].price.toString()} ريال'),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
