import 'dart:math';

import 'package:flame/components.dart';
import 'package:second_try/components/enemy_component.dart';
import 'package:second_try/main.dart';

class EnemyCreator extends TimerComponent with HasGameReference<VexEcoGame> {
  EnemyCreator() : super(period: 5, repeat: true);

  double generateRandomDouble(double min, double max) {
    Random random = Random();
    return min + random.nextDouble() * (max - min);
  }

  @override
  void onTick() {
    Random random = Random();
    int randomNumber = random.nextInt(2);
    int enemyType = randomNumber + 3;
    double randomDouble = generateRandomDouble(game.size.y * (1 / 7), game.size.y * (2 / 7));

    // type 3 is orange
    double enemyType3YOffset = generateRandomDouble(game.size.y * (1 / 7), game.size.y * (2.5 / 7));
    // type 2 is blue
    double enemyType2YOffset = generateRandomDouble(game.size.y * (1 / 7), game.size.y * (4 / 7));

    double enemyXOffset = generateRandomDouble(game.size.x * (1 / 7), game.size.y * (2 / 7));

    //double enemyType3YOffset = generateRandomDouble(game.size.y * (1.5 / 7), game.size.y * (3 / 7));
    //double enemyType2YOffset = generateRandomDouble(game.size.y * (1.5 / 7), game.size.y * (3 / 7));


    double groundWithPlayerSize = game.size.y;

    double posY = enemyType == 3
        ? groundWithPlayerSize - enemyType3YOffset
        : groundWithPlayerSize - enemyType2YOffset;

    double posX = game.size.x - enemyXOffset;
    int level = game.level + 1;

    game.addAll(
      List.generate(
        1,
        (index) => EnemyComponent(
          enemyType: enemyType.toString(),
          position: Vector2(
            game.size.x + 100,
            posY,
          ),
        ),
      ),
    );
  }
}
