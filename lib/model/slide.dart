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
    imageUrl: 'assets/images/slider3.png',
    title: 'Mindfulness',
    description: '“Physical comforts cannot subdue mental suffering, and if we look closely, we can see that those who have many possessions are not necessarily happy. In fact, being wealthy often brings even more anxiety.” \n — Dalai Lama'
  ),
  Slide(
    imageUrl: 'assets/images/slider5.png',
    title: 'Confession',
    description: '“People can be so quiet about their pain, that you forget they are hurting. That is why it is so important to always be kind.” \n — Nikita Gill'
  ),
  Slide(
    imageUrl: 'assets/images/slider4.png',
    title: 'Relationship Anxiety',
    description: '“One remedy for the fear of not being loved is to remember how good it feels to love someone. If youre feeling unloved and you want to feel better, go love someone, and see what happens.” \n ― Dossie Easton'
  ),
];