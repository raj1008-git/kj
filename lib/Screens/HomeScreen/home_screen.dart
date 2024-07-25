import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kata_jane/Screens/HomeScreen/Widgets/featured_tile_list.dart';
import 'Model/custom_dot_indicator.dart';
import 'Widgets/featured_tile_list2.dart';
import 'Widgets/slider_container_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: const Text('Trending',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.red,
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            CarouselSlider(
              items: sliderContainerList,
              options: CarouselOptions(
                height: 220,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 2),
                pauseAutoPlayOnTouch: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            CustomDotIndicator(
              itemCount: sliderContainerList.length,
              currentIndex: _current,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: const Text(
                'Featured',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                  mainAxisSpacing: 20.0, // Spacing between rows
                  crossAxisSpacing: 20.0, // Spacing between columns
                  childAspectRatio: 0.8, // Aspect ratio of each item
                ),
                itemCount: featuredTileList
                    .length, // Total number of items in the list
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: featuredTileList[index],
                  ); // Build each item from the list
                },
                padding: EdgeInsets.all(8.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
