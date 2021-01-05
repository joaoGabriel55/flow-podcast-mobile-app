class Podcast {
  final String id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String audioUrl;
  bool isFavorite;

  Podcast._builder(PodcastBuilder builder)
      : id = builder.id,
        title = builder.title,
        description = builder.description,
        thumbnailUrl = builder.thumbnailUrl,
        audioUrl = builder.audioUrl,
        isFavorite = builder.isFavorite;
}

class PodcastBuilder {
  final String id;
  final String title;
  final bool isFavorite;

  PodcastBuilder(this.id, this.title, this.isFavorite);

  String description;
  String thumbnailUrl;
  String audioUrl;

  Podcast build() {
    return Podcast._builder(this);
  }
}
