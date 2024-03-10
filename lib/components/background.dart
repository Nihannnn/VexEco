import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:second_try/config/assets.dart';
import 'package:second_try/config/game_config.dart';
import 'package:second_try/main.dart';

class Background extends ParallaxComponent<VexEcoGame> {
  Background();

  get gameRef => null;
  bool isPaused = false;
  late Image background;
  late Image background2;
  late Image background3;
  int currentBackground = 0;

  @override
  Future<void> onLoad() async {
    background = await Flame.images.load(Assets.background);
    background2 = await Flame.images.load(Assets.background2);
    background3 = await Flame.images.load(Assets.background3);
    parallax = Parallax(
      [
        ParallaxLayer(ParallaxImage(background, fill: LayerFill.height)),
      ],
    );
  }

  void pauseBackground() {}

  @override
  void update(double dt) {
    super.update(dt);
    if (game.level == 0 && currentBackground != 0) {
      currentBackground = 0;
      parallax = Parallax(
        [
          ParallaxLayer(ParallaxImage(background)),
        ],
      );
    } else if (game.level == 1 && currentBackground != 1) {
      currentBackground = 1;
      parallax = Parallax(
        [
          ParallaxLayer(ParallaxImage(background2)),
        ],
      );
    } else if (game.level == 2 && currentBackground != 2) {
      currentBackground = 2;
      parallax = Parallax(
        [
          ParallaxLayer(ParallaxImage(background3)),
        ],
      );
    }

    if (isPaused) {
      parallax?.baseVelocity.x = 0.0;
    } else {
      // level speed
      parallax?.baseVelocity.x = GameConfig.gameSpeed + game.level * 100;
    }
  }
}
