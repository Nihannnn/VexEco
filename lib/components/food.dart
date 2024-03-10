import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'package:second_try/config/game_config.dart';
import 'package:second_try/main.dart';

class Food extends SpriteComponent with HasGameReference<VexEcoGame>, CollisionCallbacks {
  double speed = GameConfig.gameSpeed;
  static final Vector2 initialSize = Vector2.all(50);
  final Random random = Random();

  bool collected = false;


  Food({required super.position})
      : super(size: initialSize);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    speed = GameConfig.gameSpeed + game.level * 50;

    sprite = await game.loadSprite('food.png');

    // sise location
    double posY = game.size.y - (game.size.y / 4) - (random.nextInt(200));


    position = Vector2(game.size.x, posY );
    add(CircleHitbox(collisionType: CollisionType.passive));

  }


  @override
  void update(double dt) {
    super.update(dt);
    x -= speed * dt;

    if (x < -1 * game.size.x) {
      removeFromParent();
    }
  }


  void takeHit() {
    removeFromParent();
  }


}