import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'podcast_card_controller.g.dart';

@Injectable()
class PodcastCardController = _PodcastCardControllerBase
    with _$PodcastCardController;

abstract class _PodcastCardControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
