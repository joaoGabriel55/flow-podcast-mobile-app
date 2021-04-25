import 'package:flowpdc_app/app/widgets/cached_image_widget.dart';
import 'package:flutter/material.dart';

class PodcastThumbnail extends StatelessWidget {
  final String url;
  final Color circularProgressIndicatorColor;
  final double width;

  const PodcastThumbnail({
    Key key,
    this.url,
    this.circularProgressIndicatorColor,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.width,
      child: CachedImageWidget(
        progresIndicatorColor: this.circularProgressIndicatorColor,
        imageUrl: this.url,
      ),
    );
  }
}
