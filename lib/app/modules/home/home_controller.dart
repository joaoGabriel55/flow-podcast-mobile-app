import 'package:flowpdc_app/app/shared/models/podcast.dart';
import 'package:flowpdc_app/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:flowpdc_app/app/shared/repositories/podcast_repository.dart';
import 'package:flowpdc_app/app/status/status_podcast.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final PodcastRepository repository;
  final ILocalStorage _storage = Modular.get();

  @observable
  ObservableMap<String, Podcast> podcasts;

  @observable
  String loadMoreNextParameter;

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
    fetchPodcasts(null);
  }

  @action
  selectPodcast(Podcast podcast) => podcastSelected = podcast;

  @action
  fetchPodcasts(String nextPaging) async {
    try {
      PodcastResponse result;
      if (nextPaging == null) {
        statusPodcasts = StatusPodcast.LOADING;
        result = await repository.getAllPodcasts();
        podcasts = ObservableMap<String, Podcast>();
      } else {
        result = await repository.loadMorePodcasts(nextPaging);
      }
      loadMoreNextParameter = result.next;
      podcasts.addAll(result.podcastMap.asObservable());

      statusPodcasts = StatusPodcast.SUCCESS;
      favoritePodcastsIds = await getFavoritesPodcastsIds();
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

    if (podcasts.containsKey(podcastFavorited.id)) {
      podcasts[podcastFavorited.id] = podcastFavorited;
    }

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
      throw Exception(e.toString());
    }
  }

  @action
  fetchFavoritePodcasts() async {
    try {
      statusPodcasts = StatusPodcast.LOADING;
      List<String> favorites = await getFavoritesPodcastsIds();

      ObservableMap<String, Podcast> favoritePodcasts =
          ObservableMap<String, Podcast>();

      for (String id in favorites) {
        Podcast podcast = await repository.getPodcast(id);
        favoritePodcasts[podcast.id] = podcast;
      }
      podcasts = favoritePodcasts;
      statusPodcasts = StatusPodcast.SUCCESS;
    } catch (e) {
      statusPodcast = StatusPodcast.ERROR;
    }
  }
}
