import 'dart:ui';

import 'package:farm_manager/components/botao_animado.dart';
import 'package:farm_manager/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animacaoBlur;
  Animation<double>? _animacaoFade;
  Animation<double>? _animacaoSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animacaoBlur = Tween<double>(
      begin: 50,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.ease,
      ),
    );

    _animacaoFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOutQuint,
      ),
    );

    _animacaoSize = Tween<double>(
      begin: 0,
      end: 500,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.decelerate,
      ),
    );

    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  String emailValue = '';
  String passwordValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: TAppTheme.appTheme.scaffoldBackgroundColor,
      body: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Container(
          // width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              TAppTheme.appTheme.canvasColor,
              TAppTheme.appTheme.scaffoldBackgroundColor,
              TAppTheme.appTheme.primaryColor,
            ],
            stops: [0, 0.5, 1],
            begin: AlignmentDirectional(-1, -1),
            end: AlignmentDirectional(1, 1),
          )),
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _animacaoBlur!,
                builder: (context, widget) {
                  return SizedBox(
                    height: isKeyboardVisible ? 200 : 400,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: _animacaoBlur!.value,
                        sigmaY: _animacaoBlur!.value,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: TAppTheme.appTheme.primaryColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.animation,
                                color: TAppTheme.appTheme.primaryColorLight,
                                size: 44,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Entrar',
                            style: GoogleFonts.inter(
                              color: TAppTheme.appTheme.primaryColorLight,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.0,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Faça o login abaixo.',
                            style: GoogleFonts.inter(
                              color: TAppTheme.appTheme.primaryColorLight,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    children: [
                      AnimatedBuilder(
                        animation: _animacaoSize!,
                        builder: (context, widget) {
                          return Container(
                            width: _animacaoSize?.value,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: TAppTheme.appTheme.primaryColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: TAppTheme.appTheme.primaryColor,
                                  blurRadius: 80,
                                  spreadRadius: 1,
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                TextFormField(
                                  autofillHints: const [AutofillHints.email],
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.person,
                                        color: TAppTheme
                                            .appTheme.primaryColorLight),
                                    labelText: 'Email',
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (value) {
                                    setState(() {
                                      emailValue = value;
                                    });
                                  },
                                ),
                                TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.lock,
                                        color: TAppTheme
                                            .appTheme.primaryColorLight),
                                    labelText: 'Senha',
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      passwordValue = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      LoginButton(
                        controller: _controller!,
                        emailAddress: emailValue,
                        password: passwordValue,
                      ),
                      // const SizedBox(height: 10),
                      // GoogleSignInButton(
                      //   onPressed: () {},
                      // ),
                      const SizedBox(height: 10),
                      FadeTransition(
                        opacity: _animacaoFade!,
                        child: Text(
                          "Esqueci minha senha",
                          style: TextStyle(
                            color: TAppTheme.appTheme.primaryColorLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
