import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/botao_animado.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
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
      backgroundColor: const Color.fromRGBO(20, 24, 27, 1),
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color(0xFF1A237E),
              Color.fromRGBO(20, 24, 27, 1),
              Color(0xFF8C9EFF),
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
                    height: 400,
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
                              color: const Color(0xFF8C9EFF),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.animation,
                                color: Color(0xFF1A237E),
                                size: 44,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Entrar',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF8C9EFF),
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.0,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Faça o login abaixo.',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF8C9EFF),
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
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 40, right: 40, top: 20),
                      child: Column(
                        children: [
                          AnimatedBuilder(
                            animation: _animacaoSize!,
                            builder: (context, widget) {
                              return Container(
                                width: _animacaoSize?.value,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF8C9EFF),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0xFF8C9EFF),
                                      blurRadius: 80,
                                      spreadRadius: 1,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      autofillHints: const [
                                        AutofillHints.email
                                      ],
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.person),
                                        labelText: 'Email',
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) {
                                        setState(() {
                                          emailValue = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Por favor, insira seu email';
                                        }
                                        return null;
                                      },
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      autofillHints: const [
                                        AutofillHints.password
                                      ],
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.lock),
                                        labelText: 'Senha',
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          passwordValue = value;
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Por favor, insira sua senha';
                                        }
                                        return null;
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
                          const SizedBox(height: 10),
                          // GoogleSignInButton(
                          //   onPressed: () {},
                          // ),
                          // const SizedBox(height: 10),
                          FadeTransition(
                            opacity: _animacaoFade!,
                            child: const Text(
                              "Esqueci minha senha",
                              style: TextStyle(
                                color: Color(0xFF8C9EFF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
