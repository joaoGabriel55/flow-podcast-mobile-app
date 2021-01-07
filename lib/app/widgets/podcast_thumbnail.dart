import 'package:flutter/material.dart';

class PodcastThumbnail extends StatelessWidget {
  final String url;

  const PodcastThumbnail({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      this.url,
      width: 80,
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          margin: EdgeInsets.all(22),
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes
                : null,
          ),
        );
      },
    );
  }
}
