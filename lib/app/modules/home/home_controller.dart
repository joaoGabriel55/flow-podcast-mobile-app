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
  String creatorSelected;

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
    fetchPodcasts();
  }

  String _getCreatorName() {
    return this.creatorSelected == null ? 'flowpodcast' : this.creatorSelected;
  }

  @action
  selectPodcast(Podcast podcast) => podcastSelected = podcast;

  @action
  fetchPodcasts({String podcastName, String nextPaging}) async {
    try {
      PodcastResponse result;
      if (nextPaging == null) {
        statusPodcasts = StatusPodcast.LOADING;
        result = await repository.getAllPodcasts(podcastName: podcastName);
        podcasts = ObservableMap<String, Podcast>();
      } else {
        result = await repository.loadMorePodcasts(
          nextPaging: nextPaging,
          podcastName: podcastName,
        );
      }

      loadMoreNextParameter = result.next;
      if (result.podcastMap.isEmpty) return;

      podcasts.addAll(result.podcastMap.asObservable());
      statusPodcasts = StatusPodcast.SUCCESS;
      favoritePodcastsIds = await getFavoritesPodcastsIds();
    } catch (e) {
      statusPodcasts = StatusPodcast.ERROR;
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
  addOrRemoveFavorite(String id, String creatorName) async {
    String creatorName = _getCreatorName();
    List<String> favorites = await getFavoritesPodcastsIds();
    if (favorites == null) {
      _storage.put(creatorName, []);
      favorites = await getFavoritesPodcastsIds();
    }
    Podcast podcastFavorited = await repository
        .getPodcast(
          id,
          podcastName: this.creatorSelected,
        )
        .asObservable();
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

    _storage.put(creatorName, favorites);
    favoritePodcastsIds = await getFavoritesPodcastsIds();
  }

  @action
  getFavoritesPodcastsIds() async {
    try {
      String creatorName = _getCreatorName();
      List<String> favorites = await _storage.get(creatorName);
      if (favorites == null) {
        _storage.put(creatorName, []);
        favorites = await _storage.get(creatorName);
      }
      favoritePodcastsIds = favorites.asObservable();
      return favoritePodcastsIds;
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
        Podcast podcast = await repository.getPodcast(
          id,
          podcastName: this.creatorSelected,
        );
        favoritePodcasts[podcast.id] = podcast;
      }
      podcasts = favoritePodcasts;
      statusPodcasts = StatusPodcast.SUCCESS;
    } catch (e) {
      statusPodcast = StatusPodcast.ERROR;
    }
  }
}
