import 'package:flowpdc_app/app/widgets/podcast_thumbnail.dart';
import 'package:flutter/material.dart';

class PodcastDescriptionDialog extends StatefulWidget {
  final String title;
  final String description;
  final String thumbnail;

  const PodcastDescriptionDialog({
    Key key,
    this.title,
    this.description,
    this.thumbnail,
  }) : super(key: key);

  @override
  _PodcastDescriptionDialogState createState() =>
      _PodcastDescriptionDialogState();
}

class _PodcastDescriptionDialogState extends State<PodcastDescriptionDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 18, top: 28, right: 18, bottom: 18),
          margin: EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.black,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Theme.of(context).accentColor),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 78),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 8),
          child: widget.thumbnail != null
              ? PodcastThumbnail(
                  url: this.widget.thumbnail,
                  width: 80,
                )
              : Container(
                  width: 80,
                  child: Icon(
                    Icons.audiotrack,
                    color: Theme.of(context).accentColor,
                    size: 48,
                  ),
                ),
        )
      ],
    );
  }
}
