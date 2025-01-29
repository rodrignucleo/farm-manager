import 'package:farm_manager/pages/homepage/homepage.dart';
import 'package:farm_manager/utils/theme/theme.dart';
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
  String errorText = "";

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
          errorText = "";
        });
        setState(() {
          isLoading = true;
        });
        try {
          AuthService authService = AuthService();
          var response = await authService.signInWithEmailAndPassword(
              context, this.widget.emailAddress, this.widget.password);
          if (response!.toString().contains('invalid-credential')) {
            setState(() {
              errorText = "Senha incorreta";
            });
          } else if (response.toString().contains('invalid-email')) {
            setState(() {
              errorText = "Email inválido";
            });
          } else if (response.toString().contains('channel-error')) {
            setState(() {
              errorText = "Digite o email ou senha para continuar!";
            });
          } else if (response.toString().contains('missing-password')) {
            setState(() {
              errorText = "Digite a senha para continuar!";
            });
          }
          if (errorText == "") {
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const HomePage(),
                ),
              );
            }
          }
        } catch (e) {
          debugPrint('Error in button login: $e');
        } finally {
          setState(() {
            isLoading = false;
          });
        }
      },
      child: Column(
        children: [
          if (errorText != "") Text(errorText),
          Container(
            width: largura.value,
            height: altura.value,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius.value),
              gradient: LinearGradient(
                colors: [
                  TAppTheme.appTheme.primaryColor,
                  TAppTheme.appTheme.primaryColor,
                ],
              ),
            ),
            child: Center(
              child: FadeTransition(
                opacity: opacidade,
                child: isLoading
                    ? SpinKitCircle(
                        color: TAppTheme.appTheme.canvasColor,
                        size: 50.0,
                      )
                    : Text(
                        isLoading ? "Loading" : "Entrar",
                        style: TextStyle(
                          color: TAppTheme.appTheme.canvasColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
        ],
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
