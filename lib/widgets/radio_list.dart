import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/apis/radio_api.dart';
import 'package:untitled/apis/shared_prefs.api.dart';
import 'package:untitled/models/radio_station.dart';
import 'package:untitled/providers/radio_provider.dart';
import 'package:untitled/utils/radio_station.dart';

class RadioList extends StatefulWidget {
  const RadioList({super.key});

  @override
  State<RadioList> createState() => _RadioListState();
}

class _RadioListState extends State<RadioList> {
  late RadioStation selectedStation;
  late RadioProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<RadioProvider>(context, listen: false);
    selectedStation = provider.station;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RadioProvider>(context, listen: false);

    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        itemCount: RadioStations.allStations.length,
        itemBuilder: (context, index) {
          final station = RadioStations.allStations[index];
          bool isSelected = station.name == provider.station.name;
          return Container(
            decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(colors: [
                        Color.fromARGB(255, 172, 172, 172),
                        Color.fromARGB(255, 153, 153, 153),
                      ])
                    : null),
            child: ListTile(
              leading: Image.network(
                station.photoUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              horizontalTitleGap: 90,
              title: Text(
                station.name,
                style: TextStyle(
                  color: isSelected ? Colors.black : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  
                ),
              ),
              onTap: () async {
                provider.setRadioStation(station);
                SharedPrefsApi.setStation(station);
                await RadioApi.changeStation(station);
                setState(() {
                  selectedStation = station;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
