import 'package:flutter/material.dart';
import 'package:untitled/models/radio_station.dart';
// fournir un moyen de stocker et de récupérer les informations sur la station de 
//radio actuellement sélectionnée par l'utilisateur.
class RadioProvider with ChangeNotifier {
  final RadioStation initialRadioStation;

  RadioProvider(this.initialRadioStation);

  RadioStation? _station;
  RadioStation get station => _station ?? initialRadioStation;
  void setRadioStation(RadioStation station) {
    _station = station;
    notifyListeners();
  }
}
