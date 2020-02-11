import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String description;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
    imageUrl: 'assets/images/slider1.png',
    title: 'Healthy Mind',
    description: 'Physical comforts cannot subdue mental suffering, and if we look closely, we can see that those who have many possessions are not necessarily happy. In fact, being wealthy often brings even more anxiety. \n — Dalai Lama'
  ),
  Slide(
    imageUrl: 'assets/images/slider.png',
    title: 'Online Psychiatrist',
    description: 'Anxiety is a normal and often healthy emotion. However, when a person regularly feels disproportionate levels of anxiety, it might become a medical disorder.'
  ),
  Slide(
    imageUrl: 'assets/images/slider2.png',
    title: 'Relationship Anxiety',
    description: 'Relationships can be one of the most pleasurable things on the planet… but they can also be a breeding ground for anxious thoughts and feelings. Relationship anxiety can arise at pretty much any stage of courtship. For many single people, just the thought of being in a relationship can stir up stress. '
  ),
];