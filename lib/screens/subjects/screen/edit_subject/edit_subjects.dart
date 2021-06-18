// import 'package:flutter/material.dart';
// import 'package:flutter_iconpicker/flutter_iconpicker.dart';
// import 'package:testgsschoolst/locator.dart';
// import 'package:testgsschoolst/screens/subjects/screen/editIconalert.dart';
// import 'package:testgsschoolst/screens/subjects/services/subjects_model.dart';
// import 'package:testgsschoolst/widget/responsev.dart';

// class EditSubject extends StatefulWidget {
//   EditSubject({Key key, @required this.model}) : super(key: key);
//   final SubjectModel model;
//   @override
//   _EditSubjectState createState() => _EditSubjectState();
// }

// class _EditSubjectState extends State<EditSubject> {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(),
//         body: Container(
//           child: Center(
//             child: Column(
//               children: [
//                 Container(
//                   child: Row(
//                     children: [
//                       Text("Icon",
//                           style: TextStyle(fontSize: Responsive().setSp(22))),
//                       InkWell(
//                         onTap: () {
//                           showEditIconAlert(widget.model, context);
//                         },
//                         child: Icon(
//                           IconData(widget.model.icon,
//                               fontFamily: 'MaterialIcons'),
//                           size: Responsive().setSp(80),
//                           color: Color(widget.model.color),
//                         ),
//                       ),
//                     ],
//                   ),
//                   padding: EdgeInsets.all(9),
//                 ),
//                 Container(
//                   child: Row(
//                     children: [
//                       Text("Color",
//                           style: TextStyle(fontSize: Responsive().setSp(22))),
//                       Container(
//                         height: Responsive().setSp(80),
//                         width: Responsive().setSp(80),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(90),
//                             color: theme.secondaryHeaderColor),
//                       ),
//                     ],
//                   ),
//                   padding: EdgeInsets.all(9),
//                 ),
//                 Text("${widget.model.name}",
//                     style: TextStyle(fontSize: Responsive().setSp(22)))
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   _pickIcon() async {
//     IconData icon = await FlutterIconPicker.showIconPicker(
//       context,
//       iconPickerShape:
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//     );

//     if (icon != null) {
//       iconAndColorNotifer.changeIcon(icon.codePoint);
//     }
//   }
// }
