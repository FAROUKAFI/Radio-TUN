import 'package:untitled/models/radio_station.dart';

class RadioStations {
  static List<RadioStation> allStations = [
    RadioStation(
        name: 'Express FM',
        streamUrl: 'http://expressfm.ice.infomaniak.ch/expressfm-64.mp3',
        photoUrl:
            'https://www.allzicradio.com/media/radios/express-fm.jpg'),
    RadioStation(
        name: 'Mosaique FM',
        streamUrl: 'http://radio.mosaiquefm.net:8000/mosalive',
        photoUrl:
            'https://is2-ssl.mzstatic.com/image/thumb/Purple116/v4/47/10/4a/47104a7d-cf92-0d5a-bd56-759af48bd6dd/AppIcon-1x_U007emarketing-0-10-0-0-85-220.png/1200x600wa.png'),
    RadioStation(
      name: 'Zitouna FM',
      streamUrl: 'https://stream.radiozitouna.tn/radio/8030/radio.mp3',
      photoUrl: /*'images/Express_FM_logo.png',*/
          'https://play-lh.googleusercontent.com/FUplTb-7ZzM_CiVCb0RB-jshbfIoOXTqfw8Xx2Vyh0wSwRnOGngdzltupCSl6kmeE90=w240-h480-rw',
    ),
     RadioStation(
        name: 'IFM',
        streamUrl: 'https://live.ifm.tn/radio/8000/ifmlive?1585304718',
        photoUrl:
            'https://upload.wikimedia.org/wikipedia/fr/6/69/Logo_n%C3%A9gatif_avec_contour.png'),
  ];

  
}
