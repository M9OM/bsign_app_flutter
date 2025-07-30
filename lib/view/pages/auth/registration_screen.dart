import 'package:animate_do/animate_do.dart';
import 'package:bsign/extensions/url_launcher_extension.dart';
import 'package:bsign/providers/auth_provider.dart';
import 'package:bsign/view/pages/auth/otp_page.dart' show OtpPage;
import 'package:bsign/view/widgets/custom_text_field.dart';
import 'package:bsign/view/widgets/my_bg.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:bsign/extensions/navigator_extensions.dart';
import 'package:provider/provider.dart';
// ضع هذا في أعلى الملف

class LoginSignupPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // مفتاح النموذج

  LoginSignupPage({super.key});

  @override
Widget build(BuildContext context) {
  return MyBackground(
    child: Scaffold(
      body: Stack(
        children: [
          _buildBackground(),
          Center(
            child: FadeInUp(
              duration: const Duration(milliseconds: 1200),
              child: SingleChildScrollView(
                child: _buildCard(context),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}


  Widget _buildBackground() {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 221, 221, 221),
            Color.fromARGB(255, 194, 194, 194),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      // decoration: BoxDecoration(
      //   color: AppColors.background.withOpacity(0.3),
      //   borderRadius: BorderRadius.circular(30),

      // ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildLogo(context),
          const SizedBox(height: 5),
          _buildSignInRow(context),
          const SizedBox(height: 20),
          _buildInputFields(),
          _buildTermsAndConditions(),
          const SizedBox(height: 20),
          _buildRegisterButton(context),
          const SizedBox(height: 20),
          const Text('------ or -------', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 10),
          _buildSocialButtons(context),
        ],
      ),
    );
  }

Widget _buildLogo(BuildContext context) {
  return FadeInUp(
    duration: const Duration(milliseconds: 700),
    child: RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: 'B',
            style: TextStyle(color: const Color.fromARGB(255, 0, 20, 238),),
          ),
           TextSpan(
            text: 'sign',
            style: TextStyle(color: Theme.of(context).iconTheme.color),
            // style: TextStyle(),
          ),
        ],
      ),
    ),
  );
}


  Widget _buildSignInRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Log in or sign up ', style: TextStyle(color: Colors.grey )),

      ],
    );
  }

Widget _buildInputFields() {
  return Form(
    key: _formKey,
    child: Column(
      children: [
        CustomInputField(
          
          hint: 'Your e-mail',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Email is required';
            }
            final email = value.trim();
            final regex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
            if (!regex.hasMatch(email)) {
              return 'Enter a valid email';
            }
            return null;
          },
        ),
      ],
    ),
  );
}


  Widget _buildTermsAndConditions() {
    return Align(
      alignment: Alignment.centerRight,
      child: RichText(
        text: TextSpan(
          text: 'By clicking Register, you agree to our ',
          style: const TextStyle(color: Colors.grey),
          children: [
            TextSpan(
              text: 'terms and conditions',
              style: const TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Uri.parse('').launchUrl_();

                },
            ),
            const TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }

Widget _buildRegisterButton(BuildContext context) {
  final auth = Provider.of<AuthProvider>(context);
  return ElevatedButton(
    onPressed: () async {
      if (!_formKey.currentState!.validate()) {
        return; // لا تستمر إذا لم يكن الإيميل صالحًا
      }

      final email = _emailController.text.trim();
      await auth.sendOtp(email);
      navigateAndRemove(context, OtpPage(email: email));
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 0, 20, 238).withOpacity(0.9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
    ),
    child: Center(
      child: SizedBox(
        width: 100,
        height: 24,
        child: !auth.isLoading
            ? const Center(
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
            : const Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    // color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
              ),
      ),
    ),
  );
}


  Widget _buildSocialButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          label: 'Continue with Google',
          icon: Image.asset('assets/icon/google1.png', width: 20, height: 20, color: Theme.of(context).iconTheme.color,),
          onPressed: () {

          },
        ),
        const SizedBox(width: 10),
        _buildSocialButton(
          label: 'Continue with Apple',
          icon: Image.asset('assets/icon/apple.png', width: 20, height: 20,color: Theme.of(context).iconTheme.color,),
          onPressed: () {

          },
        ),
      ],
    );
  }

Widget _buildSocialButton({
  required String label,
  required Widget icon,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.7, color: Colors.grey.withOpacity(0.5)),
        ),
        height: 45,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: icon,
            ),
            Center(
              child: Text(
                label,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}
