// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_masked_text2/flutter_masked_text2.dart';
// import 'package:restrauntapp/constants/constants.dart';
// import 'package:restrauntapp/screens/landingpage.dart';
// import 'package:restrauntapp/widgets/snackbar.dart';
// import 'package:restrauntapp/widgets/textfield.dart';

// class CardControl extends StatefulWidget {
//   const CardControl({Key? key}) : super(key: key);

//   @override
//   _CardControlState createState() => _CardControlState();
// }

// class _CardControlState extends State<CardControl> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: 20,
//           ),
//           child: Container(
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).maybePop();
//                         },
//                         child: Hero(
//                           tag: 'Back',
//                           child: Container(
//                             height: 50,
//                             width: 50,
//                             decoration: BoxDecoration(
//                               color: mainColor,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Icon(
//                               CupertinoIcons.arrow_right,
//                               color: Colors.white,
//                               size: 15,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Divider(
//                   color: Colors.white,
//                 ),
//                 Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       child: GestureDetector(
//                         onTap: () {},
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(
//                                   CupertinoIcons.clear_circled,
//                                   color: mainColor,
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.only(left: 15),
//                                 ),
//                                 Text(
//                                   'اسحب البطاقة لتحذفها',
//                                   style: TextStyle(color: mainColor),
//                                 ),
//                               ],
//                             ),
//                             VerticalDivider(
//                               color: Colors.transparent,
//                             ),
//                             Icon(Icons.arrow_back, color: mainColor),
//                             Icon(Icons.arrow_forward, color: mainColor),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(bottom: 20),
//                 ),
//                 Expanded(
//                     child: Container(
//                   child: StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection('cards')
//                         .where('userId',
//                             isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//                         .snapshots(),
//                     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (snapshot.hasData) {
//                         if (snapshot.data!.docs.length == 0) {
//                           return Container(
//                             child: Center(
//                               child: Text(
//                                 'لا يوجد أي  بطاقة في وسائل الدفع',
//                                 style: TextStyle(
//                                     color: mainColor,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           );
//                         } else {
//                           return Directionality(
//                             textDirection: TextDirection.ltr,
//                             child: Container(
//                               width: MediaQuery.of(context).size.width > 400
//                                   ? 400
//                                   : null,
//                               child: ListView(
//                                 children: snapshot.data!.docs
//                                     .map((doc) => _buildCreditCard(
//                                           cardNumber: doc['cardNumber'],
//                                           cardHolder: doc['cardHolder'],
//                                           cardExpiration: doc['cardExpiration'],
//                                         ))
//                                     .toList(),
//                               ),
//                             ),
//                           );
//                         }
//                       }
//                       return Center(child: CupertinoActivityIndicator());
//                     },
//                   ),
//                 )),
//                 Divider(
//                   color: Colors.transparent,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                             side: BorderSide(
//                               width: 2,
//                               color: mainColor,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           primary: itemColor,
//                           onPrimary: Colors.black12,
//                         ),
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => CreditForm()));
//                         },
//                         child: Center(
//                           child: Text(
//                             'اضافة بطاقة',
//                             style: TextStyle(color: mainColor),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget _buildCreditCard(
//     {required String cardNumber,
//     required String cardHolder,
//     required String cardExpiration}) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Material(
//       elevation: 10,
//       shadowColor: mainColor.withOpacity(.5),
//       borderRadius: BorderRadius.circular(20),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: mainColor, width: 2),
//         ),
//         height: 200,
//         padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             _buildLogosBlock(),
//             Padding(
//               padding: const EdgeInsets.only(top: 16.0),
//               /* Here we are going to place the Card number */
//               child: Text(
//                 '$cardNumber',
//                 style: TextStyle(
//                   fontFamily: 'Cairo',
//                   color: Colors.black,
//                   fontSize: 21,
//                 ),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 _buildDetailsBlock(
//                   label: 'CARDHOLDER',
//                   value: cardHolder,
//                 ),
//                 _buildDetailsBlock(label: 'EXPIRY DATE', value: cardExpiration),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }

// Column _buildDetailsBlock({required String label, required String value}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       Text(
//         '$label',
//         style: TextStyle(
//           color: Colors.black54,
//           fontSize: 9,
//           fontFamily: 'Cairo',
//         ),
//       ),
//       Text(
//         '$value',
//         style: TextStyle(
//           color: Colors.black,
//           fontSize: 15,
//           fontFamily: 'Cairo',
//         ),
//       )
//     ],
//   );
// }

