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
            Container(
              width: 80,
              child: Image.network(
                this.creatorLogoPath,
                width: 80,
                fit: BoxFit.fill,
                loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent loadingProgress,
                ) {
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
              ),
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
