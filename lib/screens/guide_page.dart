import 'package:flutter/material.dart';
import 'package:second_try/main.dart';

class TutorialScreen extends StatelessWidget {
  final VexEcoGame game;

  TutorialScreen({Key? key, required this.game}) : super(key: key);

  void onCloseIconPressed() {
    print('onCloseIconPressed');
    game.overlays.remove('guideScreen');
    game.overlays.add('mainMenu');
  }

  PageController _pageController = PageController();
  int _currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    String deviceType = game.getDeviceType();
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: game.guideType == 'tutorial'
            ? [
                Semantics(
                  label:
                      'Tutorial Page1 - Experience the thrill as Vex races automatically through the challenges in the dynamic world of Vexeco. Slide left to see tutorial page 2.',
                  child: TutorialPage(
                    color: Colors.blue,
                    text: "",
                    imagePath:
                        "assets/images/info_1_${game.getDeviceType()}.png",
                    pageController: _pageController,
                    currentPageIndex: _currentPageIndex,
                    deviceType: deviceType,
                    onCloseIconPressed: onCloseIconPressed,
                    nextPreviousController: true,
                  ),
                ),
                Semantics(
                  label:
                      'Tutorial Page 2 - He is assigned the task of collecting trash from the environment. Slide left to see tutorial page 3.',
                  child: TutorialPage(
                    color: Colors.blue,
                    text: "",
                    imagePath:
                        "assets/images/info_2_${game.getDeviceType()}.png",
                    pageController: _pageController,
                    currentPageIndex: _currentPageIndex,
                    deviceType: deviceType,
                    onCloseIconPressed: onCloseIconPressed,
                    nextPreviousController: true,
                  ),
                ),
                Semantics(
                  label:
                      'Tutorial Page 3 - Move away from these enemies. Slide left to see tutorial page 4.',
                  child: TutorialPage(
                    color: Colors.blue,
                    text: "",
                    imagePath:
                        "assets/images/info_3_${game.getDeviceType()}.png",
                    pageController: _pageController,
                    currentPageIndex: _currentPageIndex,
                    deviceType: deviceType,
                    onCloseIconPressed: onCloseIconPressed,
                    nextPreviousController: true,
                  ),
                ),
                Semantics(
                  label:
                      'Tutorial Page 4 - Head to the recycling center to exchange items for money and explore new environments.',
                  child: TutorialPage(
                    color: Colors.blue,
                    text: "",
                    imagePath:
                        "assets/images/info_4_${game.getDeviceType()}.png",
                    pageController: _pageController,
                    currentPageIndex: _currentPageIndex,
                    isLastPage: true,
                    onCloseIconPressed: onCloseIconPressed,
                    deviceType: deviceType,
                    nextPreviousController: true,
                    onStartGamePressed: () {
                      // Handle button press event (e.g., navigate to the game screen)
                      game.overlays.remove('guideScreen');
                      // game.overlays.remove('gameOver');
                      game.resumeEngine();
                    },
                  ),
                ),
              ]
            : [
                Semantics(
                  label:
                      'Tutorial Page1 - Experience the thrill as Vex races automatically through the challenges in the dynamic world of Vexeco. Slide left to see tutorial page 2.',
                  child: TutorialPage(
                    color: Colors.blue,
                    text: "",
                    imagePath: "assets/images/rescuer_${game.getDeviceType()}.png",
                    pageController: _pageController,
                    currentPageIndex: _currentPageIndex,
                    onCloseIconPressed: onCloseIconPressed,
                    deviceType: deviceType,
                    crossIconPosition: 90,
                    nextPreviousController: false,
                  ),
                )
              ],
      ),
    );
  }
}

class TutorialPage extends StatelessWidget {
  final Color color;
  final String text;
  final String imagePath;
  final PageController pageController;
  final int currentPageIndex;
  final String deviceType;
  final bool isLastPage; // Indicator for the last page
  final VoidCallback? onStartGamePressed; // Callback for the button press
  final VoidCallback? onCloseIconPressed; // Callback for the button press
  final double? crossIconPosition;
  final bool nextPreviousController;

  const TutorialPage({
    Key? key,
    required this.color,
    required this.text,
    required this.imagePath,
    required this.currentPageIndex,
    required this.pageController,
    required this.deviceType,
    required this.nextPreviousController,
    this.isLastPage = false, // Default to false
    this.onStartGamePressed, // Optional callback
    this.onCloseIconPressed,
    this.crossIconPosition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: color,
            child: Center(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (isLastPage)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Semantics(
                  label:
                      'Click Start Game button to start game.', // Semantic label for the button
                  child: ElevatedButton(
                    onPressed: onStartGamePressed,
                    child: Text(
                      'Start Game',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Galindo',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (deviceType == 'mobile')
            Positioned(
              top: crossIconPosition == null ? 200 : crossIconPosition,
              right: 50,
              child: Semantics(
                label: 'Close Tutorial Page',
                child: GestureDetector(
                  onTap: onCloseIconPressed,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          if (deviceType != 'mobile')
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (nextPreviousController)
                      ElevatedButton(
                        onPressed: () {
                          pageController.previousPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text('Previous'),
                      ),
                    SizedBox(width: 20),
                    if (nextPreviousController)
                      ElevatedButton(
                        onPressed: () {
                          pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text('Next'),
                      ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: onCloseIconPressed,
                      child: Text('Close'),
                    ),
                  ],
                )),
        ],
      ),
    );
  }
}
