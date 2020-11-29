import 'package:flowpdc_app/app/shared/models/podcast.dart';
import 'package:flowpdc_app/app/widgets/player/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class PlayerWidget extends StatefulWidget {
  final Podcast podcast;

  const PlayerWidget({Key key, this.podcast}) : super(key: key);
  @override
  _PlayerWidget createState() => new _PlayerWidget();
}

class _PlayerWidget extends ModularState<PlayerWidget, PlayerController> {
  double _value = 0.0;
  void _setvalue(double value) => setState(() => _value = value);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border(
              top: BorderSide(width: 1.0, color: Colors.white),
            ),
          ),
          margin: EdgeInsets.all(0),
          child: Observer(
            builder: (_) {
              // controller.audioUrl = ObservableFuture.value(widget.podcast.audioUrl);
              /*AssetsAudioPlayer audioPlayer =
                  controller.assetsAudioPlayer.value;
                  */
              return Container(
                margin: EdgeInsets.only(left: 18, right: 18, bottom: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Image.network(
                      widget.podcast.thumbnailUrl,
                      width: 80,
                      fit: BoxFit.fill,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(0),
                          padding: EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Slider(
                            value: _value,
                            onChanged: _setvalue,
                            activeColor: Theme.of(context).accentColor,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 24),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      widget.podcast.title,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            /*
                            Container(
                              margin: EdgeInsets.all(8),
                              child: IconButton(
                                icon: Icon(
                                  audioPlayer.isPlaying.value
                                      ? Icons.pause_circle_filled
                                      : Icons.play_circle_fill,
                                  color: Colors.white,
                                  size: 38,
                                ),
                                onPressed: () async {
                                  if (audioPlayer.playlist != null) {
                                    audioPlayer.playOrPause();
                                  }
                                },
                              ),
                            ),
                            */
                            Container(
                                margin: EdgeInsets.all(8),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Theme.of(context).accentColor,
                                    size: 38,
                                  ),
                                  onPressed: () {},
                                ))
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
