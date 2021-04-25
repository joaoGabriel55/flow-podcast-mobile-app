import 'package:flowpdc_app/app/widgets/cached_image_widget.dart';
import 'package:flowpdc_app/app/widgets/podcast_thumbnail.dart';
import 'package:flutter/material.dart';

class PodcastCreatorLink extends StatelessWidget {
  final String creatorName;
  final String creatorLogoPath;
  final String creatorParam;
  final Function onClickLink;

  const PodcastCreatorLink({
    Key key,
    this.creatorName,
    this.creatorLogoPath,
    this.creatorParam,
    this.onClickLink,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 8,
        bottom: 8,
        left: 8,
      ),
      child: InkWell(
        child: Row(
          children: [
            PodcastThumbnail(
              width: 80,
              url: this.creatorLogoPath,
            ),
            Container(
              margin: EdgeInsets.only(left: 18),
              child: Text(
                this.creatorName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
        onTap: () {
          this.onClickLink(this.creatorParam);
        },
      ),
    );
  }
}
