import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  final String title;
  final String cover;

  MovieItem({this.title, this.cover});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
        cover,
        fit: BoxFit.fill,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes
                  : null,
            ),
          );
        },
      ),
    );
  }
}
