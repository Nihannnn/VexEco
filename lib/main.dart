import 'dart:io';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:second_try/components/background.dart';
import 'package:second_try/components/big_recycle_creator.dart';
import 'package:second_try/components/bottle_creator.dart';
import 'package:second_try/components/enemy_creator.dart';
import 'package:second_try/components/food_creator.dart';
import 'package:second_try/components/player.dart';
import 'package:second_try/screens/game_over_screen.dart';
import 'package:second_try/screens/guide_page.dart';
import 'package:second_try/screens/main_menu_screen.dart';
import 'package:second_try/screens/recyle_center_screen.dart';
import 'package:flame_audio/flame_audio.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  final game = VexEcoGame();

  runApp(GameWidget(
    game: game,
    initialActiveOverlays: const [MainMenuScreen.id],
    overlayBuilderMap: {
      'mainMenu': (context, _) => MainMenuScreen(game: game),
      'gameOver': (context, _) => GameOverScreen(game: game),
      'recycleCenter': (context, _) => RecycleCenterScreen(game: game),
      'guideScreen': (context, _) =>
          MaterialApp(home: TutorialScreen(game: game)),
    },
  ));
}

class VexEcoGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  late Player player;
  late Background background;
  late EnemyCreator enemyCreator;
  late TextComponent scoreText;
  late TextComponent liveText;
  late TextComponent bottleText;
  late TextComponent foodText;
  late SpriteComponent recycleBin;
  late SpriteComponent trashBin;
  late BigRecycleCreator bigRecycleCreator;
  late BottleCreator bottleCreator;
  late FoodCreator foodCreator;
  late SpriteComponent heart;
  late final FlameAudio flameAudio;
  late final FlameAudio hitSound;
  late final FlameAudio collectSound;
  bool isMusicPlaying = false;
  String guideType = 'tutorial';

  double currentSpeed = 0.0;

  int score = 0; //total score
  int showRecycleCenterPoint = 5;
  int bottleCount = 0; // Counter for bottles collected
  int foodCount = 0; // Counter for food collected
  int live = 3;
  int level = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Initialize FlameAudio
    bool isPlaying = FlameAudio.bgm.isPlaying;
    if (isMusicPlaying && !isPlaying) {
      FlameAudio.bgm.play('IntroTheme.wav');
    } else {
      FlameAudio.bgm.pause();
    }

    background = Background();
    bigRecycleCreator = BigRecycleCreator();

    player = Player();
    enemyCreator = EnemyCreator();
    bottleCreator = BottleCreator();
    foodCreator = FoodCreator();

    scoreText = TextComponent(
        position: Vector2(600, 700),
        anchor: Anchor.bottomRight,
        priority: 1,
        textRenderer: TextPaint(
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Galindo'),
        ));

    bottleText = TextComponent(
        position: Vector2(600, 700),
        anchor: Anchor.bottomRight,
        priority: 1,
        textRenderer: TextPaint(
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Galindo'),
        ));

    foodText = TextComponent(
        position: Vector2(200, 700),
        anchor: Anchor.bottomRight,
        priority: 1,
        textRenderer: TextPaint(
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Galindo'),
        ));

    liveText = TextComponent(
        position: Vector2(500, 700),
        anchor: Anchor.bottomRight,
        priority: 1,
        textRenderer: TextPaint(
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'Galindo'),
        ));

    await Flame.images.load('character.png');

    recycleBin = SpriteComponent.fromImage(
      Flame.images.fromCache('character.png'),
      size: Vector2(60, 100),
      position: size - Vector2(500, 500),
      anchor: Anchor.bottomRight,
    );

    await Flame.images.load('character_1.png');

    trashBin = SpriteComponent.fromImage(
      Flame.images.fromCache('character_1.png'),
      size: Vector2(60, 100),
      position: size - Vector2(400, 500),
      anchor: Anchor.bottomRight,
    );

    await Flame.images.load('heart.png');

    heart = SpriteComponent.fromImage(
      Flame.images.fromCache('heart.png'),
      size: Vector2(30, 30),
      position: size - Vector2(400, 500),
      anchor: Anchor.bottomRight,
    );

    add(background);
    add(bigRecycleCreator);
    add(bottleCreator..priority = 2);
    add(foodCreator);
    add(trashBin);
    add(recycleBin);
    add(heart);
    add(enemyCreator);
    add(player..priority = 2);

    liveText.position.x = 360;
    liveText.position.y = 50;

    heart.position.x = 330;
    heart.position.y = 50;

    bottleText.position.x = 100;
    bottleText.position.y = 140;

    foodText.position.x = 100;
    foodText.position.y = 250;

    trashBin.position.x = 80;
    trashBin.position.y = 250;

    recycleBin.position.x = 80;
    recycleBin.position.y = 140;

    // add(scoreText);
    add(liveText);
    add(bottleText);
    add(foodText);
  }

  void onAction() {
    player.jump(currentSpeed);
  }

  void pauseParallax() {
    background.pauseBackground();
  }

  @override
  void onTapDown(TapDownEvent event) {
    player.move();
    background.pauseBackground();
  }

  void collectBottle() {
    bottleCount++;
    increaseScore();
  }

  void collectFood() {
    foodCount++;
    increaseScore();
  }

  void increaseScore() {
    score++;
  }

  void reduceLive() {
    if (live == 0) {
      overlays.add('gameOver');
      pauseEngine();
    }
    live--;
  }

  void gotoRecycleCenter() {
    overlays.add('recycleCenter');
    pauseEngine();
  }

  String getDeviceType() {
    if (kIsWeb) {
      return 'web';
    } else if (Platform.isAndroid || Platform.isIOS) {
      return 'mobile';
    } else if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      return 'web';
    } else {
      return 'web';
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    scoreText.text = 'Score: $score';
    bottleText.text = '$bottleCount';
    foodText.text = '$foodCount';

    bottleText.height + 500;

    foodText.height + 80; // space between score and small image
    liveText.text = '$live';
  }
}
