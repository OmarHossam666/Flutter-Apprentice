import 'package:flutter/material.dart';

import '../models/models.dart';
import 'post_card.dart';

class PostSection extends StatelessWidget {
  const PostSection({super.key, required this.posts});

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              'Friend\'s Activity',
              style: textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              return PostCard(post: posts[index]);
            },
            itemCount: posts.length,
            primary: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
          ),
        ],
      ),
    );
  }
}
