import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

enum Level { Hard, Medium, Easy }

List<String> fillSourceList() {
  return [
    "assets/animals/dino.png",
    "assets/animals/dino.png",
    "assets/animals/elephant.png",
    "assets/animals/elephant.png",
    "assets/animals/fish.png",
    "assets/animals/fish.png",
    "assets/animals/frog.png",
    "assets/animals/frog.png",
    "assets/animals/girraf.png",
    "assets/animals/girraf.png",
    "assets/animals/octo.png",
    "assets/animals/octo.png",
    "assets/animals/peacock.png",
    "assets/animals/peacock.png",
    "assets/animals/quest.png",
    "assets/animals/quest.png",
    "assets/animals/rabbit.png",
    "assets/animals/rabbit.png",
    "assets/animals/seahorse.png",
    "assets/animals/seahorse.png",
    "assets/animals/shark.png",
    "assets/animals/shark.png",
    "assets/animals/whale.png",
    "assets/animals/whale.png",
    "assets/animals/wolf.png",
    "assets/animals/wolf.png",
  ];
}

List<String> getSourceArray(
  Level level,
) {
  List<String> levelAndKindList = <String>[];
  List sourceArray = fillSourceList();
  if (level == Level.Hard) {
    for (int i = 0; i < 18; i++) {
      levelAndKindList.add(sourceArray[i]);
    }
    // sourceArray.forEach((element) {
    //   levelAndKindList.add(element);
    // });
  } else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      levelAndKindList.add(sourceArray[i]);
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      levelAndKindList.add(sourceArray[i]);
    }
  }

  levelAndKindList.shuffle();
  return levelAndKindList;
}

List<bool> getInitialItemState(Level level) {
  List<bool> initialItemState = <bool>[];
  if (level == Level.Hard) {
    for (int i = 0; i < 18; i++) {
      initialItemState.add(true);
    }
  } else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      initialItemState.add(true);
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      initialItemState.add(true);
    }
  }
  return initialItemState;
}

List<GlobalKey<FlipCardState>> getCardStateKeys(Level level) {
  List<GlobalKey<FlipCardState>> cardStateKeys = <GlobalKey<FlipCardState>>[];
  if (level == Level.Hard) {
    for (int i = 0; i < 18; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Medium) {
    for (int i = 0; i < 12; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  } else if (level == Level.Easy) {
    for (int i = 0; i < 6; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
    }
  }
  return cardStateKeys;
}
