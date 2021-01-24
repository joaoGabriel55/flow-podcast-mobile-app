import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'player_controller.g.dart';

@Injectable()
class PlayerController = _PlayerControllerBase with _$PlayerController;

abstract class _PlayerControllerBase with Store {
  @observable
  bool isPlaying;

  @observable
  ObservableFuture audioDuration;

  @observable
  ObservableFuture audioCurrentTime;

  _PlayerControllerBase() {
    this.isPlaying = false;
  }
}
