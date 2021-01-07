import 'package:flowpdc_app/app/shared/models/podcast.dart';
import 'package:flowpdc_app/app/status/status_podcast.dart';
import 'package:flowpdc_app/app/widgets/player/player_widget.dart';
import 'package:flowpdc_app/app/widgets/podcast_card/podcast_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title = "Flow Pdc"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        flexibleSpace: Container(
          margin: EdgeInsets.only(top: 48),
          child: Image(
            image: AssetImage('images/logo.png'),
            fit: BoxFit.contain,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border(
              bottom: BorderSide(
                width: 1.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(18),
            child: Observer(builder: (_) {
              return IconButton(
                icon: Icon(
                  !controller.showOnlyFavorites
                      ? Icons.favorite_border
                      : Icons.favorite,
                  color: Theme.of(context).accentColor,
                  size: 38,
                ),
                onPressed: () {
                  controller.showOnlyFavorites = !controller.showOnlyFavorites;
                  if (controller.showOnlyFavorites)
                    controller.fetchFavoritePodcasts();
                  else
                    controller.fetchPodcasts(null);
                },
              );
            }),
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
                      color: Colors.amber,
                      child: Text(
                        !controller.showOnlyFavorites
                            ? "Load podcasts again"
                            : "Load favorite podcasts again",
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        if (controller.showOnlyFavorites)
                          controller.fetchFavoritePodcasts();
                        else
                          controller.fetchPodcasts(null);
                      },
                    ),
                  );
                  break;
                case StatusPodcast.LOADING:
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.black,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    ),
                  );
                  break;
                case StatusPodcast.SUCCESS:
                  Map<String, Podcast> _podcastMap = controller.podcasts;
                  List<String> _podcasts = _podcastMap.keys.toList();
                  List<String> favorites = controller.favoritePodcastsIds;

                  if (_podcasts.isEmpty) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Text(
                        "Podcasts not found...",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    );
                  }

                  print("HEY -> " + controller.loadMoreNextParameter);
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      NotificationListener<ScrollNotification>(
                        // ignore: missing_return
                        onNotification: (ScrollNotification scrollInfo) {
                          if (scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                            controller.fetchPodcasts(
                              controller.loadMoreNextParameter,
                            );
                          }
                        },
                        child: ListView.builder(
                          itemCount: _podcasts.length,
                          padding: EdgeInsets.only(
                            bottom:
                                controller.podcastSelected != null ? 108 : 8,
                          ),
                          itemBuilder: (context, index) {
                            Podcast _podcast = _podcastMap[_podcasts[index]];
                            return GestureDetector(
                              child: Observer(
                                builder: (_) {
                                  return PodcastCard(
                                    thumbnail: _podcast.thumbnailUrl,
                                    title: _podcast.title,
                                    description: _podcast.description,
                                    isFavorite: favorites.contains(_podcast.id),
                                    addFavorite: () {
                                      controller
                                          .addOrRemoveFavorite(_podcast.id);
                                      _podcast.isFavorite =
                                          !_podcast.isFavorite;
                                    },
                                  );
                                },
                              ),
                              onTap: () {
                                controller.selectPodcast(_podcast);
                              },
                            );
                          },
                        ),
                      ),
                      Observer(
                        builder: (_) {
                          if (controller.podcastSelected != null) {
                            Podcast podcast = controller.podcastSelected;
                            return PlayerWidget(
                              podcast: podcast,
                              isFavorite: favorites.contains(podcast.id),
                              addFavorite: () {
                                controller.addOrRemoveFavorite(podcast.id);
                              },
                            );
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
