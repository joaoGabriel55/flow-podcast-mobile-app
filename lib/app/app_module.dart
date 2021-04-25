import 'package:dio/dio.dart';
import 'package:flowpdc_app/app/app_widget.dart';
import 'package:flowpdc_app/app/modules/home/home_module.dart';
import 'package:flowpdc_app/app/shared/repositories/localstorage/local_storage_interface.dart';
import 'package:flowpdc_app/app/shared/repositories/localstorage/local_storage_shared_prefs.dart';
import 'package:flowpdc_app/app/shared/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'widgets/player/player_controller.dart';
import 'widgets/podcast_card/podcast_card_controller.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $PodcastCardController,
        $PlayerController,
        $AppController,
        Bind<ILocalStorage>((i) => LocalStorageSharedPrefs()),
        Bind((i) => Dio(BaseOptions(baseUrl: FLOWPDC_API)))
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
