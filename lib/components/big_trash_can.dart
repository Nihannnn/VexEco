import 'dart:ui';

import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:second_try/components/background.dart';
import 'package:second_try/config/game_config.dart';
import 'package:second_try/main.dart';

class BigRecycle extends SpriteAnimationComponent
    with HasGameReference<VexEcoGame>, TapCallbacks {
  static final Vector2 initialSize = Vector2.all(100);
  static const speed = GameConfig.gameSpeed;

  late SpriteAnimation recyleCenterAnimation;

  BigRecycle()
      : super(
          size: Vector2.all(300.0),
          position: Vector2(300, 100),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = Vector2(game.size.x, 100);
    animation = await game.loadSpriteAnimation(
      'recycle_center.png',
      SpriteAnimationData.sequenced(
        amount: 2,
        stepTime: .2,
        textureSize: Vector2(2366, 2655),
      ),
    );
  }

  //@override
  //Future<void> onLoad() async {
  //await super.onLoad();
  // sprite = Sprite(await game.images.load('big_recycle.png'));
  //  width = 220; // Set the width to 200 (adjust as needed)
  //  height = 300; // Set the height to 200 (adjust as needed)
  //  x = game.size.x / 2 - width / 2 + 50; // Center the BigRecycle horizontally
  // y = game.size.y / 2 - height / 2 -80; // Center the BigRecycle vertically
  // }

  @override
  void onTapDown(TapDownEvent event) {
    // Do something in response to a tap event
    game.gotoRecycleCenter();
  }

  @override
  void update(double dt) {
    super.update(dt);
    x -= (speed / 2) * dt;

    if (x < -1 * game.size.x) {
      removeFromParent();
    }
  }
}
