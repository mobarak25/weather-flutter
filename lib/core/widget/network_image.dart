import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageB extends StatelessWidget {
  const NetworkImageB({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => FittedBox(
          child: Icon(
        Icons.image,
        color: Colors.black.withOpacity(0.6),
      )),
      errorWidget: (context, url, error) => FittedBox(
          child: Icon(
        Icons.error,
        color: Colors.red.withOpacity(0.8),
      )),
      fit: BoxFit.cover,
    );
  }
}
