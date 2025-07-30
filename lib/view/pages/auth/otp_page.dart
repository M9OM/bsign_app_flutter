import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:bsign/core/config/app_color.dart';
import 'package:bsign/extensions/navigator_extensions.dart';
import 'package:bsign/providers/auth_provider.dart';
import 'package:bsign/view/pages/home/home_page.dart';
import 'package:hugeicons/hugeicons.dart';

class OtpPage extends StatefulWidget {
  final String email;
  const OtpPage({super.key, required this.email});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  Timer? _timer;
  int _timerSeconds = 30;
  String _enteredOtp = '';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timerSeconds = 30;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds == 0) {
        timer.cancel();
      } else {
        if (mounted) {
          setState(() => _timerSeconds--);
        } else {
          timer.cancel(); // نحمي من استدعاء setState بعد dispose
        }
      }
    });
  }

  Future<void> _submitOtp() async {
    if (_enteredOtp.length != 6) {
      _showSnackBar('Please enter the 6-digit code');
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final error = await authProvider.verifyOtp(widget.email, _enteredOtp);

    if (!mounted) return;

    if (error != null) {
      _showSnackBar(error);
    } else {
      _showSnackBar('Verification successful');
      navigateAndRemove(context, HomeScreen());
    }
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      HugeIcons.strokeRoundedLockPassword,
                      color: AppColors.primary,
                      size: 80,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Enter Code',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'We sent OTP code to your email address',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  /// OTP Text Field
                  OtpTextField(
                    numberOfFields: 6,
                    borderColor: AppColors.primary,
                    focusedBorderColor: AppColors.primary,
                    cursorColor: AppColors.primary,
                    showFieldAsBox: false,
                    borderRadius: BorderRadius.circular(8),
                    onCodeChanged: (code) {
                      setState(() {
                        _enteredOtp = code;
                      });
                    },
                    onSubmit: (code) {
                      setState(() {
                        _enteredOtp = code;
                      });
                    },
                  ),

                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed:
                        (_enteredOtp.length != 6 || authProvider.isLoading)
                            ? null
                            : () => _submitOtp(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                        255,
                        0,
                        20,
                        238,
                      ).withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: SizedBox(
                      width: 100,
                      height: 24,
                      child: authProvider.isLoading
                          ? const Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                            )
                          : const Center(
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      if (_timerSeconds == 0) {
                        authProvider.sendOtp(widget.email);
                        _startTimer();
                      }
                    },
                    child: Text(
                      _timerSeconds > 0
                          ? 'Re-send code in 0:${_timerSeconds.toString().padLeft(2, '0')}'
                          : 'Didn’t receive code? Resend',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
