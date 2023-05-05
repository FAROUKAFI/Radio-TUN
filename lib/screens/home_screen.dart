import 'dart:math';
import 'package:flutter/material.dart';
import 'package:untitled/apis/radio_api.dart';
import 'package:untitled/widgets/gradient_background.dart';
import 'package:untitled/widgets/radio_player.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart'; //une interface pour accéder à la base de données Cloud Firestore de Firebase.

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState(); 

  // HomeScreen peut contenir un état mutable et peut être reconstruit lorsque l'état change.
}

class _HomeScreenState extends State<HomeScreen> {
  //instantiation FirebaseStore et FirebaseMessaging
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  late StreamSubscription iosSubscription;
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  @override
  void initState() {
    super.initState();
//Save token
    _saveDeviceToken();
    _subscribeToTopic();
  }

  @override
  void dispose() {
    if (iosSubscription != null) iosSubscription.cancel();
    super.dispose();
    //Elle annule l'abonnement aux notifications push s'il existe.
  }

  @override
  Widget build(BuildContext context) {
    //final radioApi = RadioApi();
    return Scaffold(
      body: GradientBackground(
        child: FutureBuilder(
            future: RadioApi.initPlayer(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                );
              }
              return const RadioPlayer();
            }),
      ),
    );
  }
//Ce widget contient également un FutureBuilder qui récupère et lit la station de radio à l'aide de la méthode 
//RadioApi.initPlayer(context) et renvoie le widget RadioPlayer qui contient les commandes de lecture de la station de radio.
// Si le Future n'a pas encore renvoyé de valeur, la méthode build() renvoie un widget 
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  /// Get the token, save it to the database for current user
  _saveDeviceToken() async {
    // Get the current user
    String uid = getRandomString(10);
    // FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    String? fcmToken = await _fcm.getToken();
    print(fcmToken);
    // Save it to Firestore
    if (fcmToken != null) {
      var tokens =
          _db.collection('users').doc(uid).collection('tokens').doc(fcmToken);

      await tokens.set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(), // optional
        'platform': Platform.operatingSystem // optional
      });
    }
  }

  /// Subscribe the user to a topic
  _subscribeToTopic() async {
    // Subscribe the user to a topic
    _fcm.subscribeToTopic('notifs');
  }
}
