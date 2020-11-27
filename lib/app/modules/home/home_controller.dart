import 'package:flowpdc_app/app/shared/models/podcast.dart';
import 'package:flowpdc_app/app/shared/repositories/podcast_repository.dart';
import 'package:flowpdc_app/app/status/status_podcast.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final PodcastRepository repository;

  @observable
  ObservableList<Podcast> podcasts;

  @observable
  Podcast podcastSelected;

  @observable
  StatusPodcast statusPodcast = StatusPodcast.INITIAL;

  @observable
  StatusPodcast statusPodcasts = StatusPodcast.INITIAL;

  _HomeControllerBase(this.repository) {
    fetchPodcasts();
  }

  @action
  selectPodcast(Podcast podcast) => podcastSelected = podcast;

  @action
  fetchPodcasts() async {
    try {
      statusPodcasts = StatusPodcast.LOADING;
      podcasts = await repository.getAllPodcasts();
      statusPodcasts = StatusPodcast.SUCCESS;
    } catch (e) {
      statusPodcasts = StatusPodcast.ERROR;
      //statusPodcasts.setMensagem = "Ex mensagem de erro";
    }
  }

  @action
  fetchPodcast(String id) async {
    try {
      statusPodcast = StatusPodcast.LOADING;
      podcastSelected = await repository.getPodcast(id).asObservable();
      statusPodcast = StatusPodcast.SUCCESS;
    } catch (e) {
      statusPodcast = StatusPodcast.ERROR;
      //statusPodcastSelected.setMensagem = "Ex mensagem de erro";
    }
  }

  // TODO: Favorite
}
