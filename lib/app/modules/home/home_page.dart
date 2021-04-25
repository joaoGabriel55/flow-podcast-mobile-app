import 'package:flowpdc_app/app/shared/models/podcast.dart';
import 'package:flowpdc_app/app/shared/utils/flow_creators.dart';
import 'package:flowpdc_app/app/status/status_podcast.dart';
import 'package:flowpdc_app/app/widgets/player/player_widget.dart';
import 'package:flowpdc_app/app/widgets/podcast_card/podcast_card_widget.dart';
import 'package:flowpdc_app/app/widgets/podcast_creators_nav_drawer/podcast_creators_nav_drawer.dart';
import 'package:flowpdc_app/app/widgets/podcast_description_dialog.dart';
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
  void _loadPodcasts() {
    String creatorSelected = controller.creatorSelected;
    if (controller.showOnlyFavorites)
      controller.fetchFavoritePodcasts();
    else
      controller.fetchPodcasts(podcastName: creatorSelected);
  }

  Color getCreatorColor() {
    String creatorSelected = controller.creatorSelected;

    return creatorSelected == null
        ? Theme.of(context).accentColor
        : FLOW_CREATORS[creatorSelected]["color"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, // status bar color
        brightness: Brightness.dark, // status bar brightness
        toolbarHeight: 80,
        flexibleSpace: Container(
          margin: EdgeInsets.only(top: 48),
          child: Observer(
            builder: (_) {
              return InkWell(
                child: Image(
                  image: AssetImage('images/logo.png'),
                  fit: BoxFit.contain,
                ),
                onTap: () {
                  if (controller.creatorSelected != null) {
                    controller.creatorSelected = null;
                    _loadPodcasts();
                  }
                },
              );
            },
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
                  color: getCreatorColor(),
                  size: 38,
                ),
                onPressed: () {
                  controller.showOnlyFavorites = !controller.showOnlyFavorites;
                  _loadPodcasts();
                },
              );
            }),
          )
        ],
        elevation: 0,
      ),
      drawer: Drawer(
        elevation: 8,
        child: Observer(
          builder: (_) {
            return PodcastCreatorsNavDrawer(
              onClickCreator: (creatorNameParam) {
                controller.creatorSelected = creatorNameParam;
                print(creatorNameParam);
                _loadPodcasts();
                Navigator.of(context).pop();
              },
            );
          },
        ),
      ),
      body: Center(
        child: Observer(
          builder: (_) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.7, 1],
                  colors: [Theme.of(context).primaryColor, getCreatorColor()],
                ),
              ),
              child: Stack(
                children: [
                  Observer(
                    builder: (_) {
                      switch (controller.statusPodcasts) {
                        case StatusPodcast.ERROR:
                          return Center(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.amber,
                                ),
                              ),
                              child: Text(
                                !controller.showOnlyFavorites
                                    ? "Load podcasts again"
                                    : "Load favorite podcasts again",
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                _loadPodcasts();
                              },
                            ),
                          );
                          break;
                        case StatusPodcast.LOADING:
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.black,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                getCreatorColor(),
                              ),
                            ),
                          );
                          break;
                        case StatusPodcast.SUCCESS:
                          Map<String, Podcast> _podcastMap =
                              controller.podcasts;
                          List<String> _podcasts = _podcastMap.keys.toList();
                          List<String> favorites =
                              controller.favoritePodcastsIds;

                          if (_podcasts.isEmpty) {
                            return Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child: Text(
                                "Podcasts not found...",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            );
                          }

                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              NotificationListener<ScrollNotification>(
                                // ignore: missing_return
                                onNotification:
                                    (ScrollNotification scrollInfo) {
                                  if (scrollInfo.metrics.pixels ==
                                      scrollInfo.metrics.maxScrollExtent) {
                                    if (!controller.showOnlyFavorites) {
                                      controller.fetchPodcasts(
                                        nextPaging:
                                            controller.loadMoreNextParameter,
                                      );
                                    }
                                  }
                                },
                                child: ListView.builder(
                                  itemCount: _podcasts.length,
                                  padding: EdgeInsets.only(
                                    bottom: controller.podcastSelected != null
                                        ? 108
                                        : 8,
                                  ),
                                  itemBuilder: (context, index) {
                                    Podcast _podcast =
                                        _podcastMap[_podcasts[index]];
                                    return InkWell(
                                      child: Observer(
                                        builder: (_) {
                                          return PodcastCard(
                                            thumbnail: _podcast.thumbnailUrl,
                                            title: _podcast.title,
                                            favoriteIconColor:
                                                getCreatorColor(),
                                            isFavorite:
                                                favorites.contains(_podcast.id),
                                            addFavorite: () {
                                              controller.addOrRemoveFavorite(
                                                  _podcast.id);
                                              _podcast.isFavorite =
                                                  !_podcast.isFavorite;
                                            },
                                          );
                                        },
                                      ),
                                      onTap: () {
                                        controller.selectPodcast(_podcast);
                                      },
                                      onLongPress: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return PodcastDescriptionDialog(
                                              title: _podcast.title,
                                              description: _podcast.description,
                                              thumbnail: _podcast.thumbnailUrl,
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
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
                  Observer(
                    builder: (_) {
                      if (controller.podcastSelected != null) {
                        Podcast podcast = controller.podcastSelected;
                        List<String> favorites = controller.favoritePodcastsIds;
                        return PlayerWidget(
                          podcast: podcast,
                          isFavorite: favorites.contains(podcast.id),
                          addFavorite: () {
                            controller.addOrRemoveFavorite(podcast.id);
                          },
                          closePlayer: () {
                            controller.selectPodcast(null);
                          },
                        );
                      } else {
                        return Divider();
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
