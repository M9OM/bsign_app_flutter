// import 'package:bsign/core/config/app_color.dart';
// import 'package:bsign/view/widgets/my_bg.dart';
// import 'package:flutter/material.dart';
// import 'package:hugeicons/hugeicons.dart';

// class SettingsApp extends StatelessWidget {
//   const SettingsApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: const SettingsPage(),
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: Colors.white,
//       ),
//     );
//   }
// }

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({super.key});

//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   bool isDarkMode = false;

//   @override
//   Widget build(BuildContext context) {
//     return MyBackground(
//       child: Scaffold(
//         backgroundColor: Colors.white.withOpacity(0.8),

//         appBar: AppBar(
//           title: const Text('Settings'),
//           elevation: 0,
//           centerTitle: false,
//           backgroundColor: Colors.transparent,
//           foregroundColor: Colors.black,
//         ),
//         body: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             _sectionTitle("General"),
//             _card([
//               ListTile(
//                 trailing: const Icon(Icons.chevron_right),
//                 leading: CircleAvatar(
//                   radius: 20,
//                   backgroundImage: NetworkImage(
//                     'https://i.pinimg.com/736x/2a/07/36/2a0736b064272c56efdd8b482448964e.jpg',
//                   ),
//                   backgroundColor: Colors.transparent,
//                 ),
//                 title: const Text('Mohammed Said'),
//                 subtitle: const Text('sautma223@gmail.com'),

//                 onTap: () {},
//               ),
//             ]),
//             _card([
//               SwitchListTile(
//                 secondary: const Icon(HugeIcons.strokeRoundedMoon),
//                 title: const Text('Switch themes'),
//                 value: isDarkMode,
//                 onChanged: (value) {
//                   setState(() {
//                     isDarkMode = value;
//                   });
//                 },
//               ),

//               ListTile(
//                 leading: const Icon(HugeIcons.strokeRoundedEdit01),
//                 title: const Text('Signature'),
//                 trailing: const Icon(Icons.chevron_right),
//                 onTap: () {},
//               ),



//               ListTile(
//                 leading: const Icon(HugeIcons.strokeRoundedLanguageCircle),
//                 title: const Text('Language'),
//                 trailing: const Icon(Icons.chevron_right),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(HugeIcons.strokeRoundedHelpCircle),
//                 title: const Text('FAQ'),
//                 trailing: const Icon(Icons.chevron_right),
//                 onTap: () {},
//               ),
//             ]),
//             _sectionTitle("Privacy"),
//             _card([
//               ListTile(
//                 leading: const Icon(HugeIcons.strokeRoundedLockPassword),
//                 title: const Text('Terms and conditions'),
//                 trailing: const Icon(Icons.chevron_right),
//                 onTap: () {},
//               ),
//             ]),
//             ListTile(
//               leading: const Icon(HugeIcons.strokeRoundedLogout02),
//               title: const Text('Sign out'),
//               onTap: () {},
//             ),

//             // _card(isRed: true, [
//             //   ListTile(
//             //     leading: const Icon(
//             //       HugeIcons.strokeRoundedLockPassword,
//             //       color: Colors.red,
//             //     ),
//             //     title: const Text('Delete account'),

//             //     onTap: () {},
//             //   ),
//             // ]),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _sectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w500,
//           color: Colors.grey,
//         ),
//       ),
//     );
//   }

// Widget _card(List<Widget> children, {bool isRed = false}) {
//   return Card(
//     elevation: 0,
//     color: isRed
//         ? Colors.red.withOpacity(0.2)
//         : AppColors.primary.withOpacity(0.05),
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//     child: Column(
//       children: ListTile.divideTiles(

        
//         context: context,
//         tiles: children,
//         color: Colors.grey.withOpacity(0.2), // لون الخط الفاصل
//       ).toList(),
//     ),
//   );
// }

// }
