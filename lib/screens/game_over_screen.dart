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
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 150),
                  padding: const EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      border: Border.all(color: Colors.blueAccent),
                      boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))],
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: const Text(
                      'GAME OVER!',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontFamily: 'Galindo'),
                )),
                Semantics(
                  label: 'Gold Image',
                  child: Image.asset('assets/images/coinGold.png',
                      width: 200, height: 200),
                ),
                Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        border: Border.all(color: Colors.blueAccent),
                        boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))],
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Text(
                      '${game.score * 1000}',
                      style: const TextStyle(
                          fontSize: 30,
                          color: Colors.black87,
                          fontFamily: 'Galindo'),
                    )),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.only(top: 30, bottom: 30),
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      boxShadow: [BoxShadow(blurRadius: 10,color: Colors.black,offset: Offset(1,3))],
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Semantics(
                    label:
                    "Every step counts towards cleaning Earth from pollution. Keep pushing forward!",
                    child: const Text(
                      "Every step counts towards cleaning Earth from pollution. Keep pushing forward!",
                      textAlign:
                      TextAlign.center, // Center text horizontally
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontFamily: 'Galindo',
                      ),
                    ),
                  ),
                ),
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
                        padding: const EdgeInsets.symmetric(
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
                    const SizedBox(width: 20), // Add space between the buttons
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
          )),
    );
  }

  void onRestart() {
    game.player.reset();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}