// Row _buildLogosBlock() {
//   return Row(
//     /*1*/
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Image.asset(
//         "assets/images/output-onlinepngtools (2).png",
//         height: 20,
//         width: 18,
//       ),
//       Image.asset(
//         "assets/images/output-onlinepngtools (3).png",
//         height: 50,
//         width: 50,
//       ),
//     ],
//   );
// }

// class CreditForm extends StatefulWidget {
//   const CreditForm({Key? key}) : super(key: key);

//   @override
//   _CreditFormState createState() => _CreditFormState();
// }

// class _CreditFormState extends State<CreditForm> {
//   final TextEditingController cvv = MaskedTextController(
//     mask: '000',
//   );
//   final TextEditingController cardNumber =
//       MaskedTextController(mask: '0000 0000 0000 0000');
//   final TextEditingController cardHolder = TextEditingController();

//   final TextEditingController exp = MaskedTextController(mask: '00/00');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: 20,
//           ),
//           child: GestureDetector(
//             onTap: () {
//               FocusScope.of(context).unfocus();
//             },
//             child: SingleChildScrollView(
//               child: Column(children: [
//                 Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.of(context).maybePop();
//                         },
//                         child: Hero(
//                           tag: 'Back',
//                           child: Container(
//                             height: 50,
//                             width: 50,
//                             decoration: BoxDecoration(
//                               color: mainColor,
//                               borderRadius: BorderRadius.circular(10),
//                             ),
//                             child: Icon(
//                               CupertinoIcons.arrow_right,
//                               color: Colors.white,
//                               size: 15,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Divider(
//                   color: Colors.transparent,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width > 400 ? 400 : null,
//                   child: Directionality(
//                     textDirection: TextDirection.ltr,
//                     child: _buildCreditCard(
//                         cardNumber: cardNumber.text,
//                         cardHolder: cardHolder.text,
//                         cardExpiration: exp.text),
//                   ),
//                 ),
//                 Divider(
//                   height: 30,
//                   color: Colors.transparent,
//                 ),
//                 Directionality(
//                   textDirection: TextDirection.ltr,
//                   child: TextFieldWidget(
//                       labeltext: 'رقم البطاقة',
//                       textController: cardNumber,
//                       hinttext: '1234 5678 9123 4567',
//                       onchanged: (text) {
//                         setState(() {
//                           cardNumber.text = text;
//                         });
//                       }),
//                 ),
//                 Divider(
//                   color: Colors.transparent,
//                 ),
//                 Directionality(
//                   textDirection: TextDirection.ltr,
//                   child: TextFieldWidget(
//                       labeltext: 'جامل البطاقة',
//                       textController: cardHolder,
//                       hinttext: 'محمد سليمان',
//                       onchanged: (text) {
//                         setState(() {
//                           cardHolder.text = text;
//                           cardHolder.selection = TextSelection.fromPosition(
//                               TextPosition(offset: cardHolder.text.length));
//                         });
//                       }),
//                 ),
//                 Divider(
//                   color: Colors.transparent,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Directionality(
//                         textDirection: TextDirection.ltr,
//                         child: TextFieldWidget(
//                             labeltext: 'CVV رقم',
//                             textController: cvv,
//                             hinttext: '123',
//                             onchanged: (text) {
//                               setState(() {
//                                 cvv.text = text;
//                               });
//                             }),
//                       ),
//                     ),
//                     VerticalDivider(
//                       color: Colors.transparent,
//                     ),
//                     Expanded(
//                       child: Directionality(
//                         textDirection: TextDirection.ltr,
//                         child: TextFieldWidget(
//                             labeltext: 'تاريخ الانتهاء',
//                             textController: exp,
//                             hinttext: '01/22',
//                             onchanged: (text) {
//                               setState(() {
//                                 exp.text = text;
//                               });
//                             }),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Divider(
//                   color: Colors.transparent,
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                             side: BorderSide(
//                               width: 2,
//                               color: mainColor,
//                             ),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           primary: itemColor,
//                           onPrimary: Colors.black12,
//                         ),
//                         onPressed: () async {
//                           if (FirebaseFirestore.instance
//                                   .collection('cards')
//                                   .where('cardNumber',
//                                       isEqualTo: cardNumber.text)
//                                   .snapshots()
//                                   .length !=
//                               0) {
//                             await FirebaseFirestore.instance
//                                 .collection('cards')
//                                 .add({
//                               'userId': FirebaseAuth.instance.currentUser!.uid,
//                               'cardHolder': cardHolder.text,
//                               'cardNumber': cardNumber.text,
//                               'cardExpiration': exp.text,
//                               'cvv': cvv.text,
//                             });
//                             snackBarWidget(context, 'تم اضافة البطاقة بنجاح',
//                                 Icons.check, Colors.white);
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => LandingPage()));
//                           } else {
//                             snackBarWidget(
//                                 context,
//                                 'ان يوجد بطاقة بهذا الرقم مسجلة في نظامنا',
//                                 Icons.error,
//                                 Colors.white);
//                           }
//                         },
//                         child: Center(
//                           child: Text(
//                             'اضافة البطاقة',
//                             style: TextStyle(color: mainColor),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//               ]),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
