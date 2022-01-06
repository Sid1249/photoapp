
class EndPoints {

  static bool _showStaging = true;

  static String _baseUrl = "https://jsonplaceholder.typicode.com/";

  static String get get_todo =>
      _baseUrl + 'todos/{0}';
}