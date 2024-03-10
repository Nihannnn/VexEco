import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:second_try/main.dart';
import 'package:flutter/services.dart';

class GameOverScreen extends StatelessWidget {
  final VexEcoGame game;

  const GameOverScreen({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Game over screen",
      child: Material(
        color: Colors.black38,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/gameover.png',
              fit: BoxFit.scaleDown,
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 0),
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Semantics(
                          label: 'Gold Image',
                          child: Image.asset('assets/images/money.png',
                              width: 200, height: 200),
                        ),
                        Positioned(
                          bottom: 25, // Adjust position as needed
                          right: 5,
                          child: Semantics(
                            label: 'You got: ${game.score * 1000} gold',
                            child: Text(
                              '${game.score * 1000}',
                              style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Galindo'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 130, // Adjusted bottom position for the text
                    left: 10,
                    right: 10,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 35), // Adjust padding as needed
                      child: Center(
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 2,
                          ),
                          child: Semantics(
                            label:
                                "Every step counts towards cleaning Earth from pollution. Keep pushing forward!",
                            child: Text(
                              "Every step counts towards cleaning Earth from pollution. Keep pushing forward!",
                              textAlign:
                                  TextAlign.center, // Center text horizontally
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
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          game.overlays.add('mainMenu');
                          game.overlays.remove('gameOver');
                          game.player.reset();
                          // SystemNavigator.pop(); // Quit the app
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF398AD0),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40),
                        ),
                        child: Semantics(
                          label: 'Return to Main Menu Button',
                          child: const Text(
                            '  Menu ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'Galindo'),
                          ),
                        ),
                      ),
                      SizedBox(width: 20), // Add space between the buttons
                      ElevatedButton(
                        onPressed: onRestart,
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFF677D4A),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 40),
                        ),
                        child: Semantics(
                          label: 'Restart Button',
                          child: const Text(
                            'Retry',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'Galindo'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onRestart() {
    game.player.reset();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}
