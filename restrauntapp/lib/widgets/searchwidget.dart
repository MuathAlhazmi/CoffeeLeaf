import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/models/models.dart';
import 'package:restrauntapp/screens/detailscreen.dart';
import 'package:restrauntapp/widgets/textfield.dart';

import '../main.dart';

class SearchWidget extends StatefulWidget {
  final TextEditingController search;
  List<Item> items;
  List<Item> searchResult;
  final bool enabled;
  SearchWidget(
      {required this.search,
      required this.enabled,
      required this.items,
      required this.searchResult});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFieldWidget(
                    labeltext: 'البحث',
                    textController: widget.search,
                    hinttext: 'قم بالبحث هنا',
                    onchanged: (text) {
                      widget.searchResult.clear();
                      if (text.isEmpty) {
                        setState(() {});
                        return;
                      }
                      if (widget.searchResult.length == 0) {}
                      widget.items.forEach((item) {
                        if (item.name.contains(text))
                          widget.searchResult.add(item);
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
                  : widget.search.text.isEmpty
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
                            itemCount: widget.items.length,
                            itemBuilder: (context, index) => AnimationLimiter(
                              child: AnimationLimiter(
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
                                                      builder: (context) =>
                                                          DetailScreen(
                                                              itemID: widget
                                                                  .items[index]
                                                                  .itemID,
                                                              description: widget
                                                                  .items[index]
                                                                  .description,
                                                              price: widget
                                                                  .items[index]
                                                                  .price,
                                                              image:
                                                                  widget
                                                                      .items[
                                                                          index]
                                                                      .image,
                                                              name: widget
                                                                  .items[index]
                                                                  .name,
                                                              quantity: widget
                                                                  .items[index]
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
                                                    imageUrl: widget
                                                        .items[index].image,
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
                                                  widget.items[index].name,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Directionality(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  child: Text(
                                                      '${widget.items[index].price.toString()} ريال'),
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
                            itemCount: widget.searchResult.length,
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
                                                    builder: (context) =>
                                                        DetailScreen(
                                                            itemID: widget
                                                                .searchResult[
                                                                    index]
                                                                .itemID,
                                                            description: widget
                                                                .searchResult[
                                                                    index]
                                                                .description,
                                                            price: widget
                                                                .searchResult[
                                                                    index]
                                                                .price,
                                                            image: widget
                                                                .searchResult[
                                                                    index]
                                                                .image,
                                                            name: widget
                                                                .searchResult[
                                                                    index]
                                                                .name,
                                                            quantity: widget
                                                                .searchResult[
                                                                    index]
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
                                                  imageUrl: widget
                                                      .searchResult[index]
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
                                                ),
                                              )),
                                              Text(
                                                widget.searchResult[index].name,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: Text(
                                                    '${widget.searchResult[index].price.toString()} ريال'),
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
    );
  }
}
