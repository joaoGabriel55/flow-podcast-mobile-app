import 'package:dio/dio.dart';
import 'package:flowpdc_app/app/shared/repositories/podcast_repository.dart';
import 'package:flowpdc_app/app/widgets/player/player_controller.dart';

import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $HomeController,
        Bind((i) => PodcastRepository(i.get<Dio>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
