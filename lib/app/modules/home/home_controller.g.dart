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
  ObservableFuture<dynamic> get podcasts {
    _$podcastsAtom.reportRead();
    return super.podcasts;
  }

  @override
  set podcasts(ObservableFuture<dynamic> value) {
    _$podcastsAtom.reportWrite(value, super.podcasts, () {
      super.podcasts = value;
    });
  }

  final _$podcastSelectedAtom =
      Atom(name: '_HomeControllerBase.podcastSelected');

  @override
  ObservableFuture<dynamic> get podcastSelected {
    _$podcastSelectedAtom.reportRead();
    return super.podcastSelected;
  }

  @override
  set podcastSelected(ObservableFuture<dynamic> value) {
    _$podcastSelectedAtom.reportWrite(value, super.podcastSelected, () {
      super.podcastSelected = value;
    });
  }

  final _$fetchPodcastAsyncAction =
      AsyncAction('_HomeControllerBase.fetchPodcast');

  @override
  Future fetchPodcast(String id) {
    return _$fetchPodcastAsyncAction.run(() => super.fetchPodcast(id));
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  dynamic fetchPodcasts() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.fetchPodcasts');
    try {
      return super.fetchPodcasts();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
podcasts: ${podcasts},
podcastSelected: ${podcastSelected}
    ''';
  }
}
