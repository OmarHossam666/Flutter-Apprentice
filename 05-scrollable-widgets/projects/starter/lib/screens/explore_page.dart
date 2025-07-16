import 'package:flutter/material.dart';

import '../api/mock_yummy_service.dart';
import '../components/category_section.dart';
import '../components/post_section.dart';
import '../components/restaurant_section.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({super.key});

  final MockYummyService mockYummyService = MockYummyService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: mockYummyService.getExploreData(),
        builder: (context, AsyncSnapshot<ExploreData> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final restaurants = snapshot.data?.restaurants ?? [];
            final catogries = snapshot.data?.categories ?? [];
            final friendPosts = snapshot.data?.friendPosts ?? [];
            return ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                RestaurantSection(restaurants: restaurants),
                CategorySection(categories: catogries),
                PostSection(posts: friendPosts),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
