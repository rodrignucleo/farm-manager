import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_manager/model/costumer.dart';
import 'package:farm_manager/provider/costumer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        debugPrint("Usuário cancelou o login com o Google.");
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? user = userCredential.user;
      debugPrint(">> Usuário logado: ${user?.email}");
      return user;
    } catch (e) {
      debugPrint("Erro durante o login com o Google: $e");
      return null;
    }
  }

  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return user;
    } catch (e) {
      debugPrint("Erro ao registrar: $e");
      return null;
    }
  }

  Future<Object?> signInWithEmailAndPassword(
      context, String email, String password) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      if (user != null) {
        QuerySnapshot querySnapshot = await firestore
            .collection('costumer')
            .where('email', isEqualTo: user.email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot doc = querySnapshot.docs.first;
          Map<String, dynamic> data =
              querySnapshot.docs.first.data() as Map<String, dynamic>;
          if (data['id'] == null) {
            await doc.reference.update({'id': user.uid});
          }
          Costumer costumer = Costumer.fromMap(data);
          Provider.of<CostumerProvider>(context, listen: false)
              .setCostumer(costumer);
        } else {
          debugPrint('Nenhum costumer encontrado com o email ${user.email}');
        }
      }
      return user;
    } catch (e) {
      debugPrint("Erro ao fazer login: $e");
      return e;
    }
  }

  Future<void> signOut(context) async {
    try {
      await _auth.signOut();
      Provider.of<CostumerProvider>(context, listen: false).clearCostumer();
      debugPrint('Usuário desconectado e estado do costumer limpo.');
    } catch (e) {
      debugPrint("Erro ao fazer logout: $e");
    }
  }

  User? getCurrentUser() {
    try {
      return _auth.currentUser;
    } catch (e) {
      debugPrint("Erro ao obter o usuário atual: $e");
      return null;
    }
  }
}
