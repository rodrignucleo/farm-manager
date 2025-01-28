import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../service/authservice.dart';

class LoginButton extends StatefulWidget {
  final AnimationController controller;
  final String emailAddress;
  final String password;

  const LoginButton({
    super.key,
    required this.controller,
    required this.emailAddress,
    required this.password,
  });

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  late Animation<double> largura;
  late Animation<double> altura;
  late Animation<double> radius;
  late Animation<double> opacidade;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    largura = Tween<double>(
      begin: 0,
      end: 500,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.0, 0.5),
      ),
    );

    altura = Tween<double>(
      begin: 0,
      end: 50,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.5, 0.7),
      ),
    );

    radius = Tween<double>(
      begin: 0,
      end: 20,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.6, 1.0),
      ),
    );

    opacidade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: const Interval(0.6, 0.8),
      ),
    );
  }

  Widget _buildAnimation(BuildContext context, Widget? widget) {
    return InkWell(
      onTap: () async {
        setState(() {
          isLoading = true;
        });

        try {
          AuthService authService = AuthService();
          await authService.signInWithEmailAndPassword(
              context, this.widget.emailAddress, this.widget.password);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            debugPrint('No user found for that email.');
          } else if (e.code == 'wrong-password') {
            debugPrint('Wrong password provided for that user.');
          }
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Container(
        width: largura.value,
        height: altura.value,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius.value),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF8C9EFF),
              Color(0xFF8C9EFF),
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: opacidade,
            child: isLoading
                ? const SpinKitCircle(
                    color: Color(0xFF1A237E),
                    size: 50.0,
                  )
                : Text(
                    isLoading ? "Loading" : "Entrar",
                    style: const TextStyle(
                      color: Color(0xFF1A237E),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: _buildAnimation,
    );
  }
}
