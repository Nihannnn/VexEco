import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:second_try/main.dart';

class MainMenuScreen extends StatefulWidget {
  final VexEcoGame game;
  static const String id = 'mainMenu';
  final VoidCallback? onStartGamePressed;

  const MainMenuScreen({
    Key? key,
    required this.game,
    this.onStartGamePressed,
  }) : super(key: key);

  @override
  _MainMenuScreenState createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  @override
  Widget build(BuildContext context) {
    String mainMenuImage =
        'assets/images/main_screen_${widget.game.getDeviceType()}.png';

    final screenWidth = MediaQuery.of(context).size.width;
    print('screenWidth=$screenWidth');
    widget.game.pauseEngine();

    return Scaffold(
      body: Stack(
        children: [
          Semantics(
            label: 'Tap to start game',
            child: GestureDetector(
              onTap: () {
                widget.game.overlays.remove('mainMenu');
                widget.game.resumeEngine();
              },
              child: Semantics(
                label: 'Tap to start game',
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(mainMenuImage),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 330,
            left: (MediaQuery.of(context).size.width - 80) / 2,
            child: Semantics(
              label: 'Start Game',
              child: GestureDetector(
                onTap: () {
                  widget.game.overlays.remove('mainMenu');
                  widget.game.resumeEngine();
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFF677D4A),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 225,
            left: (MediaQuery.of(context).size.width - 265) / 2,
            child: Semantics(
              label: 'Start Game',
              child: ElevatedButton(
                onPressed: () {
                  widget.game.overlays.remove('mainMenu');
                  widget.game.guideType = "tip";
                  widget.game.overlays.add('guideScreen');
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF398AD0),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                ),
                child: Semantics(
                  label: 'Make a big impact button',
                  child: const Text(
                    'Make a big impact',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontFamily: 'Galindo'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 35,
            left: (MediaQuery.of(context).size.width - 50 - 170) / 2,
            child: Semantics(
              label: widget.game.isMusicPlaying ? 'Mute' : 'Unmute',
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.game.isMusicPlaying = !widget.game.isMusicPlaying;
                    if (widget.game.isMusicPlaying &&
                        !FlameAudio.bgm.isPlaying) {
                      FlameAudio.bgm.play('IntroTheme.mp3');
                    } else {
                      FlameAudio.bgm.pause();
                    }
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    widget.game.isMusicPlaying
                        ? Icons.volume_up
                        : Icons.volume_off,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 35,
            left: (MediaQuery.of(context).size.width + 150) / 2,
            child: Semantics(
              label: 'Game tutorials',
              child: GestureDetector(
                onTap: () {
                  widget.game.overlays.remove('mainMenu');
                  widget.game.guideType = "tutorial";
                  widget.game.overlays.add('guideScreen');
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.info_outline,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 130, // Adjusted bottom position for the text
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20), // Adjust padding as needed
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Semantics(
                    label:
                        "Embark on Vex's Eco-adventure! Clean up trash, evade enemies, and use superpowers to save Earth!",
                    child: Text(
                      "Embark on Vex's Eco-adventure! Clean up trash, evade enemies, and use superpowers to save Earth!",
                      textAlign: TextAlign.center, // Center text horizontally
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF445025),
                        fontFamily: 'Galindo',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
