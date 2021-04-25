import 'package:flowpdc_app/app/app_module.dart';
import 'package:flowpdc_app/app/modules/home/home_module.dart';
import 'package:flowpdc_app/app/shared/repositories/podcast_repository.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  PodcastRepository repository;
  initModule(AppModule());
  initModule(HomeModule());

  setUp(() {
    repository = HomeModule.to.get<PodcastRepository>();
  });

  group("getAllPodcasts", () {
    test("should retrieve a flow podcast episodes", () async {
      PodcastResponse result = await repository.getAllPodcasts();

      expect(result.podcastMap.isNotEmpty, true);
    });

    test("should retrieve a specific podcast from flow studios", () async {
      String podcastName = "venuspodcast";
      PodcastResponse result =
          await repository.getAllPodcasts(podcastName: podcastName);

      expect(result.podcastMap.isNotEmpty, true);
    });

    test("should not retrieve a specific podcast from flow studios", () async {
      String expectedResult =
          "Exception: Exception: DioError [DioErrorType.RESPONSE]: Http status error [400]";
      try {
        String podcastName = "venuspodcast2";
        await repository.getAllPodcasts(podcastName: podcastName);

        fail("exception not thrown");
      } catch (e) {
        expect(e.toString(), expectedResult);
      }
    });
  });
}
