import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:second_try/components/bottle.dart';
import 'package:second_try/components/bottle_creator.dart';
import 'package:second_try/components/enemy_component.dart';
import 'package:second_try/components/food.dart';
import 'package:second_try/components/health.dart';
import 'package:second_try/main.dart';

class Player extends SpriteAnimationComponent
    with HasGameReference<VexEcoGame>, CollisionCallbacks {
  static const playerSizeX = 100.0, playerSizeY = 100.0;
  Player()
      : super(
          size: Vector2(playerSizeX, playerSizeY),
          position: Vector2(100, 400),
        );

  static const playerSize = 150.0;
  static bool isSoundMuted = false;
  bool playSounds = false;
  bool isHitNow = false;
  double soundVolume = 1.0;
  static const jumpEffect = 'jump_effect.mp3';

  static const double gravity = 800.0;
  double groundY = 550.0; // Adjust ground level
  double maxHeight = 200; // Adjust maximum height

  final double initialJumpVelocity = -15.0;
  final double introDuration = 1500.0;
  final double startXPosition = 50;
  final double startYPosition = 300;
  final double jumpForce = -700.0;

  late SpriteAnimation walkAnimation;
  late SpriteAnimation jumpAnimation;
  late SpriteAnimation walkdipAnimation;
  late SpriteAnimation walksupAnimation;
  late SpriteAnimation jumpsupAnimation;
  late SpriteAnimation diedvexAnimation;
  late SpriteAnimation dieddipAnimation;
  late SpriteAnimation diedsupAnimation;

  double _jumpVelocity = 0.0;
  double velocity = 0;

  double get groundYPos {
    return (game.size.y / 2);
  }

  @override
  Future<void> onLoad() async {
    add(CircleHitbox());
    await super.onLoad();
    double groundWithPlayerSize = game.size.y - playerSizeY;
    double playerYOffset = game.size.y * (1 / 7);
    maxHeight = game.size.y * (2 / 7);
    groundY = game.getDeviceType() == 'web'
        ? groundWithPlayerSize - playerYOffset
        : groundWithPlayerSize - playerYOffset;
   // debugMode = true;
    walkAnimation = await game.loadSpriteAnimation(
      'walk_vex.png',
      SpriteAnimationData.sequenced(
        stepTime: .2,
        amount: 6,
        textureSize: Vector2(130, 203),
        //texturePosition: Vector2(400, 600)
      ),
    );

    jumpAnimation = await game.loadSpriteAnimation(
      'jump_vex.png',
      SpriteAnimationData.sequenced(
        stepTime: .3,
        amount: 6,
        textureSize: Vector2(130, 203),
        //texturePosition: Vector2(400, 600)
      ),
    );
    //position = Vector2(game.size.x - 200, 100);
    //anchor = Anchor.topRight;
    animation = walkAnimation;

    walkdipAnimation = await game.loadSpriteAnimation(
      'swim.png',
      SpriteAnimationData.sequenced(
        stepTime: .3,
        amount: 6,
        textureSize: Vector2(240, 255),
        //texturePosition: Vector2(400, 600)
      ),
    );
    //position = Vector2(game.size.x - 200, 100);
    //anchor = Anchor.topRight;
  //  animation = walkAnimation;

    walksupAnimation = await game.loadSpriteAnimation(
      'walk_sup_vex.png',
      SpriteAnimationData.sequenced(
        stepTime: .3,
        amount: 6,
        textureSize: Vector2(157, 209 ),
        //texturePosition: Vector2(400, 600)
      ),
    );
    //position = Vector2(game.size.x - 200, 100);
    //anchor = Anchor.topRight;
    animation = walkAnimation;

    jumpsupAnimation = await game.loadSpriteAnimation(
      'jump_sup_vex.png',
      SpriteAnimationData.sequenced(
        stepTime: .3,
        amount: 6,
        textureSize: Vector2(157, 209 ),
        //texturePosition: Vector2(400, 600)
      ),
    );
    //position = Vector2(game.size.x - 200, 100);
    //anchor = Anchor.topRight;
    animation = walkAnimation;

    diedvexAnimation = await game.loadSpriteAnimation(
      'died_walk_vex.png',
      SpriteAnimationData.sequenced(
        stepTime: 0.1,
        amount: 2,
        textureSize: Vector2(130, 203),
        //texturePosition: Vector2(400, 600)
      ),
    );
    //position = Vector2(game.size.x - 200, 100);
    //anchor = Anchor.topRight;
    animation = walkAnimation;

    dieddipAnimation = await game.loadSpriteAnimation(
      'died_dip_vex.png',
      SpriteAnimationData.sequenced(
        stepTime: 0.1,
        amount: 3,
        textureSize: Vector2(240, 255),
        //texturePosition: Vector2(400, 600)
      ),
    );
    //position = Vector2(game.size.x - 200, 100);
    //anchor = Anchor.topRight;
    animation = walkAnimation;

    diedsupAnimation = await game.loadSpriteAnimation(
      'died_walk_sup.png',
      SpriteAnimationData.sequenced(
        stepTime: .3,
        amount: 2,
        textureSize: Vector2(130, 203),
        //texturePosition: Vector2(400, 600)
      ),
    );
    //position = Vector2(game.size.x - 200, 100);
    //anchor = Anchor.topRight;
    animation = walkAnimation;
  }

  void jump(double speed) {
    if (position.y == groundYPos) {
      {
        FlameAudio.play('jump_effect.mp3');
        velocity = jumpForce;
      }
    }
  }

  void reset() {
    game.foodCount = 0;
    game.bottleCount = 0;
    game.live = 3;
    game.score = 0;
    game.level = 0;
    game.bottleCount = 0;
    game.foodCount = 0;
    game.showRecycleCenterPoint = 5;
  }

  void gameOver() {}

  void move() {
    velocity = jumpForce;
    if (game.level == 0) {
      animation = jumpAnimation;
    } else if (game.level == 1) {
      // animation = walkdipAnimation;
    } else if (game.level == 2) {
      // level 2 adam
      animation = jumpsupAnimation;
    }
    FlameAudio.play('jump_effect.mp3');
  }

  @override
  void update(double dt) {
    super.update(dt);
    //game.foodText.position = Vector2(position.x + 70, position.y - 100);
    //game.bottleText.position = Vector2(position.x, position.y - 100);

    // Apply gravity
    velocity += gravity * dt;

    // Update position based on velocity
    position.y += velocity * dt;

    // Check if the ball has reached the ground
    if (position.y >= groundY) {
      position.y = groundY; // Ensure the ball stays on the ground
      velocity = 0; // Reset velocity
    }
    // Check if the ball has reached the maximum height
    if (position.y <= maxHeight) {
      position.y = maxHeight; // Limit the ball's height
      velocity = 0; // Reset velocity
    }
    if (position.y == groundY && !isHitNow) {
      setPlayerAnimation();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Bottle) {
      other.takeHit();
      game.collectBottle();
      FlameAudio.play('sound.mp3');
    } else if (other is Food) {
      other.takeHit();
      game.collectFood();
      FlameAudio.play('sound.mp3');
    } else if (other is Health) {
      other.takeHit();
      game.increaseLive();
      FlameAudio.play('sound.mp3');
    } else if (other is EnemyComponent && other.isHit == false) {
      other.isHit = true;
      game.reduceLive();
      FlameAudio.play('horror_hit.mp3');
      isHitNow = true;
      if (game.level == 0) {
        animation = diedvexAnimation;
      } else if (game.level == 1) {
        animation = dieddipAnimation;
      } else if (game.level == 2) {
        animation = diedsupAnimation;
      }
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is EnemyComponent) {
      isHitNow = false;
      setPlayerAnimation();
    }
  }

  void setPlayerAnimation() {
    if (game.level == 0) {
      animation = walkAnimation;
    } else if (game.level == 1) {
      animation = walkdipAnimation;
    } else if (game.level == 2) {
      animation = walksupAnimation;
    }
  }
}
