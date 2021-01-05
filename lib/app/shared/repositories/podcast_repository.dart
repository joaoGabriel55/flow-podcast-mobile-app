import 'package:dio/dio.dart';
import 'package:flowpdc_app/app/shared/models/podcast.dart';
import 'package:mobx/mobx.dart';

class PodcastRepository {
  final Dio dio;

  PodcastRepository(this.dio);

  Future<ObservableList<Podcast>> getAllPodcasts() async {
    try {
      var payload = {
        "params": {"filter": "episodes"}
      };

      var response = await dio.post("episodes/list", data: payload);
      List<Podcast> list = [];
      for (var json in (response.data['episodes'] as List)) {
        Podcast podcast = (PodcastBuilder(json['id'], json['title'], false)
              ..description = json['description']
              ..thumbnailUrl = json['artwork']
              ..audioUrl = json['mp3'])
            .build();
        list.add(podcast);
      }
      return list.asObservable();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Podcast> getPodcast(String id) async {
    try {
      var response = await dio.get("episodes/view/$id");
      var episode = response.data['episode'];
      Podcast podcast =
          (PodcastBuilder(episode['id'], episode['title'], false)
                ..description = episode['description']
                ..thumbnailUrl = episode['artwork']
                ..audioUrl = episode['mp3'])
              .build();

      return podcast;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
