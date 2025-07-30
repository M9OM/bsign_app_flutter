// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:shimmer/shimmer.dart';

// class SignatureGenerator extends StatefulWidget {
//   const SignatureGenerator({super.key});

//   @override
//   State<SignatureGenerator> createState() => _SignatureGeneratorState();
// }

// class _SignatureGeneratorState extends State<SignatureGenerator> {
//   final TextEditingController _controller = TextEditingController();
//   String name = '';
//   bool isLoading = false;

//   final List<TextStyle Function()> fontStyles = [
//         () => const TextStyle(fontFamily: 'signature1', fontSize: 36),

//     () => const TextStyle(fontFamily: 'signature2', fontSize: 36),
//     () => const TextStyle(fontFamily: 'signature3', fontSize: 36),

//     () => GoogleFonts.allura(fontSize: 36),
//     () => GoogleFonts.parisienne(fontSize: 36),
//   ];

//   final List<TextStyle Function()> arabicFontStyles = [
//     () => GoogleFonts.cairo(fontSize: 36),
//     () => GoogleFonts.amiri(fontSize: 36),
//     () => GoogleFonts.reemKufi(fontSize: 36),
//     () => GoogleFonts.elMessiri(fontSize: 36),
//     () => GoogleFonts.tajawal(fontSize: 36),
//   ];

//   bool isArabic(String text) {
//     final arabicRegExp = RegExp(r'[\u0600-\u06FF]');
//     return arabicRegExp.hasMatch(text);
//   }

//   Future<void> generateSignatures(String value) async {
//     setState(() {
//       isLoading = true;
//       name = value;
//     });

//     await Future.delayed(const Duration(milliseconds: 800));

//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final styles = isArabic(name) ? arabicFontStyles : fontStyles;

//     return Scaffold(
//       appBar: AppBar(title: const Text('Generate Signature')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _controller,
//               decoration: const InputDecoration(

//                 labelText: 'your name',
//                 hintText: 'Enter your name',
//                 border: OutlineInputBorder(

//                   borderRadius: BorderRadius.all(Radius.circular(20.0)),

//                 ),

//               ),
//               onChanged: (val) => generateSignatures(val),
//             ),
//             const SizedBox(height: 20),
//             if (isLoading)
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: styles.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
                      
//                       padding: const EdgeInsets.all(8.0),
//                       child: Shimmer.fromColors(
//                         baseColor: Theme.of(context).primaryColor.withOpacity(0.1),
//                         highlightColor: Theme.of(context).primaryColor.withOpacity(0.155),
//                         child: Container(
//                           height: 75,
//                           decoration: BoxDecoration(
//                             color: Colors.grey.shade300,
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               )
//             else if (name.isNotEmpty)
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: styles.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                                                 height: 75,
//                                                 decoration: BoxDecoration(
                      
//                           color: Theme.of(context).primaryColor.withOpacity(0.08),
//                           borderRadius: BorderRadius.circular(12),
                      
//                         ),
                      
//                         child: Padding(
//                           padding: const EdgeInsets.all(12),
//                           child: Center(
//                             child: Text(
//                               name,
//                               style: styles[index](),
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
