import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_manager/model/machine.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}
