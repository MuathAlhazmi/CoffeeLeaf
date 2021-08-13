import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restrauntapp/constants/constants.dart';

class MenuImage extends StatelessWidget {
  const MenuImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/menu.png',
                                ))),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
