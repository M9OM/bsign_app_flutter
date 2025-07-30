import 'package:flutter/material.dart';

class CustomEmptyState extends StatelessWidget {
  final String message;
  final IconData icon;

  const CustomEmptyState({
    super.key,
    this.message = 'No Data Available',
    this.icon = Icons.inbox,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: Colors.grey),
          const SizedBox(height: 12),
          Text(message, style: const TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }
}
