import 'package:flutter/material.dart';

class PodcastCard extends StatefulWidget {
  final String thumbnail;
  final String title;
  final String description;

  const PodcastCard({Key key, this.title, this.description, this.thumbnail})
      : super(key: key);
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
            Image.network(
              widget.thumbnail,
              width: 80,
              fit: BoxFit.fill,
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
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 8),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        widget.description,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Theme.of(context).accentColor,
                  size: 28,
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
