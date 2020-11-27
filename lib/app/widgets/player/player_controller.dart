import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'player_controller.g.dart';

@Injectable()
class PlayerController = _PlayerControllerBase with _$PlayerController;

abstract class _PlayerControllerBase with Store {
  AssetsAudioPlayer audioPlayer;

  @observable
  ObservableFuture audioUrl;

  @observable
  ObservableFuture assetsAudioPlayer;

  // TODO: Problema no this.audioUrl
  _PlayerControllerBase() {
    //this.audioPlayer = AssetsAudioPlayer();
    //openAudio(this.audioUrl.value);
  }

  @action
  void openAudio(String audioUrl) {
    this.audioPlayer = AssetsAudioPlayer();
    this.audioPlayer.open(
          Audio.network(audioUrl),
        );
    assetsAudioPlayer = ObservableFuture.value(this.audioPlayer);
  }
}
