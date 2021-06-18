// import 'package:flutter/material.dart';
// import 'package:fw_ticket/fw_ticket.dart';
// import 'package:testgsschoolst/widget/responsev.dart';
// import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';
// import 'package:skeleton_loader/skeleton_loader.dart';

// class LoadingSkeleton extends StatelessWidget {
//   const LoadingSkeleton({
//     Key key,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return SkeletonGridLoader(
//       builder: Container(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Ticket(
//                 innerRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(10.0),
//                     bottomRight: Radius.circular(10.0)),
//                 outerRadius: BorderRadius.all(Radius.circular(10.0)),
//                 boxShadow: [
//                   BoxShadow(
//                     offset: Offset(0, 4.0),
//                     blurRadius: 2.0,
//                     spreadRadius: 2.0,
//                   )
//                 ],
//                 child: Container(
//                   child: Container(
//                     height: 130,
//                     width: MediaQuery.of(context).size.width,
//                   ),
//                   foregroundDecoration: RotatedCornerDecoration(
//                     color: Colors.black,
//                     textSpan: TextSpan(
//                       text: '99 %',
//                       style:
//                           TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                     ),
//                     geometry: BadgeGeometry(
//                         width: Responsive().setSp(120),
//                         height: Responsive().setSp(120),
//                         cornerRadius: 8),
//                   ),
//                 ),
//               ),
//               Ticket(
//                 innerRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10.0),
//                     topRight: Radius.circular(10.0)),
//                 outerRadius: BorderRadius.all(Radius.circular(10.0)),
//                 boxShadow: [
//                   BoxShadow(
//                     offset: Offset(0, 4),
//                     blurRadius: 2.0,
//                     spreadRadius: 2.0,
//                   )
//                 ],
//                 child: Container(
//                   color: Colors.black12,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       Divider(height: 0.0),
//                       Align(
//                         alignment: AlignmentDirectional.centerStart,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text(
//                                     ' ',
//                                   ),
//                                   FittedBox(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(5),
//                                       child: Text(
//                                         ' ',
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w400,
//                                             fontSize: 18.0),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//       items: 6,
//       itemsPerRow: MediaQuery.of(context).size.width > 600 ? 2 : 1,
//       period: Duration(seconds: 2),
//       highlightColor: Colors.grey[100],
//       direction: SkeletonDirection.ltr,
//       childAspectRatio: 1.4,
//     );
//   }
// }
