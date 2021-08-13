import 'package:flutter/material.dart';
import 'package:restrauntapp/constants/constants.dart';

class SettingsList extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback? onTap;
  const SettingsList({this.onTap, required this.iconData, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Material(
        elevation: 20,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        shadowColor: Colors.white,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: onTap ?? () {},
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
      ),
    );
  }
}
