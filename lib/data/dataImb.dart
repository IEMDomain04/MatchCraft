import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';

List<String> imageSource() {
  return [
    'assets/imb_images/image_a1.png',
    'assets/imb_images/image_b1.png',
    'assets/imb_images/image_c1.png',
    'assets/imb_images/image_d1.png',
    'assets/imb_images/image_e1.png',
    'assets/imb_images/image_f1.png',
    'assets/imb_images/image_g1.png',
    'assets/imb_images/image_h1.png',
    'assets/imb_images/image_a2.png',
    'assets/imb_images/image_b2.png',
    'assets/imb_images/image_c2.png',
    'assets/imb_images/image_d2.png',
    'assets/imb_images/image_e2.png',
    'assets/imb_images/image_f2.png',
    'assets/imb_images/image_g2.png',
    'assets/imb_images/image_h2.png',
  ];
}

List<String> createShuffledListFromImageSource() {
  List<String> shuffledImages = [];
  List<String> sourceArray = imageSource();
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
