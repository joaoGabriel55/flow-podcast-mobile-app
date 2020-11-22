// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_selected_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $PodcastSelectedController = BindInject(
  (i) => PodcastSelectedController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PodcastSelectedController on _PodcastSelectedControllerBase, Store {
  final _$valueAtom = Atom(name: '_PodcastSelectedControllerBase.value');

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  final _$_PodcastSelectedControllerBaseActionController =
      ActionController(name: '_PodcastSelectedControllerBase');

  @override
  void increment() {
    final _$actionInfo = _$_PodcastSelectedControllerBaseActionController
        .startAction(name: '_PodcastSelectedControllerBase.increment');
    try {
      return super.increment();
    } finally {
      _$_PodcastSelectedControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value}
    ''';
  }
}
