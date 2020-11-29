import 'package:dio/dio.dart';
import 'package:flowpdc_app/app/shared/models/podcast.dart';
import 'package:mobx/mobx.dart';

class PodcastRepository {
  final Dio dio;

  PodcastRepository(this.dio);
  Future<ObservableList<Podcast>> getAllPodcasts() async {
    var payload = {
      "params": {"filter": "episodes"}
    };

    var response = await dio.post("episodes/list", data: payload);
    List<Podcast> list = [];
    for (var json in (response.data['episodes'] as List)) {
      Podcast podcast = (PodcastBuilder(json['id'], json['title'])
            ..description = json['description']
            ..thumbnailUrl = json['artwork']
            ..audioUrl = json['mp3'])
          .build();
      list.add(podcast);
    }
    return list.asObservable();
  }

  Future<Podcast> getPodcast(String id) async {
    var response = await dio.get("episodes/view/$id");
    var episode = response.data['episode'];
    Podcast podcast =
        (PodcastBuilder(episode.data['id'], response.data['title'])
              ..description = response.data['description']
              ..thumbnailUrl = response.data['artwork']
              ..audioUrl = response.data['mp3'])
            .build();

    return podcast;
  }
}
