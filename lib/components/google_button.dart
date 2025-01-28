import 'package:farm_manager/service/authservice.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleSignInButton extends StatelessWidget {
  final Function() onPressed;

  const GoogleSignInButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    AuthService authManager = AuthService();
    return ElevatedButton(
      onPressed: () async {
        final user = await authManager.signInWithGoogle();
        debugPrint("user: @$user");
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8C9EFF),
        minimumSize: const Size(230, 44),
        padding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FaIcon(
            FontAwesomeIcons.google,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            'Continue with Google',
            style: GoogleFonts.inter(
              color: const Color(0xFF1A237E),
              fontWeight: FontWeight.bold,
              letterSpacing: 0.0,
            ),
          ),
        ],
      ),
    );
  }
}
