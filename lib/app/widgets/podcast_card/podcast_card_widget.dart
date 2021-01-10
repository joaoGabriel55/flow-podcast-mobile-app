import 'package:flutter/material.dart';

import '../podcast_thumbnail.dart';

class PodcastCard extends StatefulWidget {
  final String thumbnail;
  final String title;
  final bool isFavorite;
  final Function addFavorite;

  const PodcastCard({
    Key key,
    this.title,
    this.thumbnail,
    this.addFavorite,
    this.isFavorite,
  }) : super(key: key);
  @override
  _PodcastCard createState() => new _PodcastCard();
}

class _PodcastCard extends State<PodcastCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 27, 27, 27),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Color.fromARGB(100, 255, 184, 0),
          width: 0.8,
        ),
      ),
      margin: EdgeInsets.only(top: 8, left: 18, right: 18, bottom: 8),
      child: Container(
        margin: EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.thumbnail != null
                ? PodcastThumbnail(url: this.widget.thumbnail)
                : Container(
                    width: 80,
                    child: Icon(
                      Icons.audiotrack,
                      color: Theme.of(context).accentColor,
                      size: 48,
                    ),
                  ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 8),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        widget.title,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: IconButton(
                icon: Icon(
                  this.widget.isFavorite
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Theme.of(context).accentColor,
                  size: 28,
                ),
                onPressed: this.widget.addFavorite,
              ),
            )
          ],
        ),
      ),
    );
  }
}
