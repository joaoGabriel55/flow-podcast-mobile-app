import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'player_controller.g.dart';

@Injectable()
class PlayerController = _PlayerControllerBase with _$PlayerController;

abstract class _PlayerControllerBase with Store {
  @observable
  ObservableFuture isPlaying;

  @observable
  ObservableFuture audioDuration;

  @observable
  ObservableFuture audioCurrentTime;

  _PlayerControllerBase() {
    this.isPlaying = ObservableFuture.value(true);
    this.audioCurrentTime = ObservableFuture.value(null);
  }
}
