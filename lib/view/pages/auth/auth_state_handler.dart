import 'package:bsign/core/supabase_config.dart';
import 'package:bsign/providers/auth_provider.dart';
import 'package:bsign/view/pages/auth/registration_screen.dart';
import 'package:bsign/view/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:uni_links/uni_links.dart';



class AuthStateHandler extends StatefulWidget {
  const AuthStateHandler({super.key});

  @override
  State<AuthStateHandler> createState() => _AuthStateHandlerState();
}

class _AuthStateHandlerState extends State<AuthStateHandler> {
  @override
  void initState() {
    super.initState();
    final auth = Provider.of<AuthProvider>(context, listen: false);
final user = Supabase.instance.client.auth.currentUser;
print('User ID: ${user?.id}');

    // Listen to Supabase auth state changes if you want to react dynamically
    SupabaseConfig.client.auth.onAuthStateChange.listen((data) {

      auth.loadUserModel();


      setState(() {}); // rebuild to update UI on login/logout
    });
  }



void initUniLinks() async {
  // This listens for links while app is running
  // uriLinkStream.listen((Uri? uri) {
  //   if (uri != null) {
  //     Supabase.instance.client.auth.recoverSession(uri.toString());
  //   }
  // });

  // Also handle initial link if app was opened via link
  // final initialUri = await getInitialUri();
  // if (initialUri != null) {
  //   Supabase.instance.client.auth.recoverSession(initialUri.toString());
  // }
}


  @override
  Widget build(BuildContext context) {
    final user = SupabaseConfig.client.auth.currentUser;

    if (user != null) {
      // User is logged in → show HomeScreen
      return HomeScreen();
    } else {
      // Not logged in → show login/signup screen
      return LoginSignupPage();
    }
  }
}
