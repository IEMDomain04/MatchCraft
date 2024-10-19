import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

List<String> imageSource() {
  return [
    'assets/images/image_1.png',
    'assets/images/image_9.png',
    'assets/images/image_21.png',
    'assets/images/image_4.png',
    'assets/images/image_5.png',
    'assets/images/image_13.png',
    'assets/images/image_7.png',
    'assets/images/image_8.png',
    'assets/images/image_1.png',
    'assets/images/image_9.png',
    'assets/images/image_21.png',
    'assets/images/image_4.png',
    'assets/images/image_5.png',
    'assets/images/image_13.png',
    'assets/images/image_7.png',
    'assets/images/image_8.png',
  ];
}

List createShuffledListFromImageSource() {
  List shuffledImages = [];
  List sourceArray = imageSource();
  for (var element in sourceArray) {
    shuffledImages.add(element);
  }
  shuffledImages.shuffle();
  return shuffledImages;
}

List<bool> getInitialItemStateList() {
  List<bool> initialItem = <bool>[];
  for (int i = 0; i < 16; i++) {
    initialItem.add(true);
  }
  return initialItem;
}

List<GlobalKey<FlipCardState>> createFlipCardStateKeysList() {
  List<GlobalKey<FlipCardState>> cardStateKeys = <GlobalKey<FlipCardState>>[];
  for (int i = 0; i < 16; i++) {
    cardStateKeys.add(GlobalKey<FlipCardState>());
  }
  return cardStateKeys;
}
