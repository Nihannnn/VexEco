import 'package:flutter/material.dart';
import 'package:second_try/config/assets.dart';
import 'package:second_try/main.dart';

class RecycleCenterScreen extends StatelessWidget {
  final VexEcoGame game;
  final int level1 = 1, level2 = 26, level3 = 52;
  static const String id = 'recycleCenter';
  RecycleCenterScreen({
    Key? key,
    required this.game,
  }) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    Map<String, List<double>> spaceSizesByDevices = {
      'web': [
        (screenHeight / 8) * 3,
        (screenHeight / 8) * 0,
        (screenHeight / 8) * 0,
        (screenHeight / 8) * 0
      ],
      'mobile': [
        (screenHeight / 8) * 2.5,
        (screenHeight / 8) * 0,
        (screenHeight / 8) * 0.2,
        (screenHeight / 8) * 0.5
      ],
    };

    List<double> spaceSizes = spaceSizesByDevices[game.getDeviceType()] ??
        [
          (screenHeight / 8) * 2.5,
          (screenHeight / 8) * 0,
          (screenHeight / 8) * 0.2,
          (screenHeight / 8) * 0.5
        ];

    Semantics(
      label: 'Champion',
      child: Image.asset(
        Assets.recycleCenterImage,
      ),
    );

    String recycleCenterImage =
        'assets/images/recycle_inside_${game.getDeviceType()}.png';

    double scale1 = 1.3, scale2 = 1.3, scale3 = 1.3;
    String youSavedAnimalPicture = 'turtle.png';

    String semanticLabel;
    if (youSavedAnimalPicture == 'turtle.png') {
      semanticLabel = 'You saved Tex the turtle';
    } else {
      semanticLabel = 'You saved Cex the crab';
    }

// Display the image with the appropriate semantic label
    Semantics(
      label: semanticLabel,
      child: Image.asset(
        'assets/images/$youSavedAnimalPicture',
        height: (screenHeight / 8) * 1.5,
      ),
    );

    int currentScore = game.score;
    print('currentScore=$currentScore');
    if (currentScore < level2) {
      youSavedAnimalPicture = 'crab.png';
      scale1 = 1;
      game.level = 0;
    } else if (currentScore >= level2 && currentScore < level3) {
      youSavedAnimalPicture = 'turtle.png';
      scale2 = 1;
      game.level = 1;
    } else {
      youSavedAnimalPicture = 'turtle.png';
      scale3 = 1;
      game.level = 2;
    }

    List<Widget> imageWidgets = [
      Semantics(
        label: 'Vex',
        child: Image.asset('assets/images/stage_1.png', scale: scale1),
      ),
      Semantics(
        label: 'DipVex 26 000 gold',
        child: Image.asset('assets/images/stage_2.png', scale: scale2),
      ),
      Semantics(
        label: 'SupVex 52 000 gold',
        child: Image.asset('assets/images/stage_3.png', scale: scale3),
      ),
    ];

    game.pauseEngine();

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          game.overlays.remove('recycleCenter');
          game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(recycleCenterImage),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: spaceSizes[0]),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Semantics(
                      label: 'Gold', // Provide a semantic label for the image
                      child: Image.asset(
                        'assets/images/money.png',
                        width: (screenHeight / 8),
                        height: (screenHeight / 8),
                      ),
                    ),
                    Positioned(
                      bottom: 10, // Adjust position as needed
                      right: 4,
                      child: Semantics(
                        label:
                            'You got: ${currentScore * 1000} gold', // Provide a semantic label for the score
                        child: Text(
                          (currentScore * 1000).toString(),
                          style: const TextStyle(
                            fontFamily: 'Galindo',
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spaceSizes[1]),
              Image.asset(
                'assets/images/$youSavedAnimalPicture',
                height: (screenHeight / 8) * 1.5,
              ),
              SizedBox(height: spaceSizes[2]),
              ElevatedButton(
                onPressed: () => onContinue(currentScore),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF677D4A),
                ),
                child: Semantics(
                  label:
                      'Click this button to Continue', // Provide a semantic label for the button
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Galindo',
                    ),
                  ),
                ),
              ),
              SizedBox(height: spaceSizes[3]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imageWidgets,
              )
            ],
          ),
        ),
      ),
    );
  }

  void onContinue(int currentScore) {
    game.player.setPlayerAnimation();
    game.resumeEngine();
    game.overlays.remove('recycleCenter');
  }
}
