import 'package:flutter/material.dart';

class PodcastThumbnail extends StatelessWidget {
  final String url;
  final Color circularProgressIndicatorColor;

  const PodcastThumbnail({
    Key key,
    this.url,
    this.circularProgressIndicatorColor,
  }) : super(key: key);

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
            backgroundColor: Colors.black,
            valueColor: AlwaysStoppedAnimation<Color>(
              this.circularProgressIndicatorColor,
            ),
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
