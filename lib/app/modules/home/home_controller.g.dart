// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeController = BindInject(
  (i) => HomeController(i<PodcastRepository>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$podcastsAtom = Atom(name: '_HomeControllerBase.podcasts');

  @override
  ObservableMap<String, Podcast> get podcasts {
    _$podcastsAtom.reportRead();
    return super.podcasts;
  }

  @override
  set podcasts(ObservableMap<String, Podcast> value) {
    _$podcastsAtom.reportWrite(value, super.podcasts, () {
      super.podcasts = value;
    });
  }

  final _$loadMoreNextParameterAtom =
      Atom(name: '_HomeControllerBase.loadMoreNextParameter');

  @override
  String get loadMoreNextParameter {
    _$loadMoreNextParameterAtom.reportRead();
    return super.loadMoreNextParameter;
  }

  @override
  set loadMoreNextParameter(String value) {
    _$loadMoreNextParameterAtom.reportWrite(value, super.loadMoreNextParameter,
        () {
      super.loadMoreNextParameter = value;
    });
  }

  final _$showOnlyFavoritesAtom =
      Atom(name: '_HomeControllerBase.showOnlyFavorites');

  @override
  bool get showOnlyFavorites {
    _$showOnlyFavoritesAtom.reportRead();
    return super.showOnlyFavorites;
  }

  @override
  set showOnlyFavorites(bool value) {
    _$showOnlyFavoritesAtom.reportWrite(value, super.showOnlyFavorites, () {
      super.showOnlyFavorites = value;
    });
  }

  final _$favoritePodcastsIdsAtom =
      Atom(name: '_HomeControllerBase.favoritePodcastsIds');

  @override
  ObservableList<String> get favoritePodcastsIds {
    _$favoritePodcastsIdsAtom.reportRead();
    return super.favoritePodcastsIds;
  }

  @override
  set favoritePodcastsIds(ObservableList<String> value) {
    _$favoritePodcastsIdsAtom.reportWrite(value, super.favoritePodcastsIds, () {
      super.favoritePodcastsIds = value;
    });
  }

  final _$podcastSelectedAtom =
      Atom(name: '_HomeControllerBase.podcastSelected');

  @override
  Podcast get podcastSelected {
    _$podcastSelectedAtom.reportRead();
    return super.podcastSelected;
  }

  @override
  set podcastSelected(Podcast value) {
    _$podcastSelectedAtom.reportWrite(value, super.podcastSelected, () {
      super.podcastSelected = value;
    });
  }

  final _$statusPodcastAtom = Atom(name: '_HomeControllerBase.statusPodcast');

  @override
  StatusPodcast get statusPodcast {
    _$statusPodcastAtom.reportRead();
    return super.statusPodcast;
  }

  @override
  set statusPodcast(StatusPodcast value) {
    _$statusPodcastAtom.reportWrite(value, super.statusPodcast, () {
      super.statusPodcast = value;
    });
  }

  final _$statusPodcastsAtom = Atom(name: '_HomeControllerBase.statusPodcasts');

  @override
  StatusPodcast get statusPodcasts {
    _$statusPodcastsAtom.reportRead();
    return super.statusPodcasts;
  }

  @override
  set statusPodcasts(StatusPodcast value) {
    _$statusPodcastsAtom.reportWrite(value, super.statusPodcasts, () {
      super.statusPodcasts = value;
    });
  }

  final _$fetchPodcastsAsyncAction =
      AsyncAction('_HomeControllerBase.fetchPodcasts');

  @override
  Future fetchPodcasts({String podcastName, String nextPaging}) {
    return _$fetchPodcastsAsyncAction.run(() =>
        super.fetchPodcasts(podcastName: podcastName, nextPaging: nextPaging));
  }

  final _$fetchPodcastAsyncAction =
      AsyncAction('_HomeControllerBase.fetchPodcast');

  @override
  Future fetchPodcast(String id) {
    return _$fetchPodcastAsyncAction.run(() => super.fetchPodcast(id));
  }

  final _$addOrRemoveFavoriteAsyncAction =
      AsyncAction('_HomeControllerBase.addOrRemoveFavorite');

  @override
  Future addOrRemoveFavorite(String id) {
    return _$addOrRemoveFavoriteAsyncAction
        .run(() => super.addOrRemoveFavorite(id));
  }

  final _$getFavoritesPodcastsIdsAsyncAction =
      AsyncAction('_HomeControllerBase.getFavoritesPodcastsIds');

  @override
  Future getFavoritesPodcastsIds() {
    return _$getFavoritesPodcastsIdsAsyncAction
        .run(() => super.getFavoritesPodcastsIds());
  }

  final _$fetchFavoritePodcastsAsyncAction =
      AsyncAction('_HomeControllerBase.fetchFavoritePodcasts');

  @override
  Future fetchFavoritePodcasts() {
    return _$fetchFavoritePodcastsAsyncAction
        .run(() => super.fetchFavoritePodcasts());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  dynamic selectPodcast(Podcast podcast) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.selectPodcast');
    try {
      return super.selectPodcast(podcast);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
podcasts: ${podcasts},
loadMoreNextParameter: ${loadMoreNextParameter},
showOnlyFavorites: ${showOnlyFavorites},
favoritePodcastsIds: ${favoritePodcastsIds},
podcastSelected: ${podcastSelected},
statusPodcast: ${statusPodcast},
statusPodcasts: ${statusPodcasts}
    ''';
  }
}
