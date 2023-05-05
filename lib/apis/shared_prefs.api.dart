import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/models/radio_station.dart';
import 'package:untitled/utils/radio_station.dart';
// fournit deux méthodes statiques pour accéder et modifier les préférences partagées de l'application. 
//Les préférences partagées sont des paires clé-valeur stockées sur l'appareil de l'utilisateur pour persister des données simples
// à travers les sessions d'utilisation de l'application.
class SharedPrefsApi {
  static const _key = 'radio_station';
  static Future<RadioStation> getInitialRadioStation() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final stationName = sharedPrefs.getString(_key);
    if (stationName == null) return RadioStations.allStations[0];
    return RadioStations.allStations
        .firstWhere((element) => element.name == stationName);
  }

  static Future<void> setStation(RadioStation station) async {
    final sharedPrefs = await SharedPreferences.getInstance();

    sharedPrefs.setString(_key, station.name);
  }
}

//16:25
