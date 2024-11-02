import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final double rating;

  RatingWidget({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.yellow,
        );
      }),
    );
  }
}