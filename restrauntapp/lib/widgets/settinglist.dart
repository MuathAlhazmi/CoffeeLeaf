import 'package:flutter/material.dart';
import 'package:restrauntapp/constants/constants.dart';

class SettingsList extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback? onTap;
  const SettingsList({this.onTap, required this.iconData, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        decoration: BoxDecoration(
          color: mainColor,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  iconData,
                  size: 18,
                  color: itemColor,
                ),
                VerticalDivider(
                  color: Colors.transparent,
                ),
                Text(
                  '$title',
                  style: TextStyle(
                    fontSize: 12,
                    color: itemColor,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: itemColor,
            ),
          ],
        ),
      ),
    );
  }
}
