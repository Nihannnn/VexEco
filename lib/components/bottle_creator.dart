import 'dart:math';

import 'package:flame/components.dart';
import 'package:second_try/components/bottle.dart';
import 'package:second_try/components/enemy_component.dart';
import 'package:second_try/main.dart';

class BottleCreator extends TimerComponent
    with HasGameReference<VexEcoGame> {
  final Random random = Random();
  final _halfWidth = EnemyComponent.initialSize.x / 2;

  List<Bottle> bottles = [];
  BottleCreator() : super(period: 3, repeat: true);

  Bottle generateBottle(int index) {
    double randomNumber = random.nextInt(50+index).toDouble() + (index * 100.0);

    return Bottle(
        position: Vector2(
      game.size.x,
      game.size.y - 60 - randomNumber,
    ));
  }

  @override
  void onTick() {
    game.addAll(
      List.generate(
        game.level + 1,
        (index) => generateBottle(index)..priority=2,
      ),
    );
  }
}
