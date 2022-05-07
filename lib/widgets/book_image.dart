import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookImage extends StatelessWidget {
  final String imageUrl;
  const BookImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: 150,
        width: 100,
        fit: BoxFit.cover,
        errorWidget: ((_, __, ___) {
          return Container(
            color: Colors.grey,
            height: 150,
            width: 100,
          );
        }),
      ),
    );
  }
}
