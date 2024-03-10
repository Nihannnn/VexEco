import 'dart:ui';

import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:second_try/config/game_config.dart';
import 'package:second_try/main.dart';


class EnemyComponent extends SpriteAnimationComponent
    with HasGameReference<VexEcoGame>, CollisionCallbacks {
  static const speed = GameConfig.gameSpeed;
  static final Vector2 initialSize = Vector2.all(100);
  bool isHit = false;

  final String enemyType;
  EnemyComponent({required this.enemyType, required Vector2 position})
      : super(size: initialSize, anchor: Anchor.centerRight, position: position);


  @override
  Future<void> onLoad() async {
    animation = await game.loadSpriteAnimation(
      'enemy$enemyType.png',
      SpriteAnimationData.sequenced(
        stepTime: 0.2,
        amount: 11,
        textureSize: Vector2(681, 982),
      ),
    );
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
}