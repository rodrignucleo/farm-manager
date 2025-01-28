import 'package:farm_manager/model/costumer.dart';
import 'package:flutter/material.dart';

class CostumerProvider with ChangeNotifier {
  Costumer? _costumer;

  Costumer? get costumer => _costumer;

  void setCostumer(Costumer costumer) {
    _costumer = costumer;
    notifyListeners();
  }

  void clearCostumer() {
    _costumer = null;
    notifyListeners();
  }
}
