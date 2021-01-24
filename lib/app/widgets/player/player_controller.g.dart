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
  final _$isPlayingAtom = Atom(name: '_PlayerControllerBase.isPlaying');

  @override
  bool get isPlaying {
    _$isPlayingAtom.reportRead();
    return super.isPlaying;
  }

  @override
  set isPlaying(bool value) {
    _$isPlayingAtom.reportWrite(value, super.isPlaying, () {
      super.isPlaying = value;
    });
  }

  final _$audioDurationAtom = Atom(name: '_PlayerControllerBase.audioDuration');

  @override
  ObservableFuture<dynamic> get audioDuration {
    _$audioDurationAtom.reportRead();
    return super.audioDuration;
  }

  @override
  set audioDuration(ObservableFuture<dynamic> value) {
    _$audioDurationAtom.reportWrite(value, super.audioDuration, () {
      super.audioDuration = value;
    });
  }

  final _$audioCurrentTimeAtom =
      Atom(name: '_PlayerControllerBase.audioCurrentTime');

  @override
  ObservableFuture<dynamic> get audioCurrentTime {
    _$audioCurrentTimeAtom.reportRead();
    return super.audioCurrentTime;
  }

  @override
  set audioCurrentTime(ObservableFuture<dynamic> value) {
    _$audioCurrentTimeAtom.reportWrite(value, super.audioCurrentTime, () {
      super.audioCurrentTime = value;
    });
  }

  @override
  String toString() {
    return '''
isPlaying: ${isPlaying},
audioDuration: ${audioDuration},
audioCurrentTime: ${audioCurrentTime}
    ''';
  }
}
