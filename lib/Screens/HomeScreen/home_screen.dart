// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:kata_jane/EventModel/event_model.dart';
//
// import '../../Functions/fetch_events.dart';
// import 'Model/custom_dot_indicator.dart';
// import 'Model/featured_tile.dart';
// import 'Widgets/slider_container_list.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   int _current = 0;
//   late Future<List<Event>> _eventsFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _eventsFuture = fetchEvents();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         padding: const EdgeInsets.only(top: 15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               padding: const EdgeInsets.only(left: 20),
//               child: const Text(
//                 'Trending',
//                 style: TextStyle(
//                   fontSize: 24,
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 15),
//             CarouselSlider(
//               items: sliderContainerList,
//               options: CarouselOptions(
//                 height: 220,
//                 enlargeCenterPage: true,
//                 autoPlay: true,
//                 autoPlayInterval: const Duration(seconds: 2),
//                 pauseAutoPlayOnTouch: true,
//                 onPageChanged: (index, reason) {
//                   setState(() {
//                     _current = index;
//                   });
//                 },
//               ),
//             ),
//             const SizedBox(height: 25),
//             CustomDotIndicator(
//               itemCount: sliderContainerList.length,
//               currentIndex: _current,
//             ),
//             Container(
//               padding: const EdgeInsets.only(left: 20),
//               child: const Text(
//                 'Featured',
//                 style: TextStyle(
//                   fontSize: 24,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               padding: const EdgeInsets.only(left: 10, right: 10),
//               child: FutureBuilder<List<Event>>(
//                 future: _eventsFuture,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return const Center(child: Text('No events available.'));
//                   } else {
//                     final events = snapshot.data!;
//                     return GridView.builder(
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2, // Number of columns
//                         mainAxisSpacing: 20.0, // Spacing between rows
//                         crossAxisSpacing: 20.0, // Spacing between columns
//                         childAspectRatio: 0.8, // Aspect ratio of each item
//                       ),
//                       itemCount: events.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.all(0.0),
//                           child: FeaturedTile(event: events[index]),
//                         );
//                       },
//                       padding: const EdgeInsets.all(8.0),
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kata_jane/EventModel/event_model.dart';

import '../../Functions/fetch_events.dart';
import 'Model/custom_dot_indicator.dart';
import 'Model/featured_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;
  late Future<List<Event>> _eventsFuture;

  @override
  void initState() {
    super.initState();
    _eventsFuture = fetchEvents();
  }

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
              child: const Text(
                'Trending',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(height: 15),
            FutureBuilder<List<Event>>(
              future: _eventsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No events available.'));
                } else {
                  final events = snapshot.data!;
                  final sliderItems = events.map((event) {
                    return Container(
                      margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: NetworkImage(event
                              .poster), // Make sure the Event model has posterUrl
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }).toList();

                  return Column(
                    children: [
                      CarouselSlider(
                        items: sliderItems,
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
                      const SizedBox(height: 25),
                      CustomDotIndicator(
                        itemCount: sliderItems.length,
                        currentIndex: _current,
                      ),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 25),
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
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: FutureBuilder<List<Event>>(
                future: _eventsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No events available.'));
                  } else {
                    final events = snapshot.data!;
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        mainAxisSpacing: 20.0, // Spacing between rows
                        crossAxisSpacing: 20.0, // Spacing between columns
                        childAspectRatio: 0.8, // Aspect ratio of each item
                      ),
                      itemCount: events.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: FeaturedTile(event: events[index]),
                        );
                      },
                      padding: const EdgeInsets.all(8.0),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
