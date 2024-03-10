import 'dart:math';

import 'package:flame/components.dart';
import 'package:second_try/components/big_trash_can.dart';
import 'package:second_try/components/bottle.dart';
import 'package:second_try/components/enemy_component.dart';
import 'package:second_try/main.dart';

class BigRecycleCreator extends TimerComponent with HasGameReference<VexEcoGame>  {
  final Random random = Random();
  final _halfWidth = BigRecycle.initialSize.x / 2;

  BigRecycleCreator() : super(period: 5, repeat: true);

  @override
  void onTick() {
    if(game.score > game.showRecycleCenterPoint){
      game.addAll(
        List.generate(1, (index) => BigRecycle()..priority=1),
      );
      print('showRecycleCenterPoint = ${game.showRecycleCenterPoint}');
      game.showRecycleCenterPoint += 10;
    }
  }
}


