import 'package:bsign/view/pages/signer_profile/singer_profile.dart';
import 'package:flutter/material.dart';

class SignerList extends StatelessWidget {
  final List<Map<String, String>> demoSigners = [
    {
      'username': 'AhmedAli',
      'photoURL': 'https://i.pinimg.com/736x/0b/97/6f/0b976f0a7aa1aa43870e1812eee5a55d.jpg',
    },
    {
      'username': 'SalmaYusuf',
      'photoURL': 'https://i.pinimg.com/736x/2a/07/36/2a0736b064272c56efdd8b482448964e.jpg',
    },
    {
      'username': 'JohnDoe',
      'photoURL': 'https://i.pinimg.com/736x/e2/d4/a1/e2d4a1924b2e3e0044ee09cb5f94e33d.jpg',
    },
    {
      'username': 'LailaKhaled',
      'photoURL': 'https://i.pinimg.com/736x/d2/97/2d/d2972d961636b5a26a72ddf633ce65ee.jpg',
    },
    {
      'username': 'OmarFarouk',
      'photoURL': 'https://i.pinimg.com/736x/55/43/cc/5543cc2cd9a0b686e110235e63028f45.jpg',
    },
        {
      'username': 'islamHassan',
      'photoURL': 'https://i.pinimg.com/736x/b2/cc/85/b2cc85e20a1ffb74b5402d9821393662.jpg',
    },

  ];

   SignerList({super.key});

  @override
  Widget build(BuildContext context) {
    if (demoSigners.isEmpty) {
      return const Center(child: Text('No signers found'));
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // عدد الأعمدة
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: demoSigners.length,
      itemBuilder: (context, index) {
        final signer = demoSigners[index];
        final username = signer['username']!;
        final photoURL = signer['photoURL']!;

        return GestureDetector(
          onTap: () {
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => SignerProfilePage(
      avatarUrl: photoURL,
      username: username,
      email: '$username@gmail.com',
      documentsSigned: 5,
      lastSignedAt: DateTime(2025, 5, 15),
    ),
  ),
);
          },  
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(photoURL),
              ),
              const SizedBox(height: 8.0),
              Text(
                username.length < 10 ? username : '${username.substring(0, 10)}...',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
