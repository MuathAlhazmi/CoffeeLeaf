import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarouselWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Widget child;
  const CarouselWidget(
      {required this.imageUrl, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                width: double.infinity,
                                imageUrl: imageUrl,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CupertinoActivityIndicator(radius: 10),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  color: Colors.white,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          child
        ],
      ),
    );
  }
}
