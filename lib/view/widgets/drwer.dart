import 'package:bsign/extensions/navigator_extensions.dart';
import 'package:bsign/view/pages/my_signers/my_signers_page.dart';
import 'package:bsign/view/pages/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:bsign/extensions/context_extensions.dart'; // adjust path as needed

class AppDrawer extends StatelessWidget {
  final String? username;
  final String? email;
  final String? profileImageUrl;

  const AppDrawer({
    super.key,
     this.username,
     this.email,
     this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor:Colors.transparent,
      width:context.screenWidth * 0.5,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
                
              ListTile(
                leading: Icon(HugeIcons.strokeRoundedHome01),
                title: Text('Home'),
                onTap: () => Navigator.pop(context),
              ),
    
    
              ListTile(
                leading: Icon(HugeIcons.strokeRoundedUser),
                title: Text('Profile'),
                onTap: () => navigateTo(context, SettingsPage())
              ),
    
                  ListTile(
                leading: Icon(HugeIcons.strokeRoundedUserGroup),
                title: Text('My Signers'),
                onTap: () => navigateTo(context, MySignersPage())
              ),
    
    
              ListTile(
                leading: Icon(HugeIcons.strokeRoundedSettings02),
                title: Text('Settings'),
                onTap: () => Navigator.pop(context),
              ),
    
    
    
              ListTile(
                leading: Icon(HugeIcons.strokeRoundedLogout02),
                title: Text('Logout'),
                onTap: () {
                  // Handle logout logic
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
