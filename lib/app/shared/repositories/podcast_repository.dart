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

  Future<PodcastResponse> getAllPodcasts({String podcastName}) async {
    try {
      var pagingParams = {
        "params": {"filter": "episodes"}
      };
      return await _loadPodcasts(
        pagingParams: pagingParams,
        podcastName: podcastName,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PodcastResponse> loadMorePodcasts({
    String nextPaging,
    String podcastName,
  }) async {
    try {
      Map pagingParams = {
        "params": {
          "filter": "episodes",
          "paging": {"next": nextPaging, "previous": null}
        }
      };
      PodcastResponse result = await _loadPodcasts(
        pagingParams: pagingParams,
        podcastName: podcastName,
      );
      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PodcastResponse> _loadPodcasts({
    String podcastName,
    Map pagingParams,
  }) async {
    try {
      String uri = podcastName == null
          ? "episodes/list"
          : "episodes/list?creator_profile_name=$podcastName";
      var response = await dio.post(uri, data: pagingParams);
      Map<String, Podcast> podcastMap = {};
      String nextParameter = response.data["paging"]["next"];

      for (var json in (response.data['episodes'] as List)) {
        Podcast podcast = (PodcastBuilder(json['id'], json['title'], false)
              ..description = json['description']
              ..thumbnailUrl = json['artwork']
              ..audioUrl = json['mp3'])
            .build();
        podcastMap[podcast.id] = podcast;
      }

      PodcastResponse result = PodcastResponse(nextParameter, podcastMap);

      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Podcast> getPodcast(String id, {String podcastName}) async {
    try {
      String uri = podcastName == null
          ? "episodes/view/$id"
          : "episodes/view/$id?creator_profile_name=$podcastName";
      var response = await dio.get(uri);
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
