import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter.dart';

class Counter with ChangeNotifier {
  int _count = 0; //private bi değişken oluşturduk

  int get count => _count; //dışarıdan erişilebilmesini sağladık

  void increment() {
    _count++;
    notifyListeners(); //dinleme fonksiyonu ekledik
  }
}
