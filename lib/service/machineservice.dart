import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_manager/model/costumer.dart';
import 'package:farm_manager/model/machine.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MachineService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<MachineArray>> fetchMachineData() {
    User? user = _auth.currentUser;

    if (user == null) {
      throw Exception("Usuário não está autenticado.");
    }

    return FirebaseFirestore.instance
        .collection('machine')
        .where('costumer', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs.first.data();
        var machineList = data['machines'] as List<dynamic>;
        return machineList
            .map((machine) =>
                MachineArray.fromMap(machine as Map<String, dynamic>))
            .toList();
      }
      return [];
    });
  }

  Stream<List<ToolArray>> fetchToolsData() {
    User? user = _auth.currentUser;

    if (user == null) {
      throw Exception("Usuário não está autenticado.");
    }

    return FirebaseFirestore.instance
        .collection('machine')
        .where('costumer', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        var data = snapshot.docs.first.data();
        var toolList = data['tools'] as List<dynamic>;
        return toolList
            .map((tool) => ToolArray.fromMap(tool as Map<String, dynamic>))
            .toList();
      }
      return [];
    });
  }

  Future<void> addNewTool(
      context, String componente, String intervalo, Costumer costumer) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('machine')
          .where('costumer', isEqualTo: costumer.id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> newTool = {
          "componente": componente,
          "intervalo": int.tryParse(intervalo) ?? 0, // Converte para inteiro
        };

        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          await doc.reference.update({
            "tools": FieldValue.arrayUnion([newTool])
          });
        }

        debugPrint("Ferramenta adicionada com sucesso!");
      } else {
        debugPrint("Nenhuma máquina encontrada para o cliente.");
      }
    } catch (e) {
      debugPrint("Erro ao fazer login: $e");
    }
  }
}
