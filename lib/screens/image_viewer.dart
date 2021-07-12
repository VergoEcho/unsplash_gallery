import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  final String imageUrl;

  const ImageViewer({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fullscreen',
        ),
      ),
      backgroundColor: Colors.black45,
      body: Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.contain,
          placeholder: (context, imageUrl) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, imageUrl, error) => Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  Text(
                    'Failed to Load image',
                    style: TextStyle(color: Colors.red),
                  )
                ],
              )),
        ),
      ),
    );
  }
}