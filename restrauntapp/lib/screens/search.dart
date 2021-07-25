import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/data/data.dart';
import 'package:restrauntapp/main.dart';
import 'package:restrauntapp/screens/detailscreen.dart';
import 'package:restrauntapp/widgets/textfield.dart';

class SearchPage extends StatefulWidget {
  bool enabled;
  SearchPage({required this.enabled});
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
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
                    items.forEach((item) {
                      if (item.name.contains(text)) searchResult.add(item);
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
            child: widget.enabled
                ? Container(
                    padding: EdgeInsets.all(7),
                    child: Shimmering(enabled: widget.enabled))
                : search.text.isEmpty
                    ? Container(
                        padding: EdgeInsets.all(7),
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
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                      description: items[index]
                                                          .description,
                                                      price: items[index].price,
                                                      image: items[index].image,
                                                      name: items[index].name,
                                                      quantity: items[index]
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
                                              imageUrl: items[index].image,
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
                                                  CupertinoActivityIndicator(
                                                      radius: 10),
                                              errorWidget:
                                                  (context, url, error) => Icon(
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
                                          textDirection: TextDirection.ltr,
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
                      )
                    : Container(
                        padding: EdgeInsets.all(7),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 0.7),
                          // physics: NeverScrollableScrollPhysics(),
                          itemCount: searchResult.length,
                          itemBuilder: (context, index) => AnimationLimiter(
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
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                      description:
                                                          searchResult[index]
                                                              .description,
                                                      price: searchResult[index]
                                                          .price,
                                                      image: searchResult[index]
                                                          .image,
                                                      name:
                                                          searchResult[index]
                                                              .name,
                                                      quantity:
                                                          searchResult[index]
                                                              .quantity)));
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                            child: Hero(
                                          tag: searchResult[index].name,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  searchResult[index].image,
                                              progressIndicatorBuilder: (context,
                                                      url, downloadProgress) =>
                                                  CupertinoActivityIndicator(
                                                      radius: 10),
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                Icons.error,
                                                color: Colors.white,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )),
                                        Text(
                                          searchResult[index].name,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Directionality(
                                          textDirection: TextDirection.ltr,
                                          child: Text(
                                              '${searchResult[index].price.toString()} SAR'),
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
        ],
      ),
    );
  }
}
