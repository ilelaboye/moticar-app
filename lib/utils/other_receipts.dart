// // ignore_for_file: deprecated_member_use

// import 'dart:io';
// import 'package:agent_mobile_app/providers/input_formatter.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:pdf/widgets.dart';
// import 'package:open_file/open_file.dart';
// import 'package:share_plus/share_plus.dart';

// import '../../utils/agency_constants.dart';

// class OtherReceiptGenerator {
//   static get details => null;

//   static Future<void> generateReceipt({
//     required String status,
//     required String amount,
//     required String type,
//     required String createdAt,
//     required String phoneNumber,
//     String? message,
//   }) async {
//     final pdf = pw.Document();
//     List<Map<String, dynamic>> details = [
//       {
//         "name": "Amount",
//         "item": amount,
//       },

//       {
//         "name": "Transaction Type",
//         "item": type,
//       },

//       {
//         "name": "Status",
//         "item": status,
//       },

//       {
//         "name": "Message",
//         "item" : message
//       },

//       {
//         "name": "Transaction Date",
//         "item": createdAt,
//       },
//     ];

//     final logo = await rootBundle.load('assets/images/up_newlogo.jpeg');
//     final btss = logo.buffer.asUint8List();
//     final logoImage = pw.MemoryImage(btss);

//     // Add content to the PDF
//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Center(
//             child: pw.Column(
//               mainAxisAlignment: pw.MainAxisAlignment.center,
//               children: [
//                 pw.Container(
//                   // height: 26.h,
//                   // decoration: pw.BoxDecoration(
//                   //     image: pw.DecorationImage(
//                   //         fit: pw.BoxFit.cover,
//                   //         image: pw.MemoryImage(bckImage)),
//                   //         ),
//                   child: pw.Column(children: [
//                     pw.SizedBox(height: 15),
//                     pw.Padding(
//                         padding: const pw.EdgeInsets.all(8),
//                         child: pw.Row(children: [
//                           pw.Image(
//                             logoImage,
//                             height: 80,
//                             width: 80,
//                           ),
//                           // pw.Spacer(),

//                           pw.SizedBox(width: 40),

//                           pw.Text(
//                             'Transaction Summmary ',
//                             style: const pw.TextStyle(
//                               fontSize: 24,
//                             ),
//                           )
//                         ])),
//                     pw.SizedBox(height: 10),
//                     pw.Divider(
//                       color: const PdfColor.fromInt(0xFFF58220),
//                       thickness: 6,
//                     ),
//                     pw.Container(
//                       alignment: pw.Alignment.center,
//                       width: double.infinity,
//                       height: 80,
//                       color: const PdfColor.fromInt(0xffFFFFFF),
//                       child: pw.Column(
//                           mainAxisAlignment: pw.MainAxisAlignment.center,
//                           children: [
//                             pw.Text(
//                               'Transaction Receipt',
//                               textAlign: TextAlign.center,
//                               style: pw.TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             ),
//                             pw.SizedBox(height: 7),
//                             pw.Text(
//                               createdAt,
//                               //DateTime.parse(dateMap['item'])),
//                               style: pw.TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.normal,
//                                 color: const PdfColor.fromInt(0xFF000000),
//                               ),
//                             ),
//                           ]),
//                     ),
//                     pw.SizedBox(height: 5),
//                     pw.Container(
//                       padding: const pw.EdgeInsets.only(
//                           left: 10, right: 10, top: 5, bottom: 5),
//                       child: pw.Column(
//                         children: [
//                           ...details.map(
//                             ((index) {
//                               return pw.Column(
//                                 children: [
//                                   pw.SizedBox(height: 21),
//                                   pw.Row(
//                                     mainAxisAlignment:
//                                         pw.MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       pw.Text(
//                                         index["name"],
//                                         style: pw.TextStyle(
//                                           fontWeight: FontWeight.normal,
//                                           font: Font.timesBold(),
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                       pw.Expanded(
//                                         child: pw.Row(
//                                           children: [
//                                             pw.Expanded(
//                                               child: pw.Text(
//                                                 index["name"] == "Amount:"
//                                                     ? CitFormatter().format(
//                                                         value: index["item"],
//                                                       )
//                                                     : "${index["item"]}",
//                                                 style: pw.TextStyle(
//                                                   font: Font.times(),
//                                                   fontWeight: FontWeight.normal,
//                                                   fontSize: 16,
//                                                   color: const PdfColor.fromInt(
//                                                       0xFF000000),
//                                                 ),
//                                                 textAlign: TextAlign.right,
//                                                 overflow: pw.TextOverflow.clip,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   pw.SizedBox(height: 2),
//                                 ],
//                               );
//                             }),
//                           ),
//                         ],
//                       ),
//                     ),
//                     pw.Divider(
//                       color: const PdfColor.fromInt(0xFFF58220),
//                       thickness: 6,
//                     ),
//                     pw.SizedBox(height: 25),
//                     pw.Padding(
//                       padding: const pw.EdgeInsets.only(left: 8, right: 8),
//                       child: pw.RichText(
//                         text: pw.TextSpan(
//                             text: 'DISCLAIMER: ',
//                             style: pw.TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.bold,
//                               color: const PdfColor.fromInt(0xff000000),
//                               font: Font.timesBold(),
//                             ),
//                             children: [
//                               pw.TextSpan(
//                                 text: disclaimer,
//                                 style: pw.TextStyle(
//                                   // letterSpacing: 0.2,
//                                   fontSize: 12,
//                                   color: const PdfColor.fromInt(0xff000000),
//                                   fontWeight: FontWeight.normal,
//                                   font: Font.times(),
//                                 ),
//                               ),
//                             ]),
//                       ),
//                     ),
//                   ]),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );

//     // Save the PDF to a file
//     final outputDir = await getTemporaryDirectory();
//     final outputFile = File('${outputDir.path}/agency_transaction_summary.pdf');
//     await outputFile.writeAsBytes(await pdf.save());

//     // Share the PDF file
//     Share.shareFiles([outputFile.path], text: 'Transaction Summary PDF');

//     // Open the PDF file
//     OpenFile.open(outputFile.path);
//   }
// }
