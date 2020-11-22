import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'podcast_selected_controller.dart';

class PodcastSelectedPage extends StatefulWidget {
  final String title;
  const PodcastSelectedPage({Key key, this.title = "PodcastSelected"})
      : super(key: key);

  @override
  _PodcastSelectedPageState createState() => _PodcastSelectedPageState();
}

class _PodcastSelectedPageState
    extends ModularState<PodcastSelectedPage, PodcastSelectedController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
