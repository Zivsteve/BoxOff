import 'package:boxoff/constants.dart' as Constants;
import 'package:http/http.dart' as http;

class ContentService {
  static Future<http.Response> getNews() async {
    try {
      return http.get('${Constants.API_URL}/news');
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response> getTopMovies() async {
    try {
      return http.get('${Constants.API_URL}/top/movies');
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response> getStatTable([String type = '']) async {
    try {
      return http.get('${Constants.API_URL}/stat/$type');
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response> getUpcomingMovies() async {
    try {
      return http.get('${Constants.API_URL}/upcoming');
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response> getNowPlayingMovies() async {
    try {
      return http.get('${Constants.API_URL}/now_playing');
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response> getMovie(String title, [bool stats = false]) async {
    try {
      return http.get('${Constants.API_URL}/movie/$title?stats=$stats');
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response> getSearchAutocomplete(String query) async {
    try {
      return http.get('${Constants.API_URL}/search/$query?autocomplete');
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response> getSearchResults(String query) async {
    try {
      return http.get('${Constants.API_URL}/search/$query');
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response> getArticle(String url) async {
    try {
      return http.get('${Constants.API_URL}/article?url=$url');
    } catch (e) {
      return null;
    }
  }

  static Future<http.Response> getPerson(String id) async {
    try {
      return http.get('${Constants.API_URL}/person/$id');
    } catch (e) {
      return null;
    }
  }
}
