import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/data/data.dart';
import 'package:restrauntapp/widgets/snackbar.dart';
import 'package:sizer/sizer.dart';

class TableBooking extends StatefulWidget {
  final String title;
  final String sub;
  final String image;
  const TableBooking(
      {required this.image, required this.title, required this.sub});
  @override
  _TableBookingState createState() => _TableBookingState();
}

class _TableBookingState extends State<TableBooking> {
  TimeOfDay _time = TimeOfDay.now().replacing(minute: 30);
  TextEditingController textEditingController = TextEditingController();
  TextEditingController date = TextEditingController(
    text:
        "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString()}",
  );
  DatePickerController _controller = DatePickerController();

  void onTimeChanged(TimeOfDay newTime) {
    setState(() {
      _time = newTime;
    });
  }

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
              child: Column(children: [
                Row(
                  children: [
                    Hero(
                      tag: 'Back',
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
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
                  tag: widget.image + widget.title,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      imageUrl: widget.image,
                      height: MediaQuery.of(context).size.height * .3,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FittedBox(
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              color: mainColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.sp),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: FittedBox(
                    child: Text(
                      widget.sub,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: mainColor,
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CupertinoColors.tertiarySystemFill,
                  ),
                  height: 40,
                  child: TextField(
                    enabled: false,
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                    controller: date,
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 2)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: mainColor, width: 2)),
                        focusColor: mainColor,
                        hoverColor: mainColor,
                        border: InputBorder.none,
                        labelText: 'اختر اليوم',
                        hintStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                        labelStyle:
                            TextStyle(fontFamily: 'Cairo', fontSize: 12),
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: mainColor,
                        width: 2,
                      )),
                  child: DatePicker(
                    DateTime.now(),
                    width: 60,
                    height: 120,
                    locale: 'ar',
                    controller: _controller,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: mainColor,
                    selectedTextColor: Colors.white,
                    inactiveDates: [
                      DateTime.now().add(Duration(days: 3)),
                      DateTime.now().add(Duration(days: 4)),
                      DateTime.now().add(Duration(days: 7))
                    ],
                    deactivatedColor: Colors.black12,
                    onDateChange: (datetime) {
                      String convertedDateTime =
                          "${datetime.year.toString()}-${datetime.month.toString().padLeft(2, '0')}-${datetime.day.toString()}";

                      setState(() {
                        date.text = convertedDateTime;
                      });
                    },
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, _, __) {
                        return Directionality(
                          textDirection: TextDirection.ltr,
                          child: showPicker(
                            blurredBackground: true,
                            minuteInterval: MinuteInterval.FIFTEEN,
                            themeData: ThemeData(
                                primarySwatch: colorCustom,
                                primaryColor: mainColor,
                                textTheme: TextTheme(
                                    button: TextStyle(
                                        color: mainColor,
                                        fontFamily: 'Cairo'))),
                            accentColor: mainColor,
                            value: _time,
                            onChange: (timeOfDay) {
                              setState(() {
                                textEditingController.text =
                                    timeOfDay.format(context);
                              });
                            },
                            is24HrFormat: false,
                          ).buildPage(context, _, __),
                        );
                      },
                      transitionDuration: Duration(milliseconds: 500),
                      transitionsBuilder: (context, anim, secondAnim, child) =>
                          SlideTransition(
                        position: anim.drive(
                          Tween(
                            begin: const Offset(0, 0.15),
                            end: const Offset(0, 0),
                          ).chain(
                            CurveTween(curve: Curves.ease),
                          ),
                        ),
                        child: FadeTransition(
                          opacity: anim,
                          child: child,
                        ),
                      ),
                      barrierDismissible: true,
                      opaque: false,
                      barrierColor: Colors.black45,
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: CupertinoColors.tertiarySystemFill,
                    ),
                    height: 40,
                    child: TextField(
                      enabled: false,
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                      controller: textEditingController,
                      cursorColor: mainColor,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 2)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: mainColor, width: 2)),
                          focusColor: mainColor,
                          hoverColor: mainColor,
                          border: InputBorder.none,
                          labelText: 'اضغط هنا لكي تختار الوقت',
                          hintStyle:
                              TextStyle(fontFamily: 'Cairo', fontSize: 12),
                          labelStyle:
                              TextStyle(fontFamily: 'Cairo', fontSize: 12),
                          floatingLabelBehavior: FloatingLabelBehavior.never),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.white38,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              if (date.text.isNotEmpty &&
                                  textEditingController.text.isNotEmpty) {
                                snackBarWidget(
                                  context,
                                  'تم الحجز بنجاح',
                                  Icons.check,
                                  Colors.white,
                                );
                                Navigator.pop(context);
                              } else {
                                snackBarWidget(
                                  context,
                                  'قم بتعبئة جميع الخانات',
                                  Icons.check,
                                  Colors.white,
                                );
                              }
                            },
                            child: Center(
                              child: Text(
                                'حجز طاولة',
                                style: TextStyle(color: itemColor),
                              ),
                            )))
                  ],
                )
              ]),
            )),
      ),
    );
  }
}
