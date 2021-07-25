import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_number/phone_number.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:restrauntapp/constants/constants.dart';
import 'package:restrauntapp/data/data.dart';
import 'package:restrauntapp/main.dart';
import 'package:restrauntapp/screens/detailscreen.dart';
import 'package:restrauntapp/widgets/snackbar.dart';
import 'package:restrauntapp/widgets/textfield.dart';

class SignUp extends StatefulWidget {
  final TextEditingController firstname = TextEditingController();

  final TextEditingController lastname = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                children: [
                  Padding(
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
                ],
              ),
              Divider(
                color: Colors.white,
              ),
              TextFieldWidget(
                onchanged: (string) {},
                labeltext: 'الاسم الاول',
                textController: widget.firstname,
                hinttext: 'محمد',
              ),
              Divider(
                color: Colors.transparent,
              ),
              TextFieldWidget(
                onchanged: (string) {},
                labeltext: 'الاسم الاخير',
                textController: widget.lastname,
                hinttext: 'سليمان',
              ),
              Divider(
                color: Colors.transparent,
              ),
              TextFieldWidget(
                onchanged: (string) {},
                labeltext: 'البريد الالكتروني',
                hinttext: 'mohammed@gmail.com',
                textController: widget.email,
              ),
              Divider(
                color: Colors.transparent,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: CupertinoColors.tertiarySystemFill,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 40,
                  child: TextField(
                    controller: widget.password,
                    obscureText: true,
                    obscuringCharacter: '*',
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        focusColor: mainColor,
                        hoverColor: mainColor,
                        border: InputBorder.none,
                        labelText: 'كلمة السر',
                        hintText: '***********',
                        hintStyle: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                        labelStyle:
                            TextStyle(fontFamily: 'Cairo', fontSize: 12),
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                  ),
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                            email: widget.email.text,
                            password: widget.password.text,
                          );

                          User? user = userCredential.user;
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user!.uid)
                              .set({
                            'email': widget.email.text,
                            'firstname': widget.firstname.text,
                            'lastname': widget.lastname.text,
                          });
                          snackBarWidget(context, "تم تسجيل الدخول بنجاح",
                              Icons.check, Colors.white);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoadingListPage()));
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'email-already-in-use') {
                            snackBarWidget(
                                context,
                                "ان البريد الالكتروني مسجل من قبل",
                                Icons.error,
                                Colors.white);
                          }
                          if (e.code == 'weak-password') {
                            snackBarWidget(context, "ان الرمز المدخل ضعيف",
                                Icons.error, Colors.white);
                          }
                          if (e.code == 'invalid-email') {
                            snackBarWidget(
                                context,
                                "ان البريد الالكتروني غير صحيح",
                                Icons.error,
                                Colors.white);
                          }
                          if (e.code == 'missing-email') {
                            snackBarWidget(context, "ادخل البريد الالكتروني",
                                Icons.error, Colors.white);
                          }
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'انشاء حساب',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.transparent,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreenIOS()));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: itemColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              color: mainColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class LoginScreenIOS extends StatefulWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  _LoginScreenIOSState createState() => _LoginScreenIOSState();
}

