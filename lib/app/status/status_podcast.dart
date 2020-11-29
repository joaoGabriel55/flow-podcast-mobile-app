enum StatusPodcast { ERROR, SUCCESS, LOADING, INITIAL }

extension StatusPodcastExt on StatusPodcast {
  static String _mensagem;
  String get getMensagem => _mensagem;
  set setMensagem(String value) => _mensagem = value;
}
