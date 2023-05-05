import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/apis/shared_prefs.api.dart';
import 'package:untitled/models/radio_station.dart';
import 'package:untitled/providers/radio_provider.dart';
import 'package:untitled/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final radioStation = await SharedPrefsApi.getInitialRadioStation();
  await Firebase.initializeApp();

  runApp(MyApp(
    initialStation: radioStation,
  ));
}

class MyApp extends StatelessWidget {
  final RadioStation initialStation;
  const MyApp({required this.initialStation, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => RadioProvider(initialStation))
      ],
      child: MaterialApp(
        title: 'Radio App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(), 
      ),
    );
  }
}
