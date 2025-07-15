import 'package:flutter/material.dart';
import '../models/post.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context)
        .textTheme
        .apply(displayColor: Theme.of(context).colorScheme.onSurface);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          spacing: 16,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: Image.asset(post.profileImageUrl).image,
            ),
            Expanded(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  post.comment,
                  style: textTheme.titleMedium,
                ),
                Text(
                  '${post.timestamp} mins ago',
                  style: textTheme.bodySmall,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
