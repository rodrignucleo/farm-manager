import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_manager/model/costumer.dart';
import 'package:farm_manager/provider/costumer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  Future<User?> signInWithEmailAndPassword(
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
          Map<String, dynamic> data =
              querySnapshot.docs.first.data() as Map<String, dynamic>;
          Costumer costumer = Costumer.fromMap(data);
          Provider.of<CostumerProvider>(context, listen: false)
              .setCostumer(costumer);
          debugPrint('Costumer encontrado: $costumer');
        } else {
          debugPrint('Nenhum costumer encontrado com o email ${user.email}');
        }
      }
      return user;
    } catch (e) {
      debugPrint("Erro ao fazer login: $e");
      return null;
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
