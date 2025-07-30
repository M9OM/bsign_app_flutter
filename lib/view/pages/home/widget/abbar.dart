import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onNotificationTap;
  final VoidCallback onProfileTap;
  final String profileImageUrl;

  const HomeAppBar({
    super.key,
    required this.onNotificationTap,
    required this.onProfileTap,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: IconButton(
    icon:  Icon(HugeIcons.strokeRoundedMenu09), // 🔄 Your custom icon
    onPressed: () {
      Scaffold.of(context).openDrawer(); // or your custom logic if using SideMenu
    },
  ),

      actions: [
        IconButton(
          icon: const Icon(HugeIcons.strokeRoundedNotification02),
          onPressed: onNotificationTap,
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: InkWell(
            onTap: onProfileTap,
            child: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(profileImageUrl),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}