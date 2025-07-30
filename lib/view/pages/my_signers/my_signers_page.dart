import 'package:bsign/view/pages/my_signers/widgets/signers_list.dart';
import 'package:flutter/material.dart';

class MySignersPage extends StatelessWidget {
  const MySignersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        title: const Text('My Signers'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [Expanded(child: SignerList())],
      ),
    );
  }
}
