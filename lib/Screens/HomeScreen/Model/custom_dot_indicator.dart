import 'package:flutter/material.dart';

class CustomDotIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  CustomDotIndicator({
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currentIndex == index ? Colors.deepOrange : Colors.grey,
          ),
        );
      }),
    );
  }
}
