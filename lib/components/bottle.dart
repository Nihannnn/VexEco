import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'package:second_try/config/game_config.dart';
import 'package:second_try/main.dart';

class Bottle extends SpriteComponent with HasGameReference<VexEcoGame>, CollisionCallbacks {
  late double speed = GameConfig.gameSpeed;
  static final Vector2 initialSize = Vector2.all(50);
  final Random random = Random();

  bool collected = false;

  Bottle({required Vector2 position})
      : super(size: initialSize, position: position);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    speed = GameConfig.gameSpeed + game.level * 100;
    sprite = await game.loadSprite('plastic.png');

    // sise location
    double posY = game.size.y - (game.size.y / 4) - (random.nextInt(200));

    position = Vector2(game.size.x, posY);
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