import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'podcast_selected_controller.g.dart';

@Injectable()
class PodcastSelectedController = _PodcastSelectedControllerBase
    with _$PodcastSelectedController;

abstract class _PodcastSelectedControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
