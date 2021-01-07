import 'package:dio/dio.dart';
import 'package:flowpdc_app/app/shared/models/podcast.dart';

class PodcastResponse {
  String next;
  Map<String, Podcast> podcastMap;

  PodcastResponse(String next, Map<String, Podcast> podcastMap) {
    this.next = next;
    this.podcastMap = podcastMap;
  }
}

class PodcastRepository {
  final Dio dio;

  PodcastRepository(this.dio);

  Future<PodcastResponse> getAllPodcasts() async {
    try {
      var pagingParams = {
        "params": {"filter": "episodes"}
      };
      return await _loadPodcasts(pagingParams);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PodcastResponse> loadMorePodcasts(String nextPaging) async {
    try {
      var pagingParams = {
        "params": {
          "filter": "episodes",
          "paging": {"next": nextPaging, "previous": null}
        }
      };
      PodcastResponse result = await _loadPodcasts(pagingParams);
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PodcastResponse> _loadPodcasts(pagingParams) async {
    try {
      var response = await dio.post("episodes/list", data: pagingParams);
      Map<String, Podcast> podcastMap = {};
      for (var json in (response.data['episodes'] as List)) {
        Podcast podcast = (PodcastBuilder(json['id'], json['title'], false)
              ..description = json['description']
              ..thumbnailUrl = json['artwork']
              ..audioUrl = json['mp3'])
            .build();
        podcastMap[podcast.id] = podcast;
      }
      String nextParameter = response.data["paging"]["next"];
      PodcastResponse result = PodcastResponse(nextParameter, podcastMap);
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Podcast> getPodcast(String id) async {
    try {
      var response = await dio.get("episodes/view/$id");
      var episode = response.data['episode'];
      Podcast podcast = (PodcastBuilder(episode['id'], episode['title'], false)
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
