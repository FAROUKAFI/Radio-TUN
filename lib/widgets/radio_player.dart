import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/apis/radio_api.dart';
import 'package:untitled/providers/radio_provider.dart';
import 'package:untitled/widgets/radio_list.dart';
import 'package:volume_controller/volume_controller.dart';

class RadioPlayer extends StatefulWidget {
  const RadioPlayer({Key? key}) : super(key: key);

  @override
  State<RadioPlayer> createState() => _RadioPlayerState();
}

class _RadioPlayerState extends State<RadioPlayer>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late VolumeController volumeController;
  late Animation<Offset> radioOffset;
  late Animation<Offset> radioListOffset;

  bool listEnabled = false;
  bool isPlaying = true;
  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    radioListOffset = Tween(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );
    radioOffset = Tween(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    RadioApi.player.stateStream.listen((event) {
      setState(() {
        isPlaying = event;
      });
    });
    volumeController = VolumeController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SlideTransition(
            position: radioOffset,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 290,
                  width: 290,
                  color: Colors.transparent,
                  child: Consumer<RadioProvider>(
                      builder: ((context, value, child) {
                    return Image.network(
                      value.station.photoUrl,
                      fit: BoxFit.cover,
                    );
                  })),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          listEnabled = !listEnabled;
                        });
                        switch (animationController.status) {
                          case AnimationStatus.dismissed:
                            animationController.forward();
                            break;
                          case AnimationStatus.completed:
                            animationController.reverse();
                            break;
                          default:
                            break; // add a default case
                        }
                      },
                      color: listEnabled ? Color.fromARGB(255, 37, 34, 180) : Colors.black,
                      iconSize: 50,
                      icon: const Icon(
                        Icons.list,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        isPlaying
                            ? RadioApi.player.stop()
                            : RadioApi.player.play();
                      },
                      color: Colors.black,
                      iconSize: 50,
                      icon: Icon(
                        isPlaying ? Icons.stop : Icons.play_arrow,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (isMuted) {
                          volumeController.setVolume(0.5);
                        } else {
                          volumeController.muteVolume();
                        }
                        setState(() {
                          isMuted = !isMuted;
                        });
                      },
                      color: Colors.black,
                      iconSize: 60,
                      icon: Icon(
                        isMuted ? Icons.volume_off : Icons.volume_up,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SlideTransition(
          position: radioListOffset, // <-- move closing bracket here
          child: Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                  50,
                ),
              ),
            ),
            child: const Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'R A D I O ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(
                  color: Color.fromARGB(255, 0, 43, 151),
                  indent: 30,
                  endIndent: 30,
                ),
                Expanded(
                  child: RadioList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
