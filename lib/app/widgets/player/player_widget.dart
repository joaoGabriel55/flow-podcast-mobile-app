import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flowpdc_app/app/shared/models/podcast.dart';
import 'package:flowpdc_app/app/widgets/player/player_controller.dart';
import 'package:flowpdc_app/app/widgets/player/position_seek_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../podcast_thumbnail.dart';

class PlayerWidget extends StatefulWidget {
  final Podcast podcast;
  final bool isFavorite;
  final Function addFavorite;
  final Function closePlayer;

  const PlayerWidget({
    Key key,
    this.podcast,
    this.addFavorite,
    this.isFavorite,
    this.closePlayer,
  }) : super(key: key);

  @override
  _PlayerWidget createState() => new _PlayerWidget();
}

class _PlayerWidget extends ModularState<PlayerWidget, PlayerController> {
  final _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  String _currentAudio;

  @override
  void dispose() {
    super.dispose();
    _assetsAudioPlayer.stop();
    _assetsAudioPlayer.dispose();
  }

  void _loadAudio(String url) {
    _assetsAudioPlayer.stop();
    _assetsAudioPlayer.open(
      Audio.network(
        url,
        metas: Metas(
          title: widget.podcast.title,
          image: MetasImage.network(widget.podcast.thumbnailUrl),
        ),
      ),
      autoStart: true,
      showNotification: true,
      notificationSettings: NotificationSettings(
          nextEnabled: false,
          prevEnabled: false,
          customStopAction: (player) => {
                player.stop(),
                this.widget.closePlayer(),
              }
          // customPlayPauseAction: (player) => player.playOrPause(),
          ),
    );
  }

  IconData getStatusAudio(bool controllerPlaying, dynamic playing) {
    if (playing) return Icons.pause_circle_filled;
    if (controllerPlaying) return Icons.pause_circle_filled;

    return Icons.play_circle_fill;
  }

  @override
  Widget build(BuildContext context) {
    if (_currentAudio == null) {
      _currentAudio = widget.podcast.audioUrl;
      _loadAudio(_currentAudio);
    } else if (_currentAudio != widget.podcast.audioUrl) {
      _currentAudio = widget.podcast.audioUrl;
      _loadAudio(_currentAudio);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.white),
            ),
          ),
          child: Container(
            // margin: EdgeInsets.only(left: 18, right: 18, bottom: 8),
            child: Observer(
              builder: (_) {
                controller.isPlaying =
                    ObservableFuture.value(!_assetsAudioPlayer.isPlaying.value);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 8),
                      width: MediaQuery.of(context).size.width,
                      child: StreamBuilder(
                        stream: _assetsAudioPlayer.realtimePlayingInfos,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return SizedBox();
                          }
                          RealtimePlayingInfos infos = snapshot.data;
                          return PositionSeekWidget(
                            seekTo: (to) {
                              _assetsAudioPlayer.seek(to);
                            },
                            duration: infos.duration,
                            currentPosition: infos.currentPosition,
                          );
                        },
                      ),
                    ),
                    Container(
                      child: ListTile(
                        leading: Container(
                          width: 48,
                          child: PodcastThumbnail(
                            url: widget.podcast.thumbnailUrl,
                          ),
                        ),
                        title: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              widget.podcast.title,
                              overflow: TextOverflow.fade,
                              softWrap: true,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                        trailing: Wrap(
                          spacing: 12, // space between two icons
                          children: <Widget>[
                            Container(
                              child: Observer(
                                builder: (_) {
                                  return IconButton(
                                    icon: Icon(
                                      getStatusAudio(
                                        controller.isPlaying.value,
                                        _assetsAudioPlayer.isPlaying.value,
                                      ),
                                      color: Colors.white,
                                      size: 38,
                                    ),
                                    onPressed: () async {
                                      await _assetsAudioPlayer.playOrPause();
                                      controller.isPlaying =
                                          ObservableFuture.value(
                                              _assetsAudioPlayer
                                                  .isPlaying.value);

                                      print(controller.isPlaying.value);
                                      print(_assetsAudioPlayer.isPlaying.value);
                                    },
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(0),
                              child: IconButton(
                                icon: Icon(
                                  this.widget.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Theme.of(context).accentColor,
                                  size: 38,
                                ),
                                onPressed: this.widget.addFavorite,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
