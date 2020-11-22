import 'package:flowpdc_app/app/shared/repositories/podcast_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final PodcastRepository repository;

  @observable
  ObservableFuture podcasts;

  @observable
  ObservableFuture podcastSelected;

  _HomeControllerBase(this.repository) {
    fetchPodcasts();
  }

  @action
  fetchPodcasts() {
    podcasts = repository.getAllPodcasts().asObservable();
  }

  @action
  fetchPodcast(String id) async {
    podcastSelected = repository.getPodcast(id).asObservable();
  }

  // TODO: Favorite
}
