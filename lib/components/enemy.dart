import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:second_try/main.dart';


class Enemy extends SpriteAnimationComponent
    with HasGameReference<VexEcoGame> {

  bool _isHit = false;
  Enemy({
    super.position,
  }) : super(
    size: Vector2.all(enemySize),
    anchor: Anchor.center,
  );


  static const enemySize = 100.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    animation = await game.loadSpriteAnimation(
      'enemy_real.png',
      SpriteAnimationData.sequenced(
        amount: 11,
        stepTime: .2,
        textureSize: Vector2.all(100),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x += dt * 25;

    if (position.x > game.size.x) {
      removeFromParent();
    }
  }



}