class _LoginScreenIOSState extends State<LoginScreenIOS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
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
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                TextFieldWidget(
                  onchanged: (string) {},
                  labeltext: 'البريد الالكتروني',
                  hinttext: 'mohammed@gmail.com',
                  textController: widget.email,
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: CupertinoColors.tertiarySystemFill,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 40,
                    child: TextField(
                      controller: widget.password,
                      obscureText: true,
                      obscuringCharacter: '*',
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 12),
                      cursorColor: mainColor,
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          focusColor: mainColor,
                          hoverColor: mainColor,
                          border: InputBorder.none,
                          labelText: 'كلمة السر',
                          hintText: '***********',
                          hintStyle:
                              TextStyle(fontFamily: 'Cairo', fontSize: 12),
                          labelStyle:
                              TextStyle(fontFamily: 'Cairo', fontSize: 12),
                          floatingLabelBehavior: FloatingLabelBehavior.never),
                    ),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () async {
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithEmailAndPassword(
                                  email: widget.email.text,
                                  password: widget.password.text);

                          snackBarWidget(context, "تم تسجيل الدخول بنجاح",
                              Icons.check, Colors.white);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoadingListPage()));
                        } on FirebaseAuthException catch (e) {
                          print(e);

                          if (e.code == 'user-not-found') {
                            snackBarWidget(
                                context,
                                "لم يتم العثور على هذا الحساب",
                                Icons.error,
                                Colors.white);
                          }
                          if (e.code == 'invalid-email') {
                            snackBarWidget(context, "اكتب البريد الالكتروني",
                                Icons.error, Colors.white);
                          }
                          if (e.code == 'wrong-password') {
                            snackBarWidget(context, "ان الرمز المدخل غير صحيح",
                                Icons.error, Colors.white);
                          }
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
                Divider(color: Colors.transparent),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: itemColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'انشاء حساب',
                              style: TextStyle(
                                color: mainColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();

  final _codeController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String initialCountry = 'KSA';

  CountryCode currentSelection = CountryCode(name: 'KSA');
  loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    print(phone);
    try {
      _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          UserCredential result = await _auth.signInWithCredential(credential);

          User? user = result.user;

          if (user != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    description: items[0].description,
                    price: items[0].price,
                    image: items[0].image,
                    name: items[0].name,
                    quantity: items[0].quantity,
                  ),
                ));
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int? forceResendingToken]) {},
        codeAutoRetrievalTimeout: (String string) {},
      );
    } catch (e) {
      print('2$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(32),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "تسجيل الدخول",
                style: TextStyle(
                    color: mainColor,
                    fontSize: 26,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 16,
              ),
              Form(
                key: formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: TextFieldWidget(
                          onchanged: (string) {},
                          hinttext: '+966123456789',
                          labeltext: 'ادخل رقم جوالك',
                          textController: _phoneController,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          PhoneNumber phoneNumber = await PhoneNumberUtil()
                              .parse(_phoneController.text);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OTPScreen(phoneNumber.international)));
                        } catch (e) {
                          snackBarWidget(context, 'ان الرقم المدخل غير صحيح',
                              Icons.error, Colors.white);
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'ارسال الرقم',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  late String _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: mainColor,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(color: mainColor),
  );
  late Timer _timer;
  int _start = 120;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  late bool exist;

  @override
  Widget build(BuildContext context) {
    Future<bool> checkExist(String docID) async {
      try {
        await FirebaseFirestore.instance.doc("users/$docID").get().then((doc) {
          exist = doc.exists;
        });
        return exist;
      } catch (e) {
        // If any error
        return false;
      }
    }

    return Scaffold(
      key: _scaffoldkey,
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
                ],
              ),
              Divider(
                height: 50,
                color: Colors.transparent,
              ),
              Text("$_start"),
              Divider(
                height: 50,
                color: Colors.transparent,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (_start == 0) {
                          _verifyPhone();
                        } else {
                          snackBarWidget(
                              context,
                              'لا يمكنك إعادة الارسال إلى بعد $_start دقيقة',
                              Icons.error,
                              Colors.white);
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'إعادة الارسال',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 50,
                color: Colors.transparent,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: PinPut(
                    fieldsCount: 6,
                    textStyle:
                        const TextStyle(fontSize: 20.0, color: Colors.white),
                    eachFieldWidth: 40.0,
                    eachFieldHeight: 40.0,
                    focusNode: _pinPutFocusNode,
                    controller: _pinPutController,
                    submittedFieldDecoration: pinPutDecoration.copyWith(
                      color: mainColor,
                    ),
                    selectedFieldDecoration: pinPutDecoration
                        .copyWith(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(5))
                        .copyWith(
                          color: mainColor,
                        ),
                    followingFieldDecoration: pinPutDecoration.copyWith(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(10)),
                    pinAnimationType: PinAnimationType.slide,
                    onSubmit: (pin) async {
                      try {
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                                verificationId: _verificationCode,
                                smsCode: pin))
                            .then((value) async {
                          if (value.user != null) {
                            await checkExist(
                                FirebaseAuth.instance.currentUser!.uid);

                            if (!exist) {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(value.user!.uid)
                                  .set({
                                'number': value.user!.phoneNumber,
                              });
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoFields()),
                                  (route) => false);

                              if (exist) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoadingListPage()),
                                    (route) => false);
                              }
                            }
                          }
                        });
                      } catch (e) {
                        print(e);
                        FocusScope.of(context).unfocus();
                        snackBarWidget(
                          context,
                          'ان الكود المدخل غير صحيح',
                          Icons.error,
                          Colors.white,
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoadingListPage()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int? resendToken) {
          startTimer();
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }
}

class InfoFields extends StatefulWidget {
  const InfoFields({Key? key}) : super(key: key);

  @override
  _InfoFieldsState createState() => _InfoFieldsState();
}

class _InfoFieldsState extends State<InfoFields> {
  TextEditingController firstnameT = TextEditingController();
  TextEditingController emailT = TextEditingController();
  TextEditingController lastnameT = TextEditingController();

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
                ],
              ),
              Divider(
                color: Colors.white,
              ),
              TextFieldWidget(
                  onchanged: (string) {},
                  labeltext: 'الاسم الاول',
                  textController: firstnameT,
                  hinttext: 'ادخل اسمك الاول'),
              Divider(
                color: Colors.transparent,
              ),
              TextFieldWidget(
                  onchanged: (string) {},
                  labeltext: 'الاسم الاخير',
                  textController: lastnameT,
                  hinttext: 'ادخل اسمك الاخير'),
              Divider(
                color: Colors.transparent,
              ),
              TextFieldWidget(
                  onchanged: (string) {},
                  labeltext: 'البريد الالكتروني',
                  textController: emailT,
                  hinttext: 'ادخل بريدك الالكتروني'),
              Divider(
                color: Colors.transparent,
              ),
              Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () async {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .update({
                        'firstname': firstnameT.text,
                        'lastname': lastnameT.text,
                        'email': emailT.text,
                      });

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoadingListPage()),
                          (route) => false);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
