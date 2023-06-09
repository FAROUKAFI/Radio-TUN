import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radio_player/radio_player.dart';
import 'package:untitled/models/radio_station.dart';
import 'package:untitled/providers/radio_provider.dart';

class RadioApi {
  static late RadioPlayer player;

  static Future<void> initPlayer(BuildContext context) async {
    final provider = Provider.of<RadioProvider>(context, listen: false);

    player = RadioPlayer();
    await player.stop();
    await player.setChannel(
        title: provider.station.name, url: provider.station.streamUrl);
    await player.play();
  }

  static Future<void> changeStation(RadioStation station) async {
    player = RadioPlayer();
    await player.stop();
    await player.setChannel(title: station.name, url: station.streamUrl);
    await player.play();
  }
}
