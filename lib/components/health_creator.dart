import 'dart:math';

import 'package:flame/components.dart';
import 'package:second_try/components/bottle.dart';
import 'package:second_try/components/enemy_component.dart';
import 'package:second_try/components/food.dart';
import 'package:second_try/components/health.dart';
import 'package:second_try/main.dart';

class HealthCreator extends TimerComponent with HasGameReference<VexEcoGame> {
  final Random random = Random();
  final _halfWidth = EnemyComponent.initialSize.x / 2;
  List<Bottle> bottles = [];
  HealthCreator() : super(period: 5, repeat: true);

  @override
  void onTick() {
    double randomNumber = random.nextInt(101).toDouble();
    game.addAll(
      List.generate(
        1,
        (index) => Health(
          position: Vector2(
            game.size.x,
            game.size.y - 80 - randomNumber,
          ),
        ),
      ),
    );
  }
}
