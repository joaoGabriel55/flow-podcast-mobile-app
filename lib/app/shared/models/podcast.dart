class Podcast {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String audioUrl;

  Podcast._builder(PodcastBuilder builder)
      : id = builder.id,
        title = builder.title,
        description = builder.description,
        thumbnailUrl = builder.thumbnailUrl,
        audioUrl = builder.audioUrl;
}

class PodcastBuilder {
  final String id;
  final String title;

  PodcastBuilder(this.id, this.title);

  String description;
  String thumbnailUrl;
  String audioUrl;

  Podcast build() {
    return Podcast._builder(this);
  }
}
