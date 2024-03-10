import 'dart:math';

import 'package:flame/components.dart';
import 'package:second_try/components/bottle.dart';
import 'package:second_try/components/enemy_component.dart';
import 'package:second_try/components/food.dart';
import 'package:second_try/main.dart';

class FoodCreator extends TimerComponent with HasGameReference<VexEcoGame> {
  final Random random = Random();
  final _halfWidth = EnemyComponent.initialSize.x / 2;
  List<Bottle> bottles = [];
  FoodCreator() : super(period: 5, repeat: true);

  @override
  void onTick() {
    double randomNumber = random.nextInt(101).toDouble();
    game.addAll(
      List.generate(
        game.level + 1,
        (index) => Food(
          position: Vector2(
            game.size.x,
            game.size.y - 80 - randomNumber,
          ),
        ),
      ),
    );
  }
}
