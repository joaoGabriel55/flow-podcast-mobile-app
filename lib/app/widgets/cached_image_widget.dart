import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImageWidget extends StatelessWidget {
  final Color progresIndicatorColor;
  final String imageUrl;
  final double width;

  const CachedImageWidget({
    Key key,
    this.progresIndicatorColor,
    this.imageUrl,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.fill,
      width: this.width,
      height: this.width,
      placeholder: (context, url) => CircularProgressIndicator(
        backgroundColor: Colors.black,
        valueColor: AlwaysStoppedAnimation<Color>(
          this.progresIndicatorColor,
        ),
      ),
      imageUrl: this.imageUrl,
    );
  }
}
