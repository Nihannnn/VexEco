import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'package:second_try/config/game_config.dart';
import 'package:second_try/main.dart';

class Health extends SpriteAnimationComponent with HasGameReference<VexEcoGame>, CollisionCallbacks {
  double speed = GameConfig.gameSpeed;
  static final Vector2 initialSize = Vector2.all(100);
  final Random random = Random();

  bool collected = false;


  Health({required super.position})
      : super(size: initialSize);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    speed = GameConfig.gameSpeed + game.level * 50;
    animation = await game.loadSpriteAnimation(
      'health_bag.png',
      SpriteAnimationData.sequenced(
        stepTime: 0.2,
        amount:  2,
        textureSize:Vector2(61, 61),
      ),
    );
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
      print('Removed');
    }
  }


  void takeHit() {
    removeFromParent();
  }


}