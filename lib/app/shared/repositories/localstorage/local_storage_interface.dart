abstract class ILocalStorage {
  Future<List<String>> get(String value);
  Future put(String key, List<String> value);
  Future delete(String key);
}
