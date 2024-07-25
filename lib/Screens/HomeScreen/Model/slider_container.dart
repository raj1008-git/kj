import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../EventModel/event_model.dart';
import '../../BookingsScreen/BookNow/book_now.dart';

class SliderContainer extends StatefulWidget {
  Event event;
  SliderContainer({super.key, required this.event});

  @override
  State<SliderContainer> createState() => _SliderContainerState();
}

class _SliderContainerState extends State<SliderContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookNow(
              event: widget.event,
            ),
          ),
        );
      },
      child: Container(
        // color: Colors.teal,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: AssetImage(widget.event.poster), fit: BoxFit.fill),
        ),
      ),
    );
  }
}
