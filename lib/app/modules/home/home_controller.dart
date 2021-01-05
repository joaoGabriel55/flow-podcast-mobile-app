import 'package:flowpdc_app/app/shared/models/podcast.dart';
import 'package:flowpdc_app/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:flowpdc_app/app/shared/repositories/podcast_repository.dart';
import 'package:flowpdc_app/app/status/status_podcast.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final PodcastRepository repository;
  final ILocalStorage _storage = Modular.get();

  @observable
  ObservableList<Podcast> podcasts;

  @observable
  bool showOnlyFavorites;

  @observable
  ObservableList<String> favoritePodcastsIds;

  @observable
  Podcast podcastSelected;

  @observable
  StatusPodcast statusPodcast = StatusPodcast.INITIAL;

  @observable
  StatusPodcast statusPodcasts = StatusPodcast.INITIAL;

  _HomeControllerBase(this.repository) {
    showOnlyFavorites = false;
    fetchPodcasts();
  }

  @action
  selectPodcast(Podcast podcast) => podcastSelected = podcast;

  @action
  fetchPodcasts() async {
    try {
      statusPodcasts = StatusPodcast.LOADING;
      podcasts = await repository.getAllPodcasts();
      favoritePodcastsIds = await getFavoritesPodcastsIds();
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

  @action
  addOrRemoveFavorite(String id) async {
    List<String> favorites = await getFavoritesPodcastsIds();
    if (favorites == null) {
      _storage.put('favorites', List());
      favorites = await getFavoritesPodcastsIds();
    }
    Podcast podcastFavorited = await repository.getPodcast(id).asObservable();
    if (!favorites.contains(id)) {
      favorites.add(id);
      podcastFavorited.isFavorite = true;
    } else {
      favorites.remove(id);
      podcastFavorited.isFavorite = false;
    }
    podcasts.forEach((element) {
      if (element.id == podcastFavorited.id) {
        element = podcastFavorited;
      }
    });
    _storage.put('favorites', favorites);
    favoritePodcastsIds = await getFavoritesPodcastsIds();
  }

  @action
  getFavoritesPodcastsIds() async {
    try {
      List<String> favorites = await _storage.get('favorites');
      if (favorites == null) {
        _storage.put('favorites', List());
        favorites = await _storage.get('favorites');
      }
      return favorites.asObservable();
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  @action
  fetchFavoritePodcasts() async {
    try {
      statusPodcasts = StatusPodcast.LOADING;
      List<String> favorites = await getFavoritesPodcastsIds();

      ObservableList<Podcast> favoritePodcasts = ObservableList<Podcast>();
      for (String id in favorites) {
        Podcast podcast = await repository.getPodcast(id);
        favoritePodcasts.add(podcast);
      }
      podcasts = favoritePodcasts;
      statusPodcasts = StatusPodcast.SUCCESS;
    } catch (e) {
      print(e);
      statusPodcast = StatusPodcast.ERROR;
    }
  }
}
