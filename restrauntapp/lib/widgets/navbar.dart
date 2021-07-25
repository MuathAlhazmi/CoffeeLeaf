import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';
import 'package:restrauntapp/constants/constants.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final List<CustomBottomNavigationItem> children;
  final Function(int) onChange;
  final int currentIndex;

  const CustomBottomNavigationBar(
      {required this.currentIndex,
      required this.children,
      required this.onChange});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  void _changeIndex(int index) {
    if (widget.onChange != null) {
      widget.onChange(index);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
        color: mainColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 90,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: widget.children.map((item) {
            var color = item.color;
            var icon = item.icon;
            int index = widget.children.indexOf(item);
            return GestureDetector(
              onTap: () {
                _changeIndex(index);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  widget.currentIndex == index
                      ? DecoratedIcon(
                          icon,
                          size: 20,
                          color: widget.currentIndex == index
                              ? color
                              : Colors.grey,
                          shadows: [
                            BoxShadow(
                              blurRadius: 15.0,
                              color: Colors.white.withOpacity(.7),
                            ),
                            BoxShadow(
                              blurRadius: 20.0,
                              color: Colors.white.withOpacity(.4),
                              offset: Offset(0, 2.0),
                            ),
                          ],
                        )
                      : DecoratedIcon(
                          icon,
                          size: 20,
                          color: widget.currentIndex == index
                              ? color
                              : Colors.grey,
                        ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class CustomBottomNavigationItem {
  final IconData icon;
  final Color color;

  CustomBottomNavigationItem({required this.icon, required this.color});
}
