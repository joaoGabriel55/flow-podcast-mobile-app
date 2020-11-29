// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $PlayerController = BindInject(
  (i) => PlayerController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlayerController on _PlayerControllerBase, Store {
  final _$audioUrlAtom = Atom(name: '_PlayerControllerBase.audioUrl');

  @override
  ObservableFuture<dynamic> get audioUrl {
    _$audioUrlAtom.reportRead();
    return super.audioUrl;
  }

  @override
  set audioUrl(ObservableFuture<dynamic> value) {
    _$audioUrlAtom.reportWrite(value, super.audioUrl, () {
      super.audioUrl = value;
    });
  }

  final _$assetsAudioPlayerAtom =
      Atom(name: '_PlayerControllerBase.assetsAudioPlayer');

  @override
  ObservableFuture<dynamic> get assetsAudioPlayer {
    _$assetsAudioPlayerAtom.reportRead();
    return super.assetsAudioPlayer;
  }

  @override
  set assetsAudioPlayer(ObservableFuture<dynamic> value) {
    _$assetsAudioPlayerAtom.reportWrite(value, super.assetsAudioPlayer, () {
      super.assetsAudioPlayer = value;
    });
  }

  final _$_PlayerControllerBaseActionController =
      ActionController(name: '_PlayerControllerBase');

  @override
  void openAudio(String audioUrl) {
    final _$actionInfo = _$_PlayerControllerBaseActionController.startAction(
        name: '_PlayerControllerBase.openAudio');
    try {
      return super.openAudio(audioUrl);
    } finally {
      _$_PlayerControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
audioUrl: ${audioUrl},
assetsAudioPlayer: ${assetsAudioPlayer}
    ''';
  }
}
