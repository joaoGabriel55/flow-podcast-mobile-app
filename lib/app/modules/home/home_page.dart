import 'package:flowpdc_app/app/shared/models/podcast.dart';
import 'package:flowpdc_app/app/status/status_podcast.dart';
import 'package:flowpdc_app/app/widgets/player/player_controller.dart';
import 'package:flowpdc_app/app/widgets/player/player_widget.dart';
import 'package:flowpdc_app/app/widgets/podcast_card/podcast_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title = "Flow Pdc"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        flexibleSpace: Container(
          margin: EdgeInsets.only(top: 18),
          child: Image(
            image: AssetImage('images/logo.png'),
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(18),
            child: Icon(
              Icons.favorite,
              color: Theme.of(context).accentColor,
              size: 38,
            ),
          )
        ],
        elevation: 0,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.7, 1],
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).accentColor
              ],
            ),
          ),
          child: Observer(
            builder: (_) {
              switch (controller.statusPodcasts) {
                case StatusPodcast.ERROR:
                  return Center(
                    child: RaisedButton(
                      onPressed: () {
                        controller.fetchPodcasts();
                      },
                    ),
                  );
                  break;
                case StatusPodcast.LOADING:
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.amber,
                    ),
                  );
                  break;
                case StatusPodcast.SUCCESS:
                  List<Podcast> _podcasts = controller.podcasts;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      ListView.builder(
                          itemCount: _podcasts.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: PodcastCard(
                                thumbnail: _podcasts[index].thumbnailUrl,
                                title: _podcasts[index].title,
                                description: _podcasts[index].description,
                              ),
                              onTap: () {
                                controller.selectPodcast(_podcasts[index]);
                              },
                            );
                          }),
                      Observer(
                        builder: (_) {
                          if (controller.podcastSelected != null) {
                            return PlayerWidget(
                                podcast: controller.podcastSelected);
                          } else {
                            return Divider();
                          }
                        },
                      ),
                    ],
                  );
                  break;
                default:
                  return Container();
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}
