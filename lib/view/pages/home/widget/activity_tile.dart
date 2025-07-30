import 'package:flutter/material.dart';

class ActivityTile extends StatelessWidget {
  final String count;
  final String title;
  final String description;
  final IconData icon;

  const ActivityTile({
    super.key,
    required this.count,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(width: 1, color: Colors.grey.withOpacity(0.3)),
          color: Colors.grey.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),

    ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon),
                const Spacer(),
                Text(
                  count,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
