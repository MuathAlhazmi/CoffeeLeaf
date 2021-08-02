import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restrauntapp/constants/constants.dart';

class InfoPage extends StatelessWidget {
  final List<String> content;
  final List<IconData> iconDataList;
  final List<String> contentTitle;
  final String title;
  final String sub;
  final String image;
  const InfoPage(
      {required this.content,
      required this.image,
      required this.title,
      required this.sub,
      required this.contentTitle,
      required this.iconDataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              children: [
                Row(
                  children: [
                    Hero(
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
                Hero(
                  tag: image + title,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      height: MediaQuery.of(context).size.height * .2,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: FittedBox(
                        child: Text(
                          title,
                          style: TextStyle(
                              color: mainColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: FittedBox(
                    child: Text(
                      sub,
                      style: TextStyle(
                        color: mainColor,
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: mainColor,
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              child: Text(
                                content.first,
                                style: TextStyle(
                                    color: mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Icon(
                              iconDataList.first,
                              color: mainColor,
                            ),
                          ),
                          Expanded(
                            child: VerticalDivider(
                              color: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        contentTitle.first,
                        style: TextStyle(
                          color: mainColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: mainColor,
                  thickness: 2,
                  height: 30,
                ),
                Container(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: FittedBox(
                                child: Text(
                                  content[1],
                                  style: TextStyle(
                                      color: mainColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Icon(
                                iconDataList[1],
                                color: mainColor,
                              ),
                            ),
                            Expanded(
                              child: VerticalDivider(
                                color: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          contentTitle[1],
                          style: TextStyle(
                            color: mainColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: mainColor,
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              child: Text(
                                content[2],
                                style: TextStyle(
                                    color: mainColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Icon(
                              iconDataList[2],
                              color: mainColor,
                            ),
                          ),
                          Expanded(
                            child: VerticalDivider(
                              color: Colors.transparent,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        contentTitle[2],
                        style: TextStyle(
                          color: mainColor,
                        ),
                      ),
                    ],
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
