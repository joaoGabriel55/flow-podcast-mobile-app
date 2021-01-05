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
  ObservableList<Podcast> get podcasts {
    _$podcastsAtom.reportRead();
    return super.podcasts;
  }

  @override
  set podcasts(ObservableList<Podcast> value) {
    _$podcastsAtom.reportWrite(value, super.podcasts, () {
      super.podcasts = value;
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
  Future fetchPodcasts() {
    return _$fetchPodcastsAsyncAction.run(() => super.fetchPodcasts());
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
podcastSelected: ${podcastSelected},
statusPodcast: ${statusPodcast},
statusPodcasts: ${statusPodcasts}
    ''';
  }
}
