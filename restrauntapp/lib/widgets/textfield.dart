import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restrauntapp/constants/constants.dart';

class TextFieldWidget extends StatelessWidget {
  final String labeltext;
  final String hinttext;
  final Function(String) onchanged;
  final TextEditingController textController;
  const TextFieldWidget(
      {required this.labeltext,
      required this.textController,
      required this.hinttext,
      required this.onchanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CupertinoColors.tertiarySystemFill,
      ),
      height: 40,
      child: TextField(
        onChanged: (string) => onchanged(string),
        style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
        controller: this.textController,
        cursorColor: mainColor,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.transparent, width: 2)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.transparent, width: 2)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: mainColor, width: 2)),
            focusColor: mainColor,
            hoverColor: mainColor,
            border: InputBorder.none,
            labelText: '${this.labeltext}',
            hintText: '${this.hinttext}',
            hintStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12),
            labelStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12),
            floatingLabelBehavior: FloatingLabelBehavior.never),
      ),
    );
  }
}
