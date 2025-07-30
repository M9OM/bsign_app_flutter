import 'package:bsign/core/config/constants.dart';
import 'package:bsign/view/widgets/dialogs/enhanced_blur_action_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';


class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  void _handleTap(BuildContext context, int index) {
    if (index == AppConstants.navActionButtonIndex) {
      EnhancedBlurActionSheet.show(context);
    } else {
      onTap(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(30),
    ),

      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        currentIndex: currentIndex,
        onTap: (index) => _handleTap(context, index),
        type: BottomNavigationBarType.fixed,
        // selectedItemColor: AppConstants.navSelectedColor,
        // unselectedItemColor: AppConstants.navUnselectedColor,
        showSelectedLabels: false,
        elevation:0,
        showUnselectedLabels: false,
        items: _buildNavItems(context),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildNavItems(BuildContext context) {
    return  [
      BottomNavigationBarItem(
        icon: Icon(HugeIcons.strokeRoundedHome01),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          HugeIcons.strokeRoundedAddSquare,
          size: AppConstants.navActionButtonSize,
          color: Theme.of(context).primaryColor,
        ),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(HugeIcons.strokeRoundedInbox),
        label: '',
      ),
    ];
  }
}